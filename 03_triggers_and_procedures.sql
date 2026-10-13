-- =============================================================================
-- ΑΡΧΕΙΟ 3: TRIGGERS ΚΑΙ STORED PROCEDURES (BUSINESS LOGIC)
-- =============================================================================

USE recruitment_db;

DELIMITER //

-- =============================================================================
-- 1. TRIGGERS
-- =============================================================================

-- TRIGGER 1: Έλεγχος πριν την υποβολή αίτησης (Εμπρόθεσμη υποβολή)
DROP TRIGGER IF EXISTS trg_before_insert_applies //
CREATE TRIGGER trg_before_insert_applies
BEFORE INSERT ON applies
FOR EACH ROW
BEGIN
    DECLARE v_sub_date DATE;
    
    -- Ανάκτηση καταληκτικής ημερομηνίας υποβολής της θέσης
    SELECT submission_date INTO v_sub_date
    FROM job
    WHERE id = NEW.job_id;
    
    -- Έλεγχος αν η ημερομηνία αίτησης είναι μετά τη λήξη υποβολών
    IF DATE(NEW.hmerominia_ait) > v_sub_date THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Σφάλμα: Η καταληκτική ημερομηνία υποβολής αιτήσεων για τη θέση αυτή έχει παρέλθει.';
    END IF;
END //


-- TRIGGER 2: Καταγραφή στο Audit Log μετά από κάθε αλλαγή κατάστασης αίτησης
DROP TRIGGER IF EXISTS trg_after_update_applies //
CREATE TRIGGER trg_after_update_applies
AFTER UPDATE ON applies
FOR EACH ROW
BEGIN
    IF OLD.katastash_ait <> NEW.katastash_ait THEN
        INSERT INTO audit_log (table_name, action_type, record_id, description, action_timestamp)
        VALUES (
            'applies',
            'UPDATE_STATUS',
            CONCAT(NEW.cand_usrname, '-', NEW.job_id),
            CONCAT('Αλλαγή κατάστασης αίτησης από "', OLD.katastash_ait, '" σε "', NEW.katastash_ait, '".'),
            NOW()
        );
    END IF;
END //


-- TRIGGER 3: Έλεγχος ορθότητας βαθμολογίας πριν την ενημέρωση αξιολόγησης (0 - 20)
DROP TRIGGER IF EXISTS trg_before_update_evaluate //
CREATE TRIGGER trg_before_update_evaluate
BEFORE UPDATE ON evaluate
FOR EACH ROW
BEGIN
    IF (NEW.evaluation IS NOT NULL AND (NEW.evaluation < 0 OR NEW.evaluation > 20)) OR
       (NEW.evaluation2 IS NOT NULL AND (NEW.evaluation2 < 0 OR NEW.evaluation2 > 20)) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Σφάλμα: Ο βαθμός αξιολόγησης πρέπει να βρίσκεται στο διάστημα 0 έως 20.';
    END IF;
END //


-- =============================================================================
-- 2. STORED PROCEDURES
-- =============================================================================

-- PROCEDURE 1: Υπολογισμός τελικού σκορ υποψηφίου (BSc=1, MSc=2, PhD=3, Prj=1, Lang=1)
DROP PROCEDURE IF EXISTS sp_evaluate_candidate //
CREATE PROCEDURE sp_evaluate_candidate(
    IN  p_evaluator VARCHAR(30),
    IN  p_employee  VARCHAR(30),
    IN  p_job_id    INT UNSIGNED,
    OUT p_grade     INT
)
proc: BEGIN
    DECLARE v_curr_grade INT DEFAULT NULL;
    DECLARE v_is_evaluator_valid BOOLEAN DEFAULT FALSE;

    -- Έλεγχος αν ο evaluator έχει ανατεθεί στη συγκεκριμένη αξιολόγηση
    SELECT 
        (eva_usr = p_evaluator OR eva_usr2 = p_evaluator),
        CASE WHEN eva_usr = p_evaluator THEN evaluation ELSE evaluation2 END
    INTO v_is_evaluator_valid, v_curr_grade
    FROM evaluate
    WHERE em_usr = p_employee AND j_id = p_job_id;

    IF v_is_evaluator_valid IS NULL OR v_is_evaluator_valid = FALSE THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Σφάλμα: Ο συγκεκριμένος αξιολογητής δεν έχει ανατεθεί στην αξιολόγηση του υποψηφίου.';
    END IF;

    -- Αν υπάρχει ήδη βαθμός, επιστροφή του υφιστάμενου βαθμού
    IF v_curr_grade IS NOT NULL THEN
        SET p_grade = v_curr_grade;
        LEAVE proc;
    END IF;

    -- Ενιαίος υπολογισμός συνολικής βαθμολογίας
    SELECT 
        COALESCE((
            SELECT SUM(CASE d.bathmida 
                WHEN 'BSc' THEN 1 
                WHEN 'MSc' THEN 2 
                WHEN 'PhD' THEN 3 
                ELSE 0 END)
            FROM has_degree hd
            JOIN degree d ON hd.degr_title = d.titlos AND hd.degr_idryma = d.idryma
            WHERE hd.cand_usrname = p_employee
        ), 0)
        +
        COALESCE((
            SELECT COUNT(*) 
            FROM project 
            WHERE candid = p_employee
        ), 0)
        +
        COALESCE((
            SELECT COUNT(*) 
            FROM candidate_language 
            WHERE candid = p_employee
        ), 0)
    INTO p_grade;

    -- Ενημέρωση στον πίνακα evaluate
    UPDATE evaluate
    SET evaluation = CASE WHEN eva_usr = p_evaluator THEN p_grade ELSE evaluation END,
        evaluation2 = CASE WHEN eva_usr2 = p_evaluator THEN p_grade ELSE evaluation2 END
    WHERE em_usr = p_employee AND j_id = p_job_id;

