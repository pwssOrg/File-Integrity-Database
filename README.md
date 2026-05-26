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

## System Architecture

The system is split into backend services, a GUI client, shared PWSS libraries, and a user-ready distribution package. This modular architecture enables independent development of core security logic, user interface components, and deployment tooling for both technical and non-technical users. Each component can be developed and deployed independently while maintaining a shared security and hashing standard through the PWSS libraries.

### Components

- **[Core Backend (FIM Engine)](https://github.com/pwssOrg/File-Integrity-Scanner#file-integrity-scanner-backend-fim-engine)** – Handles hashing, integrity verification, and monitoring logic
- **[GUI Application](https://github.com/pwssOrg/File-Integrity-GUI#integrity-hash-java-swing-frontend)** – User interface for managing scans and viewing results
- **[PWSS Libraries](https://github.com/search?q=topic:pwss-library+org:pwssOrg&type=repositories)** – Shared components used across all PWSS projects
- **[Database Layer](https://github.com/pwssOrg/File-Integrity-Database#system-architecture)** – PostgreSQL database schemas and audit infrastructure

This repository represents the **Database** layer of the File Integrity Scanner system — containing the PostgreSQL schema, table definitions, sequences, audit triggers, and setup/teardown scripts.

```
GUI → Local Backend → PostgreSQL  ← (this repository)
          ↓
   PWSS Libraries (dependency)
```
