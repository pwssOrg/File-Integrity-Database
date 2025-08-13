CREATE TABLE IF NOT EXISTS "user_"(
id SERIAL PRIMARY KEY,
username TEXT UNIQUE NOT NULL,
auth_id bigint REFERENCES auth(id) NOT NULL,
user_session_id bigint REFERENCES user_session(id),
user_time bigint REFERENCES "time"(id) NOT NULL
);