-- =============================================================================
-- ΑΡΧΕΙΟ 2: ΕΙΣΑΓΩΓΗ ΔΕΔΟΜΕΝΩΝ (INSERTS / DML)
-- =============================================================================

USE recruitment_db;

-- 1. Εταιρείες
INSERT INTO etaireia (afm, doy, name, tel, street, num, city, country) VALUES
  ('689245719', 'B Patras', 'BASE O.E.', '0341404784', 'Agiou Andreou', 9, 'Patra', 'Greece'),
  ('097466760', 'B Athinas', 'RETROCOMPUTER', '2957683873', 'kolonaki', 4, 'Athina', 'Greece'),
  ('502006561', 'C Athinas', 'Prontix', '4394854128', 'ermou', 1, 'Athina', 'Greece'),
  ('187882620', 'C Patras', 'UPTIME', '8137448242', 'mezonos', 6, 'Patra', 'Greece'),
  ('836038422', 'LIV 390 UK', 'Quadbot', '4526038945', 'anfield', 2, 'Liverpool', 'United Kingdom'),
  ('042456375', 'TOUL 890 FR', 'Afterhours', '8471303064', 'toulouse', 3, 'Toulouse', 'France'),
  ('AT1096780', 'Patrwn', 'Xaplopoulos AE', '2610425789', 'Olympou', 15, 'Patras', 'Greece'),
  ('AT1084560', 'Athinwn', 'Metafores Papadousis', '2610784111', 'Saxtourh', 13, 'Patras', 'Greece'),
  ('AT1126780', 'Patrwn', 'Nikolopoulos AE', '2610425229', 'Notara', 5, 'Patras', 'Greece');

