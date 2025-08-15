# Database Repository
This repository contains the database schema and related scripts for File-Integrity-Scanner.

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


# File Integrity Scanner
## Tables

### checksum

| Column Name            | Data Type   | Description |
|------------------------|-------------|-------------|
| id                     | BIGSERIAL         | Unique identifier for the checksum record. |
| file_id                | BIGINT         | References the associated file in the `file` table. |
| checksum_sha256        | TEXT     | SHA-256 hash of the file. |
| checksum_sha3          | TEXT     | SHA-3 hash of the file. |
| checksum_blake_2b      | TEXT     | BLAKE2b hash of the file. |

##### Example Data

| id  | file_id | checksum_sha256                                    | checksum_sha3                                       | checksum_blake_2b                               |
|-----|---------|----------------------------------------------------|-----------------------------------------------------|------------------------------------------------|
| 1   | 1       | abcd1234efghijk...       | fghijklmnopqrstuvwxyz...        | hijklmnopq...     |
| 2   | 2       | efgh5678ijklmnd...       | ijklmnopqrstuvwxyzabcd...            | jklmnopq...    |
| 3   | 3       | ghij9012klmnopq...        | klmnopqrstuvwxyzabcdef...           | lmnopq...      |
| ... | ...     | ...                                                | ...                                                 | ...                                            |



### file

| Column Name            | Data Type   | Description |
|------------------------|-------------|-------------|
| id                     | BIGSERIAL         | Unique identifier for the file record. |
| path                   | TEXT UNIQUE     | Full path to the file (must be unique). |
| basename               | TEXT     | Name of the file. |
| directory              | TEXT     | Directory containing the file. |
| size                   | BIGINT      | Size of the file in bytes. |
| mtime                  | TIMESTAMPTZ   | Timestamp when the file was last modified. |

##### Example Data

| id  | path                             | basename       | directory            | size    | mtime               |
|-----|----------------------------------|----------------|----------------------|---------|---------------------|
| 1   | /home/user/documents/report.pdf  | report.pdf     | /home/user/documents | 5242880 | 2023-01-01 08:00:00 |
| 2   | /mnt/external/drive/backup.zip    | backup.zip     | /mnt/external/drive  | 10485760| 2023-02-01 09:00:00
| 3   | /home/user/projects/code.py       | code.py        | /home/user/projects  | 2048    | 2023-03-01 10:00:00



### monitored_directory

| Column Name            | Data Type   | Description |
|------------------------|-------------|-------------|
| id                     | SERIAL         | Unique identifier for the monitored directory. |
| path                   | TEXT UNIQUE     | Full path to the monitored directory (must be unique). |
| is_active              | BOOLEAN     | Indicates if the directory is currently being monitored. |
| added_at               | TIMESTAMPTZ   | Timestamp when the directory was added for monitoring. |
| last_scanned           | TIMESTAMPTZ   | Timestamp of the last scan performed on the directory. |
| notes                  | TEXT        | Optional notes about the directory. |
| baseline_established   | BOOLEAN     | Indicates if a baseline has been established for this directory. |
| include_subdirectories | BOOLEAN     | Specifies whether scans should also include all subdirectories within the monitored directory. |

##### Example Data

| id  | path                        | is_active | added_at           | last_scanned      | notes          | baseline_established |
|-----|-----------------------------|-----------|--------------------|-------------------|----------------|---------------------|
| 1   | /home/user/documents        | TRUE      | 2023-01-01 08:00:00| 2023-01-05 14:00:00| None           | TRUE                |
| 2   | /mnt/external/drive         | FALSE     | 2023-02-01 09:00:00| 2023-02-10 15:00:00| Not in use      | FALSE               |
| 3   | /home/user/projects         | TRUE      | 2023-03-01 10:00:00| 2023-03-15 16:00:00| Important files|                     |



### scan

| Column Name            | Data Type   | Description |
|------------------------|-------------|-------------|
| id                     | SERIAL         | Unique identifier for the scan record. |
| scan_time              | TIMESTAMPTZ   | Timestamp when the scan was performed. |
| status                 | TEXT     | Status of the scan (e.g., completed, failed). |
| notes                  | TEXT        | Optional notes about the scan. |
| monitored_directory_id | INT         | References the monitored directory that was scanned. |

##### Example Data

| id  | scan_time           | status   | notes              | monitored_directory_id |
|-----|---------------------|----------|--------------------|------------------------|
| 1   | 2023-01-01 10:00:00 | completed| Initial scan       | 501                    |
| 2   | 2023-01-02 11:30:00 | failed   | Disk space error   | 502                    |
| 3   | 2023-01-03 08:45:00 | completed| Routine scan       | 503                    |
| ... | ...                 | ...      | ...                | ...                    |



### scan_summary

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| id          | SERIAL       | Unique identifier for the scan detail record. |
| scan_id     | INT       | References the associated scan in the `scan` table. |
| file_id     | BIGINT       | References the file that was scanned in the `file` table. |
| checksum_id | BIGINT       | References the checksum used for the file in the `checksum` table. |

##### Example Data

| id  | scan_id | file_id | checksum_id |
|-----|---------|---------|-------------|
| 1   | 101     | 201     | 301         |
| 2   | 102     | 202     | 302         |
| 3   | 103     | 203     | 303         |
| ... | ...     | ...     | ...         |

# User Login

## Tables

### auth

| Column Name            | Data Type   | Description |
|------------------------|-------------|-------------|
| id                     | SERIAL         | Unique identifier for the authentication record. |
| hash                   | TEXT          | Authentication hash of the user. |
| auth_time              | INT           | References the associated time in the `time` table. |

##### Example Data

| id  | hash                          | auth_time |
|-----|-------------------------------|-----------|
| 1   | abcdefghijklmnopqrstuvwxyz... | 1         |
| 2   | bcdefghijklmnopqrstuvwxyzabcd | 2         |
| 3   | cdefghijklmnopqrstuvwxyzabcde | 3         |
| ... | ...                           | ...       |

### time

| Column Name            | Data Type   | Description |
|------------------------|-------------|-------------|
| id                     | SERIAL         | Unique identifier for the timestamp record. |
| created                | TIMESTAMPTZ    | Timestamp when the record was created. |
| updated                | TIMESTAMPTZ    | Timestamp when the record was last updated. |

##### Example Data

| id  | created                         | updated                        |
|-----|---------------------------------|-------------------------------|
| 1   | 2023-10-01T12:00:00Z            | 2023-10-01T12:05:00Z           |
| 2   | 2023-10-02T14:30:00Z            | 2023-10-02T14:35:00Z           |
| 3   | 2023-10-03T08:15:00Z            | 2023-10-03T08:20:00Z           |
| ... | ...                             | ...                           |

### user_

| Column Name            | Data Type   | Description |
|------------------------|-------------|-------------|
| id                     | SERIAL         | Unique identifier for the user record. |
| username               | TEXT          | Username of the user (must be unique). |
| auth_id                | INT           | References the associated authentication in the `auth` table. |
| user_time              | INT           | References the associated time in the `time` table. |

##### Example Data

| id  | username      | auth_id | user_time |
|-----|---------------|---------|-----------|
| 1   | user1         | 1       | 1         |
| 2   | user2         | 2       | 2         |
| 3   | user3         | 3       | 3         |
| ... | ...           | ...     | ...       |


## Discussion Forum
Please visit our discussion forum for project-related documentation and discussions: [Project Discussion
Forum](https://github.com/orgs/pwssOrg/discussions/categories/file-integrity-database)