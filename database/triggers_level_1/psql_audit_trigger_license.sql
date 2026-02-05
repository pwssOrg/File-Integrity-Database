CREATE TRIGGER psql_audit_trigger_license
AFTER UPDATE OR DELETE ON license
FOR EACH ROW
EXECUTE FUNCTION log_only_psql_changes();