-- 2. Χρήστες
INSERT INTO `user` (username, password_hash, first_name, last_name, reg_date, email) VALUES
  ('dimifos', '$2y$10$eHashDimitrisFolos123456789012345', 'Dimitris', 'Folos', '2021-08-03 14:22:45', 'dimifos@yahoo.com'),
  ('makgr', '$2y$10$eHashMakisGrigoriou12345678901234', 'Makis', 'Grigoriou', '2019-09-05 09:08:17', 'makgr@yahoo.com'),
  ('maripi', '$2y$10$eHashMariaPiliou1234567890123456', 'Maria', 'Piliou', '2023-04-15 16:33:59', 'maripi@gmail.com'),
  ('jiovani', '$2y$10$eHashJiovaniPapadop1234567890123', 'Jiovani', 'Papadopoulos', '2020-01-07 11:45:21', 'jiovani@gmail.com'),
  ('rexti', '$2y$10$eHashRexTitilas12345678901234567', 'Rex', 'Titilas', '2017-08-09 18:10:04', 'rexti@gmail.com'),
  ('balios', '$2y$10$eHashGiannisBalop123456789012345', 'Giannis', 'Balopoulos', '2022-05-29 20:55:36', 'balios@hotmail.com'),
  ('cocos', '$2y$10$eHashAlexandrosGeor1234567890123', 'Alexandros', 'Georgiou', '2016-07-05 05:27:13', 'cocos@hotmail.com'),
  ('eleniPap', '$2y$10$eHashEleniPapadop12345678901234', 'Eleni', 'Papadopoulou', '2019-10-15 00:00:00', 'eleni.pap@gmail.com'),
  ('nikosKouk', '$2y$10$eHashNikosKoukou12345678901234', 'Nikos', 'Koukou', '2020-02-28 00:00:00', 'nikos.kouk@gmail.com'),
  ('mariaStam', '$2y$10$eHashMariaStamat12345678901234', 'Maria', 'Stamatopoulou', '2021-01-07 00:00:00', 'maria.stam@gmail.com'),
  ('dimitrisKara', '$2y$10$eHashDimitrisKara123456789012', 'Dimitris', 'Karagiannis', '2021-05-20 00:00:00', 'dimitris.kara@gmail.com'),
  ('athinaPap', '$2y$10$eHashAthinaPapadop123456789012', 'Athina', 'Papadopoulos', '2021-09-03 00:00:00', 'athina.pap@gmail.com'),
  ('nik99', '$2y$10$eHashNikosDipos1234567890123456', 'Nikos', 'Dipos', '2019-03-01 00:00:00', 'nikdip99@gmail.com'),
  ('mary94', '$2y$10$eHashMariaDipou1234567890123456', 'Maria', 'Dipou', '2019-03-01 00:00:00', 'marydip94@gmail.com'),
  ('kostas4', '$2y$10$eHashKostasKoukou1234567890123', 'Kostas', 'Koukou', '2019-03-11 00:00:00', 'kostaskouk@gmail.com'),
  ('stelaras', '$2y$10$eHashSteliosDiog12345678901234', 'Stelios', 'Diogenous', '2019-05-11 00:00:00', 'steliosdiog@gmail.com'),
  ('Petros12', '$2y$10$eHashPetrosPetrou1234567890123', 'Petros', 'Petrou', '2020-05-11 00:00:00', 'petrospetrou@gmail.com'),
  ('Anastasia4', '$2y$10$eHashAnastasiaMak1234567890123', 'Anastasia', 'Makali', '2020-08-01 00:00:00', 'anstasiamk@gmail.com'),
  ('nikhftw', '$2y$10$eHashNikhMiliou123456789012345', 'Nikh', 'Miliou', '2020-08-01 00:00:00', 'NikhMl@gmail.com'),
  ('anthigr', '$2y$10$eHashAnthiGrigor12345678901234', 'Anthi', 'Grigoropoulou', '2018-07-12 08:16:33', 'anthigr@yahoo.com'),
  ('gewrgiafr', '$2y$10$eHashGewrgiaFrag12345678901234', 'Gewrgia', 'Fragkoyli', '2019-10-25 19:43:18', 'gewrgiafr@yahoo.com'),
  ('petrodi', '$2y$10$eHashPetrosDilig12345678901234', 'Petros', 'Diligkas', '2020-12-09 05:28:52', 'petrodi@gmail.com'),
  ('roxane', '$2y$10$eHashRoxanaAntipa1234567890123', 'Roxana', 'Antipa', '2021-04-30 10:15:27', 'roxane@gmail.com'),
  ('velouris', '$2y$10$eHashAntreasVelos1234567890123', 'Antreas', 'Velos', '2022-01-17 18:50:09', 'velouris@hotmail.com'),
  ('filip', '$2y$10$eHashFiliposPapag1234567890123', 'Filipos', 'Papagewrgiou', '2023-08-20 21:12:37', 'filip@hotmail.com');

-- 3. Αξιολογητές
INSERT INTO evaluator (username, exp_years, firm) VALUES
  ('dimifos', 6, '689245719'),
  ('makgr', 1, '097466760'),
  ('maripi', 8, '502006561'),
  ('jiovani', 3, '187882620'),
  ('rexti', 7, '836038422'),
  ('balios', 9, '042456375'),
  ('cocos', 15, '689245719'),
  ('nikosKouk', 3, 'AT1084560'),
  ('Anastasia4', 3, 'AT1084560'),
  ('athinaPap', 2, 'AT1084560'),
  ('dimitrisKara', 2, 'AT1084560'),
  ('mariaStam', 2, 'AT1126780'),
  ('stelaras', 4, 'AT1126780');

