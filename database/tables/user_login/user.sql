CREATE TABLE IF NOT EXISTS "user_"(
id SERIAL PRIMARY KEY,
username TEXT UNIQUE NOT NULL,
auth_id int REFERENCES auth(id) NOT NULL,
user_time int REFERENCES "time"(id) NOT NULL
);