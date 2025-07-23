# Database Repository
This repository contains the database schema and related scripts for File-Integrity-Scanner.

## Tables

### checksums
- `id`: Unique identifier for the checksum record.
- `file_id`: References the associated file in the `files` table.
- `checksum_sha256`: SHA-256 hash of the file.
- `checksum_sha3`: SHA-3 hash of the file.
- `checksum_blake_2b`: BLAKE2b hash of the file.

### files
- `id`: Unique identifier for the file record.
- `path`: Full path to the file (must be unique).
- `basename`: Name of the file.
- `directory`: Directory containing the file.
- `size`: Size of the file in bytes.
- `mtime`: Timestamp when the file was last modified.

### monitored_directories
- `id`: Unique identifier for the monitored directory.
- `path`: Full path to the monitored directory (must be unique).
- `is_active`: Indicates if the directory is currently being monitored.
- `added_at`: Timestamp when the directory was added for monitoring.
- `last_scanned`: Timestamp of the last scan performed on the directory.
- `notes`: Optional notes about the directory.
- `baseline_established`: Indicates if a baseline has been established for this directory.

### scans
- `id`: Unique identifier for the scan record.
- `scan_time`: Timestamp when the scan was performed.
- `status`: Status of the scan (e.g., completed, failed).
- `notes`: Optional notes about the scan.
- `monitored_directory_id`: References the monitored directory that was scanned.

### scan_details
- `id`: Unique identifier for the scan detail record.
- `scan_id`: References the associated scan in the `scans` table.
- `file_id`: References the file that was scanned in the `files` table.
- `checksum_id`: References the checksum used for the file in the `checksums` table.

## PowerShell scripts

### create_all_tables.ps1
This PowerShell script initializes the "integrity_hash" PostgreSQL database by creating all required tables and sequences. It also provides an option to insert mock test data for development or testing purposes.

#### Usage
1. **Set Environment Variables**  
    Ensure the following environment variables are set with appropriate values:
    - `INTEGRITY_HASH_DB_USER`
    - `INTEGRITY_HASH_DB_PASSWORD`

2. **Run the Script**  
    ```powershell
    .\create_all_tables.ps1 [-InsertTestData $true]
    ```
    - Use the `-InsertTestData` switch if you want to insert mock data after creating the tables.


### drop_all_tables.ps1
This PowerShell script resets the "integrity_hash" PostgreSQL database by dropping all tables after verifying that the required environment variables are set.

#### Example Usage
```powershell
.\drop_all_tables.ps1
```

Ensure `INTEGRITY_HASH_DB_USER` and `INTEGRITY_HASH_DB_PASSWORD` environment variables are set before running the script.

## Requirements
- PostgreSQL 17.5 ([documentation](https://www.postgresql.org/docs/17/index.html))

## Discussion Forum
Please visit our discussion forum for project-related documentation and discussions: [Project Discussion
Forum](https://github.com/orgs/pwssOrg/discussions/categories/file-integrity-database)


