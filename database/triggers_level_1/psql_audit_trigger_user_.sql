CREATE TRIGGER psql_audit_trigger_user_
AFTER UPDATE OR DELETE ON user_
FOR EACH ROW
EXECUTE FUNCTION log_only_psql_changes();