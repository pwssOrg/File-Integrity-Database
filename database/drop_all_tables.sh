#! /bin/bash

psql -d integrity_hash -c "DROP TABLE scan_details CASCADE;"
psql -d integrity_hash -c "DROP TABLE scan CASCADE;"
psql -d integrity_hash -c "DROP TABLE monitored_directory CASCADE;"
psql -d integrity_hash -c "DROP TABLE checksum CASCADE;"
psql -d integrity_hash -c "DROP TABLE file CASCADE;"