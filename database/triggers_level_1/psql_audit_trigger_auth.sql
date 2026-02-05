CREATE TRIGGER psql_audit_trigger_auth
AFTER UPDATE OR DELETE ON auth
FOR EACH ROW
EXECUTE FUNCTION log_only_psql_changes();