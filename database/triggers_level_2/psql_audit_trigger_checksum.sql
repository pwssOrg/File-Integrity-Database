CREATE TRIGGER psql_audit_trigger_checksum
AFTER UPDATE OR DELETE ON checksum
FOR EACH ROW
EXECUTE FUNCTION log_only_psql_changes();