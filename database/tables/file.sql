CREATE TABLE file (
    id BIGSERIAL PRIMARY KEY,
    path TEXT NOT NULL UNIQUE,
    basename TEXT NOT NULL,
    directory TEXT NOT NULL,
    size bigint NOT NULL,
    mtime TIMESTAMPTZ NOT NULL
);