#! /bin/bash

psql -d integrity_hash -c "DROP TABLE scan_summary CASCADE;"
psql -d integrity_hash -c "DROP TABLE scan CASCADE;"
psql -d integrity_hash -c "DROP TABLE monitored_directory CASCADE;"
psql -d integrity_hash -c "DROP TABLE checksum CASCADE;"
psql -d integrity_hash -c "DROP TABLE file CASCADE;"

psql -d integrity_hash -c "DROP TABLE user_ CASCADE;"
psql -d integrity_hash -c "DROP TABLE auth CASCADE;"
psql -d integrity_hash -c "DROP TABLE time CASCADE;"
psql -d integrity_hash -c "DROP TABLE license CASCADE;"