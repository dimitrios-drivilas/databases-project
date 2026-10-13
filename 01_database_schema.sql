-- =============================================================================
-- ΑΡΧΕΙΟ 1: ΔΟΜΗ ΒΑΣΗΣ ΔΕΔΟΜΕΝΩΝ (DATABASE SCHEMA / DDL)
-- =============================================================================

DROP DATABASE IF EXISTS recruitment_db;
CREATE DATABASE recruitment_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE recruitment_db;

-- 1. Πίνακας Εταιρειών
CREATE TABLE etaireia (
    afm CHAR(9) NOT NULL,
    doy VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    tel VARCHAR(20) NOT NULL,
    street VARCHAR(50) NOT NULL,
    num INT UNSIGNED NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    CONSTRAINT pk_etaireia PRIMARY KEY (afm)
) ENGINE=InnoDB;

-- 2. Κεντρικός Πίνακας Χρηστών
CREATE TABLE `user` (
    username VARCHAR(30) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    reg_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    email VARCHAR(100) NOT NULL,
    CONSTRAINT pk_user PRIMARY KEY (username),
    CONSTRAINT uq_user_email UNIQUE (email)
) ENGINE=InnoDB;

-- 3. Πίνακας Αξιολογητών
CREATE TABLE evaluator (
    username VARCHAR(30) NOT NULL,
    exp_years TINYINT UNSIGNED NOT NULL DEFAULT 0,
    firm CHAR(9) NOT NULL,
    CONSTRAINT pk_evaluator PRIMARY KEY (username),
    CONSTRAINT fk_evaluator_user FOREIGN KEY (username) 
        REFERENCES `user`(username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_evaluator_firm FOREIGN KEY (firm) 
        REFERENCES etaireia(afm) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4. Πίνακας Υποψηφίων / Εργαζομένων
CREATE TABLE employee (
    username VARCHAR(30) NOT NULL,
    bio TEXT,
    sistatikes VARCHAR(255),
    certificates VARCHAR(255),
    CONSTRAINT pk_employee PRIMARY KEY (username),
    CONSTRAINT fk_employee_user FOREIGN KEY (username) 
        REFERENCES `user`(username) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. Πίνακας Διαχειριστών Βάσης (DBA)
CREATE TABLE dba (
    username VARCHAR(30) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE DEFAULT NULL,
    CONSTRAINT pk_dba PRIMARY KEY (username, start_date),
    CONSTRAINT fk_dba_user FOREIGN KEY (username) 
        REFERENCES `user`(username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_dba_dates CHECK (end_date IS NULL OR end_date >= start_date)
) ENGINE=InnoDB;

-- 6. Πίνακας Γλωσσών Υποψηφίου (3NF)
CREATE TABLE candidate_language (
    candid VARCHAR(30) NOT NULL,
    lang_code ENUM('EN', 'FR', 'SP', 'GE', 'CH', 'GR') NOT NULL,
    CONSTRAINT pk_cand_lang PRIMARY KEY (candid, lang_code),
    CONSTRAINT fk_cand_lang_employee FOREIGN KEY (candid) 
        REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7. Πίνακας Έργων (Projects)
CREATE TABLE project (
    candid VARCHAR(30) NOT NULL,
    num TINYINT UNSIGNED NOT NULL,
    descr TEXT NOT NULL,
    url VARCHAR(255),
    CONSTRAINT pk_project PRIMARY KEY (candid, num),
    CONSTRAINT fk_project_employee FOREIGN KEY (candid) 
        REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 8. Κατάλογος Πτυχίων / Τίτλων Σπουδών
CREATE TABLE degree (
    titlos VARCHAR(150) NOT NULL,
    idryma VARCHAR(150) NOT NULL,
    bathmida ENUM('BSc', 'MSc', 'PhD') NOT NULL,
    CONSTRAINT pk_degree PRIMARY KEY (titlos, idryma)
) ENGINE=InnoDB;

-- 9. Πτυχία που κατέχει ο Υποψήφιος
CREATE TABLE has_degree (
    cand_usrname VARCHAR(30) NOT NULL,
    degr_title VARCHAR(150) NOT NULL,
    degr_idryma VARCHAR(150) NOT NULL,
    etos YEAR NOT NULL,
    grade DECIMAL(4, 2) NOT NULL,
    CONSTRAINT pk_has_degree PRIMARY KEY (cand_usrname, degr_title, degr_idryma),
    CONSTRAINT fk_has_degree_cand FOREIGN KEY (cand_usrname) 
        REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_has_degree_degree FOREIGN KEY (degr_title, degr_idryma) 
        REFERENCES degree(titlos, idryma) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_degree_grade CHECK (grade >= 0.00 AND grade <= 10.00)
) ENGINE=InnoDB;

-- 10. Γνωστικά Αντικείμενα (Ιεραρχικά)
CREATE TABLE `subject` (
    title VARCHAR(60) NOT NULL,
    descr TINYTEXT,
    belongs_to VARCHAR(60) DEFAULT NULL,
    CONSTRAINT pk_subject PRIMARY KEY (title),
    CONSTRAINT fk_subject_parent FOREIGN KEY (belongs_to) 
        REFERENCES `subject`(title) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 11. Θέσεις Εργασίας
CREATE TABLE job (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    start_date DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    position VARCHAR(100) NOT NULL,
    edra VARCHAR(100) NOT NULL,
    evaluator VARCHAR(30) NOT NULL,
    announce_date DATETIME NOT NULL,
    submission_date DATE NOT NULL,
    CONSTRAINT pk_job PRIMARY KEY (id),
    CONSTRAINT fk_job_evaluator FOREIGN KEY (evaluator) 
        REFERENCES evaluator(username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_submission_date CHECK (submission_date >= announce_date)
) ENGINE=InnoDB;

-- 12. Απαιτήσεις Θέσεων
CREATE TABLE requires (
    job_id INT UNSIGNED NOT NULL,
    subject_title VARCHAR(60) NOT NULL,
    CONSTRAINT pk_requires PRIMARY KEY (job_id, subject_title),
    CONSTRAINT fk_requires_job FOREIGN KEY (job_id) 
        REFERENCES job(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_requires_subject FOREIGN KEY (subject_title) 
        REFERENCES `subject`(title) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 13. Αιτήσεις Υποψηφίων
CREATE TABLE applies (
    cand_usrname VARCHAR(30) NOT NULL,
    job_id INT UNSIGNED NOT NULL,
    katastash_ait ENUM('ENERGH', 'OLOKLHROMENH', 'AKYROMENH') NOT NULL DEFAULT 'ENERGH',
    arithmos_ait INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hmerominia_ait DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_applies PRIMARY KEY (cand_usrname, job_id),
    CONSTRAINT uq_applies_num UNIQUE (arithmos_ait),
    CONSTRAINT fk_applies_cand FOREIGN KEY (cand_usrname) 
        REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_applies_job FOREIGN KEY (job_id) 
        REFERENCES job(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 14. Αξιολογήσεις Υποψηφίων
CREATE TABLE evaluate (
    eva_usr VARCHAR(30) DEFAULT NULL,
    eva_usr2 VARCHAR(30) DEFAULT NULL,
    em_usr VARCHAR(30) NOT NULL,
    j_id INT UNSIGNED NOT NULL,
    evaluation INT DEFAULT NULL,
    evaluation2 INT DEFAULT NULL,
    firm CHAR(9) NOT NULL,
    applie_num INT UNSIGNED NOT NULL,
    CONSTRAINT pk_evaluate PRIMARY KEY (em_usr, j_id),
    CONSTRAINT fk_evaluate_firm FOREIGN KEY (firm) 
        REFERENCES etaireia(afm) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_evaluate_eva1 FOREIGN KEY (eva_usr) 
        REFERENCES evaluator(username) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_evaluate_eva2 FOREIGN KEY (eva_usr2) 
        REFERENCES evaluator(username) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_evaluate_emp FOREIGN KEY (em_usr) 
        REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_evaluate_job FOREIGN KEY (j_id) 
        REFERENCES job(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 15. Πίνακας Ιστορικού / Audit Log για Ενέργειες Αιτήσεων & Αξιολογήσεων
CREATE TABLE audit_log (
    log_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    table_name VARCHAR(50) NOT NULL,
    action_type VARCHAR(20) NOT NULL,
    record_id VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    action_timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_audit_log PRIMARY KEY (log_id)
) ENGINE=InnoDB;
