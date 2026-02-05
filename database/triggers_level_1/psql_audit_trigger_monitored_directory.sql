CREATE TRIGGER psql_audit_trigger_monitored_directory
AFTER UPDATE OR DELETE ON monitored_directory
FOR EACH ROW
EXECUTE FUNCTION log_only_psql_changes();
