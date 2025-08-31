CREATE TABLE diff (
id BIGSERIAL PRIMARY KEY,
baseline_id bigint NOT NULL REFERENCES scan_summary(id),
integrity_fail_id bigint NOT NULL REFERENCES scan_summary(id),
time_id bigint NOT NULL REFERENCES time(id));