END proc //


-- PROCEDURE 2: Διαχείριση Αιτήσεων (Apply, Cancel, Activate)
DROP PROCEDURE IF EXISTS sp_manage_application //
CREATE PROCEDURE sp_manage_application(
    IN p_employee VARCHAR(30),
    IN p_job_id   INT UNSIGNED,
    IN p_action   CHAR(1) -- 'i' = Apply, 'c' = Cancel, 'a' = Activate
)
proc: BEGIN
    DECLARE v_eva1 VARCHAR(30);
    DECLARE v_eva2 VARCHAR(30);
    DECLARE v_firm CHAR(9);
    DECLARE v_status ENUM('ENERGH', 'OLOKLHROMENH', 'AKYROMENH');
    DECLARE v_new_eva VARCHAR(30);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    CASE p_action
        -- Υποβολή Αίτησης
        WHEN 'i' THEN
            IF EXISTS (SELECT 1 FROM applies WHERE cand_usrname = p_employee AND job_id = p_job_id) THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Υπάρχει ήδη υποβληθείσα αίτηση για αυτή τη θέση.';
            END IF;

            SELECT eva_usr, eva_usr2, firm 
            INTO v_eva1, v_eva2, v_firm
            FROM evaluate
            WHERE em_usr = p_employee AND j_id = p_job_id;

            -- Αυτόματη ανάθεση recruiter εάν είναι κενός
            IF (v_eva1 IS NULL OR v_eva1 = '') AND (v_eva2 IS NOT NULL AND v_eva2 <> '') THEN
                SELECT username INTO v_new_eva
                FROM evaluator
                WHERE firm = v_firm AND username <> v_eva2
                LIMIT 1;

                UPDATE evaluate 
                SET eva_usr = v_new_eva 
                WHERE em_usr = p_employee AND j_id = p_job_id;

            ELSEIF (v_eva2 IS NULL OR v_eva2 = '') AND (v_eva1 IS NOT NULL AND v_eva1 <> '') THEN
                SELECT username INTO v_new_eva
                FROM evaluator
                WHERE firm = v_firm AND username <> v_eva1
                LIMIT 1;

                UPDATE evaluate 
                SET eva_usr2 = v_new_eva 
                WHERE em_usr = p_employee AND j_id = p_job_id;
            END IF;

            INSERT INTO applies (cand_usrname, job_id, katastash_ait, hmerominia_ait)
            VALUES (p_employee, p_job_id, 'ENERGH', NOW());

        -- Ακύρωση Αίτησης
        WHEN 'c' THEN
            SELECT katastash_ait INTO v_status
            FROM applies
            WHERE cand_usrname = p_employee AND job_id = p_job_id;

            IF v_status IS NULL THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Δεν βρέθηκε αίτηση για τον συγκεκριμένο υποψήφιο στη θέση αυτή.';
            ELSEIF v_status = 'AKYROMENH' THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Η αίτηση είναι ήδη σε κατάσταση ΑΚΥΡΩΜΕΝΗ.';
            ELSE
                UPDATE applies 
                SET katastash_ait = 'AKYROMENH'
                WHERE cand_usrname = p_employee AND job_id = p_job_id;
            END IF;

        -- Επανενεργοποίηση Αίτησης
        WHEN 'a' THEN
            SELECT katastash_ait INTO v_status
            FROM applies
            WHERE cand_usrname = p_employee AND job_id = p_job_id;

            IF v_status IS NULL THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Δεν βρέθηκε αίτηση για τον συγκεκριμένο υποψήφιο στη θέση αυτή.';
            ELSEIF v_status = 'ENERGH' THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Η αίτηση είναι ήδη ΕΝΕΡΓΗ.';
            ELSE
                UPDATE applies 
                SET katastash_ait = 'ENERGH'
                WHERE cand_usrname = p_employee AND job_id = p_job_id;
            END IF;

        ELSE
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Μη έγκυρη ενέργεια. Επιλέξτε "i" (apply), "c" (cancel), "a" (activate).';
    END CASE;

    COMMIT;
END proc //

DELIMITER ;