-- 4. Εργαζόμενοι / Υποψήφιοι
INSERT INTO employee (username, bio, sistatikes, certificates) VALUES
  ('anthigr', 'Coding Innovator, Tech Explorer', 'anthigr_rec.pdf', 'anthigr_cert.pdf'),
  ('gewrgiafr', 'Data Enthusiast, Insight Builder', 'gewrgiafr_rec.pdf', 'gewrgiafr_cert.pdf'),
  ('petrodi', 'Digital Defender, Risk Mitigator', 'petrodi_rec.pdf', 'petrodi_cert.pdf'),
  ('roxane', 'Experience Creator, Design Maverick', 'roxane_rec.pdf', 'roxane_cert.pdf'),
  ('velouris', 'AI Pioneer, Innovation Seeker', 'velouris_rec.pdf', 'velouris_cert.pdf'),
  ('filip', 'System Builder, Scalability Expert', 'filip_rec.pdf', 'filip_cert.pdf'),
  ('kostas4', 'Kostas is 28, has a degree and a lot of experience', '', ''),
  ('mary94', 'Mary is 32 and recently got promoted', '', ''),
  ('nik99', 'Nikos is a valuable asset!', '', ''),
  ('nikhftw', 'Nikh has two degrees.', '', ''),
  ('Petros12', 'Petros is only 22 years old', '', ''),
  ('eleniPap', 'Helen is 25 years old and has a degree.', '', '');

-- 5. DBA
INSERT INTO dba (username, start_date, end_date) VALUES
  ('dimifos', '2021-07-27', '2023-09-20'),
  ('makgr', '2020-08-01', NULL);

-- 6. Γλώσσες Υποψηφίων
INSERT INTO candidate_language (candid, lang_code) VALUES
  ('anthigr', 'EN'), ('anthigr', 'SP'), ('anthigr', 'GE'), ('anthigr', 'GR'),
  ('gewrgiafr', 'FR'), ('gewrgiafr', 'GE'), ('gewrgiafr', 'CH'), ('gewrgiafr', 'GR'),
  ('petrodi', 'EN'), ('petrodi', 'FR'), ('petrodi', 'SP'), ('petrodi', 'GE'), ('petrodi', 'CH'), ('petrodi', 'GR'),
  ('roxane', 'EN'), ('roxane', 'SP'), ('roxane', 'GE'), ('roxane', 'CH'),
  ('velouris', 'EN'), ('velouris', 'SP'), ('velouris', 'CH'), ('velouris', 'GR'),
  ('filip', 'EN'), ('filip', 'GR'),
  ('eleniPap', 'EN'),
  ('Petros12', 'FR'),
  ('kostas4', 'SP'),
  ('mary94', 'CH');

-- 7. Projects
INSERT INTO project (candid, num, descr, url) VALUES
  ('anthigr', 1, 'Data Visualization with Python', 'https://github.com/anthigr/data-viz-python'),
  ('anthigr', 2, 'Game Development in Java', 'https://github.com/anthigr/java-game-dev'),
  ('gewrgiafr', 1, 'Deep Learning Projects', 'https://github.com/gewrgiafr/deep-learning-projects'),
  ('gewrgiafr', 2, 'Autonomous Robot Prototypes', 'https://github.com/gewrgiafr/autonomous-robots'),
  ('petrodi', 1, 'Concept Art and Illustrations', 'https://github.com/petrodi/concept-art-illustrations'),
  ('petrodi', 2, 'IoT Embedded Firmware', 'https://github.com/petrodi/iot-embedded-firmware'),
  ('roxane', 1, 'Responsive Web Design', 'https://github.com/roxane/responsive-web-design'),
  ('roxane', 2, 'Network Security Protocols', 'https://github.com/roxane/network-security-protocols'),
  ('filip', 1, 'E-commerce Web Solutions', 'https://github.com/filip/ecommerce-web-solutions'),
  ('filip', 2, 'Algorithm Optimization', 'https://github.com/filip/algorithm-optimization'),
  ('nik99', 1, 'Designed a modern day CPU', ''),
  ('kostas4', 2, 'Made a videogame using C++', ''),
  ('eleniPap', 3, 'Recreated the tic-tac-toe game using Java', ''),
  ('Petros12', 4, 'Wrote a paper about A.I', ''),
  ('mary94', 5, 'Made a website about her hometown', ''),
  ('nikhftw', 6, 'Made a website about a local zoo', ''),
  ('nik99', 7, 'Made a humidity and temperature sensor using Arduino', ''),
  ('mary94', 8, 'Made a thermal camera', ''),
  ('Petros12', 9, 'Made a random number generator', '');

