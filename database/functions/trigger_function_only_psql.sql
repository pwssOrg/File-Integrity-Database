CREATE OR REPLACE FUNCTION log_only_psql_changes()
RETURNS trigger AS $$
BEGIN
    -- log changes from psql console
    IF current_setting('application_name', true) LIKE 'psql%' THEN
        IF TG_OP = 'UPDATE' THEN
            -- Log update, excluding the "hash" column
            RAISE LOG
                '[AUDIT][PSQL][UPDATE] table=% user=% old=% new=%',
                TG_TABLE_NAME,
                session_user,
                (to_jsonb(OLD) - 'hash')::json,
                (to_jsonb(NEW) - 'hash')::json;

        ELSIF TG_OP = 'DELETE' THEN
            -- Log delete, excluding the "hash" column
            RAISE LOG
                '[AUDIT][PSQL][DELETE] table=% user=% old=%',
                TG_TABLE_NAME,
                session_user,
                (to_jsonb(OLD) - 'hash')::json;
        END IF;
    END IF;

    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;
