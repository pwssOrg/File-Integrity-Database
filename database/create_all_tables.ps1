param(
  [bool]$InsertTestData = $false
)

## Import PWSS Powershell utility Module
Import-Module ".\functions_ps\pwss_powershell_utility.psm1"

## Check if environment variables for database user and password are set
if (-not $env:INTEGRITY_HASH_DB_USER -or -not $env:INTEGRITY_HASH_DB_PASSWORD) {
  Write-Error "Environment variables INTEGRITY_HASH_DB_USER and/or INTEGRITY_HASH_DB_PASSWORD are not set."
  exit 1
}

try {
  ## Connect to the integrity hash database and add all tables, tables, and sequences to it.
  $DBConnectionString = "Driver={PostgreSQL UNICODE};Server=localhost;Port=26556;Database=integrity_hash;Uid=$env:INTEGRITY_HASH_DB_USER;Pwd=$env:INTEGRITY_HASH_DB_PASSWORD;"
  $DBConn = New-Object System.Data.Odbc.OdbcConnection;
  $DBConn.ConnectionString = $DBConnectionString;
  $DBConn.Open();
  $DBCmd = $DBConn.CreateCommand();


   ## Define the order of table creation
  $tableOrderMixed = @("time.sql")

  foreach ($tableFile in $tableOrderMixed) {
    $filePath = Join-Path "tables\mixed" $tableFile
    if (Test-Path $filePath) {
      $DBCmd.CommandText = Get-Content $filePath -Raw
      $rowsAffected = $DBCmd.ExecuteNonQuery()
      Write-Output "Executed $tableFile - $rowsAffected rows affected."
    }
    else {
      Write-Warning "Table definition file not found: $filePath"
    }
  }


  ## Define the order of table creation for file-integrity-scanner
  $tableOrderFileIntegrityScanner = @("file.sql", "checksum.sql", "monitored_directory.sql", "scan.sql", "scan_summary.sql","diff.sql")

  foreach ($tableFile in $tableOrderFileIntegrityScanner) {
    $filePath = Join-Path "tables" $tableFile
    if (Test-Path $filePath) {
      $DBCmd.CommandText = Get-Content $filePath -Raw
      $rowsAffected = $DBCmd.ExecuteNonQuery()
      Write-Output "Executed $tableFile - $rowsAffected rows affected."
    }
    else {
      Write-Warning "Table definition file not found: $filePath"
    }
  }

 

  ## Define the order of table creation
  $tableOrderUserLogin = @("auth.sql", "user.sql")


  foreach ($tableFile in $tableOrderUserLogin) {
    $filePath = Join-Path "tables\user_login" $tableFile
    if (Test-Path $filePath) {
      $DBCmd.CommandText = Get-Content $filePath -Raw
      $rowsAffected = $DBCmd.ExecuteNonQuery()
      Write-Output "Executed $tableFile - $rowsAffected rows affected."
    }
    else {
      Write-Warning "Table definition file not found: $filePath"
    }
  }


 




  ## Insert test data if requested
  if ($InsertTestData) {
    $mockDataPath = ".\mock_data\insert_mock_data.sql"
    if (Test-Path $mockDataPath) {
      $DBCmd.CommandText = Get-Content $mockDataPath -Raw
      $rowsAffected = $DBCmd.ExecuteNonQuery()
      Write-Output "Inserted mock data - $rowsAffected rows affected."
    }
    else {
      Write-Warning "Mock data file not found: $mockDataPath"
    }
  }

  $DBConn.Close();
  Write-Output "Success! All tables and sequences have been added to the integrity hash database." | Green
}

catch {
  Write-Output "An error occurred: $($_.Exception.Message)" | Red
  Write-Output "Contact snow_900@outlook.com or stefan-201@hotmail.com for support!" | Red
}