-- 8. Τίτλοι Σπουδών
INSERT INTO degree (titlos, idryma, bathmida) VALUES
  ('Bachelor in digital systems', 'Athens University', 'MSc'),
  ('Bachelor of Science in Computer and Informatics Engineering', 'Samos University', 'BSc'),
  ('Master of Science in Network Design and Analysis', 'Polytexneio Thessalonikis', 'MSc'),
  ('Science in Robotics Modeling', 'Oxford University', 'MSc'),
  ('Doctorate in Artificial Intelligence', 'Liverpool University', 'PhD'),
  ('Doctorate in Information Retrieval', 'MIT', 'PhD'),
  ('Bachelor of Science in Advanced Network Technologies', 'Rhodes University', 'BSc'),
  ('Computer Engineer', 'Patra University', 'BSc'),
  ('Electrical Engineer', 'Athens University', 'MSc'),
  ('Doctorate in Advanced Graphics', 'Oxford University', 'PhD'),
  ('Doctorate Complexity and Efficiency in Algorithms', 'Kalamata University', 'PhD'),
  ('Master in Big Data Structures and Algorithms', 'MIT', 'MSc'),
  ('Mathematics', 'Ioannina University', 'MSc'),
  ('Computer Engineering', 'University of Patras', 'MSc'),
  ('Electrical Engineering', 'University of Patras', 'MSc'),
  ('Computer Science', 'University of Ioannina', 'MSc'),
  ('Electrical Engineering', 'University of Athens', 'MSc'),
  ('Mechanical Engineering', 'University of Athens', 'MSc'),
  ('Bioinformatics', 'UCLA', 'PhD');

-- 9. Πτυχία Υποψηφίων
INSERT INTO has_degree (cand_usrname, degr_title, degr_idryma, etos, grade) VALUES
  ('anthigr', 'Bachelor in digital systems', 'Athens University', 1989, 6.20),
  ('anthigr', 'Bachelor of Science in Computer and Informatics Engineering', 'Samos University', 2020, 9.20),
  ('gewrgiafr', 'Master of Science in Network Design and Analysis', 'Polytexneio Thessalonikis', 2002, 8.00),
  ('gewrgiafr', 'Science in Robotics Modeling', 'Oxford University', 1999, 9.60),
  ('petrodi', 'Doctorate in Artificial Intelligence', 'Liverpool University', 2008, 8.50),
  ('petrodi', 'Doctorate in Information Retrieval', 'MIT', 2009, 6.60),
  ('roxane', 'Bachelor of Science in Advanced Network Technologies', 'Rhodes University', 2007, 8.00),
  ('roxane', 'Computer Engineer', 'Patra University', 2015, 8.00),
  ('velouris', 'Electrical Engineer', 'Athens University', 2002, 6.40),
  ('velouris', 'Doctorate in Advanced Graphics', 'Oxford University', 2009, 9.40),
  ('filip', 'Doctorate Complexity and Efficiency in Algorithms', 'Kalamata University', 2005, 8.20),
  ('filip', 'Master in Big Data Structures and Algorithms', 'MIT', 2009, 9.00),
  ('filip', 'Mathematics', 'Ioannina University', 2002, 9.20),
  ('Petros12', 'Mechanical Engineering', 'University of Athens', 2020, 7.80),
  ('kostas4', 'Computer Engineering', 'University of Patras', 2019, 6.00),
  ('eleniPap', 'Electrical Engineering', 'University of Patras', 2019, 7.50),
  ('eleniPap', 'Bioinformatics', 'UCLA', 2021, 6.00);

