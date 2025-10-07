CREATE TABLE scan (
    id SERIAL PRIMARY KEY,
    scan_time_id bigint NOT NULL REFERENCES time(id),
    status TEXT NOT NULL,
    note_id bigint NOT NULL REFERENCES note(id),
    monitored_directory_id INTEGER NOT NULL REFERENCES monitored_directory(id),
    is_baseline_scan BOOLEAN NOT NULL
);