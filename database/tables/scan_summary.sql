CREATE TABLE scan_summary (
    id BIGSERIAL PRIMARY KEY,
    scan_id INTEGER NOT NULL REFERENCES scan(id),
    file_id bigint NOT NULL REFERENCES file(id),
    checksum_id bigint NOT NULL REFERENCES checksum(id)
);
