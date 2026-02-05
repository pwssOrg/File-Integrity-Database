CREATE TABLE monitored_directory (
    id SERIAL PRIMARY KEY,
    path TEXT NOT NULL UNIQUE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    time_id bigint NOT NULL REFERENCES time(id),
    last_scanned TIMESTAMPTZ,
    note_id bigint NOT NULL REFERENCES note(id),
    baseline_established BOOLEAN NOT NULL DEFAULT FALSE,
    include_subdirectories BOOLEAN NOT NULL DEFAULT TRUE
);

SET application_name = 'psql';
SHOW application_name;