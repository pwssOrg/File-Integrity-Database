CREATE TRIGGER psql_audit_trigger_diff
AFTER UPDATE OR DELETE ON diff
FOR EACH ROW
EXECUTE FUNCTION log_only_psql_changes();