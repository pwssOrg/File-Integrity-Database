# Database Repository
This repository contains the database schema and related scripts for File-Integrity-Scanner.

![File Integrity Database](https://github.com/pwssOrg/File-Integrity-Database/blob/master/.github/assets/images/tobias-fischer-PkbZahEG2Ng-unsplash.jpg?raw=true)

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
<B>PostgreSQL 17.5 ([documentation](https://www.postgresql.org/docs/17/index.html)) </b>

![File Integrity Database](https://github.com/pwssOrg/File-Integrity-Database/blob/master/.github/assets/images/krzysztof-kowalik-KiH2-tdGQRY-unsplash.jpg?raw=true)

## Discussion Forum
Please visit our discussion forum for project-related documentation and discussions: [Project Discussion
Forum](https://github.com/orgs/pwssOrg/discussions/categories/file-integrity-database)
