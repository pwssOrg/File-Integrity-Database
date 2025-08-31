CREATE TABLE diff (
id BIGSERIAL PRIMARY KEY,
baseline_id bigint NOT NULL REFERENCES scan_summary(id),
current_id bigint NOT NULL REFERENCES scan_summary(id),
time_id bigint NOT NULL REFERENCES time(id));