-- 10. Γνωστικά Αντικείμενα
INSERT INTO `subject` (title, descr, belongs_to) VALUES
  ('Information Technology', 'Digital Systems Integration', NULL),
  ('Data Management', 'Structured Data Control', 'Information Technology'),
  ('Machine Intelligence', 'Simulated Intelligent Systems', 'Information Technology'),
  ('Problem Solving Methods', 'Logical Problem-solving Procedures', 'Information Technology'),
  ('Connectivity Engineering', 'Network Design and Implementation', 'Information Technology'),
  ('Visual Design', 'Graphics and Image Representation', 'Information Technology'),
  ('Dynamic Animation', 'Moving Image Animation Techniques', 'Visual Design'),
  ('Sculpting in 3D', 'Three-dimensional Visual Creation', 'Visual Design'),
  ('Financial Software Analysis', 'Software for Financial Data Analysis', 'Visual Design'),
  ('Software Development', 'Application Building and Management', 'Information Technology'),
  ('Web Development', 'Internet Application Designing', 'Software Development'),
  ('Programming Paradigms', 'Programming Language Systems', 'Software Development'),
  ('Relational Data Handling', 'Structured Data Storage and Management', 'Data Management'),
  ('SQL Systems', 'Structured Query Language Data Systems', 'Data Management'),
  ('Hierarchical Data Systems', 'Nested Data Structure Systems', 'Data Management'),
  ('Robotics and Automation', 'Automated Machine Systems', 'Machine Intelligence'),
  ('Machine Learning', 'Autonomous Learning Systems', 'Machine Intelligence'),
  ('AI Engines', 'Artificial Intelligence Mechanisms', 'Machine Learning'),
  ('Natural Language Processing', 'Language Interpretation Models', 'Machine Learning'),
  ('Data Structure Models', 'Data Organization Models', 'Problem Solving Methods'),
  ('Computational Efficiency', 'Algorithmic Efficiency Evaluation', 'Problem Solving Methods'),
  ('Local Area Network Management', 'Local Network Systems Management', 'Connectivity Engineering'),
  ('Wide Area Network Management', 'Wide Network Systems Management', 'Connectivity Engineering'),
  ('Electrical Engineering', 'Description of Electrical Engineering', NULL),
  ('Electronics Engineering', 'Description of Electronics Engineering', 'Electrical Engineering'),
  ('Physics', 'Description of Physics', 'Electrical Engineering'),
  ('Software Engineering', 'Software Engineering Core', 'Information Technology'),
  ('Data Engineer', 'Description of Data Engineer', 'Software Engineering'),
  ('Data Scientist', 'Description of Data scientist', 'Software Engineering'),
  ('Data Architect', 'Description of Data Architect', 'Software Engineering'),
  ('Big Data Engineer', 'Description of Big Data Engineer', 'Software Engineering'),
  ('Computer Science', 'General Computer Science', 'Information Technology');

