-- Insert mock data into the time table
INSERT INTO "time" (created, updated) VALUES
('2023-01-01 00:00:00+00', '2023-01-01 00:00:00+00'),
('2023-02-01 00:00:00+00', '2023-02-01 00:00:00+00');

-- Insert mock data into the note table
INSERT INTO note (notes, prev_notes, prev_prev_notes, time_id) VALUES
('Note for file 1', NULL, NULL, 1),
('Note for file 2', NULL, NULL, 2);

-- Insert mock data into the monitored_directory table
INSERT INTO monitored_directory (path, is_active, time_id, last_scanned, note_id, baseline_established, include_subdirectories) VALUES
('/var/log', TRUE, 1, '2023-01-01 00:00:00+00', NULL, FALSE, TRUE),
('/var/tmp', TRUE, 2, '2023-02-01 00:00:00+00', NULL, FALSE, TRUE);

-- Insert mock data into the file table
INSERT INTO file (path, basename, directory, size, mtime) VALUES
('/var/log/syslog', 'syslog', '/var/log', 1024, '2023-01-01 00:00:00+00'),
('/var/tmp/tempfile', 'tempfile', '/var/tmp', 2048, '2023-02-01 00:00:00+00');

-- Insert mock data into the checksum table
INSERT INTO checksum (file_id, checksum_sha256, checksum_sha3, checksum_blake_2b) VALUES
(1, 'sha256_checksum_1', 'sha3_checksum_1', 'blake2b_checksum_1'),
(2, 'sha256_checksum_2', 'sha3_checksum_2', 'blake2b_checksum_2');

-- Insert mock data into the scan table
INSERT INTO scan (scan_time_id, status, note_id, monitored_directory_id, is_baseline_scan) VALUES
(1, 'success', NULL, 1, TRUE),
(2, 'failure', NULL, 2, FALSE);

-- Insert mock data into the scan_summary table
INSERT INTO scan_summary (scan_id, file_id, checksum_id) VALUES
(1, 1, 1),
(2, 2, 2);

-- Insert mock data into the diff table
INSERT INTO diff (baseline_id, integrity_fail_id, time_id) VALUES
(1, 2, 1),
(2, 1, 2);

