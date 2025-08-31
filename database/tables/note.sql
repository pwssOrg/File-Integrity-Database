CREATE TABLE note (
id BIGSERIAL PRIMARY KEY,
notes TEXT,
prev_notes TEXT,
prev_prev_notes TEXT,
time_id bigint NOT NULL REFERENCES time(id));