-- 11. Θέσεις Εργασίας
INSERT INTO job (id, start_date, salary, position, edra, evaluator, announce_date, submission_date) VALUES
  (1, '2024-01-01', 1650.00, 'Data Analyst', 'Patra, Greece', 'dimifos', '2021-07-10', '2022-02-25'),
  (2, '2024-02-01', 1350.00, 'Java Developer', 'Patra, Greece', 'makgr', '2022-08-15', '2023-09-15'),
  (3, '2024-02-01', 1100.00, 'Software Engineer', 'Patra, Greece', 'maripi', '2019-12-24', '2023-01-12'),
  (4, '2023-12-25', 2900.00, 'Game Developer', 'Patra, Greece', 'jiovani', '2021-10-10', '2021-11-10'),
  (5, '2024-03-01', 2500.00, 'Graphic Designer', 'Patra, Greece', 'rexti', '2021-10-10', '2023-02-01'),
  (6, '2023-03-01', 2100.00, 'Front-end Developer', 'Athens, Greece', 'balios', '2021-10-20', '2023-01-10'),
  (7, '2024-05-01', 1250.00, 'Back-end Developer', 'Athens, Greece', 'cocos', '2021-11-20', '2023-04-12'),
  (8, '2024-05-01', 1900.00, 'UI/UX Designer', 'Athens, Greece', 'dimifos', '2021-11-20', '2023-04-12'),
  (9, '2024-05-01', 1150.00, 'Database Administrator', 'Athens, Greece', 'makgr', '2021-11-20', '2023-04-12'),
  (10, '2024-04-01', 3100.00, 'Machine Learning Engineer', 'Toulouse, France', 'maripi', '2021-11-21', '2023-03-10'),
  (11, '2024-02-01', 2200.00, 'System Architect', 'Toulouse, France', 'jiovani', '2021-11-01', '2023-01-16'),
  (12, '2024-03-01', 2950.00, 'Quality Assurance Engineer', 'Liverpool, UK', 'rexti', '2021-11-01', '2023-01-03'),
  (12438011, '2023-12-20', 2000.00, 'senior developer', 'Patras', 'stelaras', '2023-09-10', '2023-11-28'),
  (12438010, '2023-12-20', 1600.00, 'junior developer', 'Patras', 'stelaras', '2023-09-10', '2023-11-28'),
  (12438009, '2023-12-01', 1600.00, 'junior developer', 'Patras', 'stelaras', '2023-09-05', '2023-11-25'),
  (12438008, '2023-12-01', 1600.00, 'junior developer', 'Patras', 'nikosKouk', '2023-09-05', '2023-11-25'),
  (12438007, '2023-09-01', 1800.00, 'web developer', 'Athens', 'nikosKouk', '2023-07-05', '2023-08-25'),
  (12438006, '2023-09-01', 1800.00, 'web developer', 'Athens', 'nikosKouk', '2023-07-05', '2023-08-25'),
  (12438005, '2023-09-08', 1800.00, 'web developer', 'Athens', 'Anastasia4', '2023-07-15', '2023-08-28'),
  (12438004, '2023-09-08', 2200.00, 'backend developer', 'Athens', 'Anastasia4', '2023-07-15', '2023-08-28');

-- 12. Απαιτήσεις Θέσεων (Requires)
INSERT INTO requires (job_id, subject_title) VALUES
  (1, 'Information Technology'),
  (1, 'Data Management'),
  (2, 'Machine Intelligence'),
  (2, 'Problem Solving Methods'),
  (3, 'Connectivity Engineering'),
  (3, 'Visual Design'),
  (4, 'Dynamic Animation'),
  (4, 'Sculpting in 3D'),
  (5, 'Financial Software Analysis'),
  (5, 'Software Development'),
  (6, 'Web Development'),
  (6, 'Programming Paradigms'),
  (7, 'Relational Data Handling'),
  (7, 'SQL Systems'),
  (8, 'Hierarchical Data Systems'),
  (8, 'Robotics and Automation'),
  (9, 'Machine Learning'),
  (9, 'AI Engines'),
  (10, 'Natural Language Processing'),
  (10, 'Data Structure Models'),
  (11, 'Computational Efficiency'),
  (11, 'Local Area Network Management'),
  (12, 'Wide Area Network Management'),
  (12438011, 'Data Engineer'),
  (12438010, 'Data Engineer'),
  (12438009, 'Data Engineer'),
  (12438008, 'Data Architect'),
  (12438007, 'Data Architect'),
  (12438006, 'Computer Science');

-- 13. Αιτήσεις Υποψηφίων (Applies)
INSERT INTO applies (cand_usrname, job_id, katastash_ait, hmerominia_ait) VALUES
  ('anthigr', 2, 'ENERGH', '2022-01-01 10:00:00'),
  ('anthigr', 7, 'ENERGH', '2022-02-05 11:30:00'),
  ('gewrgiafr', 2, 'ENERGH', '2022-03-10 09:15:00'),
  ('gewrgiafr', 3, 'ENERGH', '2022-04-15 14:20:00'),
  ('gewrgiafr', 6, 'ENERGH', '2022-05-20 16:40:00'),
  ('gewrgiafr', 7, 'ENERGH', '2022-06-25 12:00:00'),
  ('gewrgiafr', 8, 'ENERGH', '2022-07-30 18:00:00'),
  ('gewrgiafr', 12, 'ENERGH', '2022-08-04 10:10:00'),
  ('petrodi', 2, 'ENERGH', '2022-09-09 11:11:00'),
  ('petrodi', 3, 'ENERGH', '2022-10-14 15:30:00'),
  ('petrodi', 5, 'ENERGH', '2022-11-19 12:45:00'),
  ('petrodi', 6, 'ENERGH', '2022-12-24 17:00:00'),
  ('petrodi', 7, 'ENERGH', '2023-01-01 10:00:00'),
  ('petrodi', 9, 'ENERGH', '2023-02-05 13:20:00'),
  ('petrodi', 12, 'ENERGH', '2023-03-10 14:00:00'),
  ('roxane', 4, 'ENERGH', '2023-04-15 11:00:00'),
  ('roxane', 6, 'ENERGH', '2023-05-20 15:30:00'),
  ('roxane', 10, 'ENERGH', '2023-06-25 16:20:00'),
  ('velouris', 4, 'ENERGH', '2023-07-30 09:00:00'),
  ('velouris', 11, 'ENERGH', '2023-08-04 10:30:00'),
  ('velouris', 1, 'ENERGH', '2023-09-09 11:45:00'),
  ('velouris', 9, 'ENERGH', '2023-10-14 12:15:00'),
  ('velouris', 12, 'ENERGH', '2023-11-19 13:00:00'),
  ('eleniPap', 12438010, 'ENERGH', '2023-12-24 10:00:00'),
  ('kostas4', 12438010, 'ENERGH', '2024-01-01 11:00:00'),
  ('mary94', 12438009, 'ENERGH', '2024-01-05 12:00:00'),
  ('nik99', 12438009, 'ENERGH', '2024-01-10 13:00:00'),
  ('nikhftw', 12438008, 'ENERGH', '2024-01-15 14:00:00'),
  ('Petros12', 12438004, 'ENERGH', '2024-01-20 15:00:00');

-- 14. Αξιολογήσεις (Evaluate)
INSERT INTO evaluate (eva_usr, eva_usr2, em_usr, j_id, evaluation, evaluation2, firm, applie_num) VALUES
  ('dimifos', 'cocos', 'anthigr', 4, 4, NULL, '689245719', 1),
  ('dimifos', 'cocos', 'gewrgiafr', 5, NULL, 18, '689245719', 2),
  ('dimifos', 'papadion', 'anthigr', 5, 2, 15, '689245719', 3),
  ('dimifos', 'papadion', 'gewrgiafr', 5, 10, 5, '689245719', 4),
  ('makgr', 'maripi', 'filip', 2, 17, 9, '097466760', 5),
  ('makgr', 'cocos', 'anthigr', 1, 1, 19, '097466760', 6),
  ('makgr', 'maripi', 'gewrgiafr', 1, 13, 8, '097466760', 7),
  ('cocos', 'maripi', 'petrodi', 1, 6, 14, '689245719', 8),
  ('cocos', 'balios', 'petrodi', 8, 11, 3, '689245719', 9),
  ('maripi', 'balios', 'petrodi', 8, NULL, 20, '502006561', 10),
  ('maripi', 'balios', 'velouris', 8, 3, 16, '502006561', 11),
  ('maripi', 'balios', 'roxane', 3, 9, 7, '502006561', 12),
  ('balios', 'kostopa', 'roxane', 3, 18, 4, '042456375', 13),
  ('balios', 'jiovani', 'roxane', 3, 20, NULL, '042456375', 14),
  ('jiovani', 'makgr', 'filip', 1, 18, 4, '187882620', 15),
  ('jiovani', 'makgr', 'anthigr', 1, 18, 4, '187882620', 16),
  ('jiovani', 'dimifos', 'velouris', 13, 20, 6, '187882620', 17),
  ('rexti', 'makgr', 'velouris', 7, 13, 17, '836038422', 18),
  ('rexti', 'dimifos', 'velouris', 9, 15, 10, '836038422', 19),
  ('rexti', 'dimifos', 'roxane', 10, 15, 10, '836038422', 20);
