param(
  [bool]$AuditChecksumAndDiffTable = $false
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

 ## Create Trigger Function for Update and Delete Statements made in PSQL console
  
 $triggerFunctionScriptPath = ".\functions\trigger_function_only_psql.sql"
    if (Test-Path $triggerFunctionScriptPath) {
      $DBCmd.CommandText = Get-Content $triggerFunctionScriptPath -Raw
      $rowsAffected = $DBCmd.ExecuteNonQuery()
      Write-Output "Created Trigger Function for PSQL - $rowsAffected rows affected."
    }
    else {
      Write-Warning "Trigger function file not found: $triggerFunctionScriptPath"
    }


  ## Define the order of trigger creation
  $level_1_triggers = @("psql_audit_trigger_monitored_directory.sql","psql_audit_trigger_license.sql","psql_audit_trigger_auth.sql","psql_audit_trigger_user_.sql")

  foreach ($triggerScript in $level_1_triggers) {
    $filePath = Join-Path "triggers_level_1" $triggerScript
    if (Test-Path $filePath) {
      $DBCmd.CommandText = Get-Content $filePath -Raw
      $rowsAffected = $DBCmd.ExecuteNonQuery()
      Write-Output "Executed $triggerScript - $rowsAffected rows affected."
    }
    else {
      Write-Warning "Trigger definition not found: $filePath"
    }
  }

  # Please note that enabling this option will negatively impact the integrity scanning speed. Only activate it if required to meet your security requirements.
  if ($AuditChecksumAndDiffTable) {


  ## Define the order of trigger creation
  $level_2_triggers = @("psql_audit_trigger_checksum.sql","psql_audit_trigger_diff.sql")

  foreach ($triggerScript in $level_2_triggers) {
    $filePath = Join-Path "triggers_level_2" $triggerScript
    if (Test-Path $filePath) {
      $DBCmd.CommandText = Get-Content $filePath -Raw
      $rowsAffected = $DBCmd.ExecuteNonQuery()
      Write-Output "Executed $triggerScript - $rowsAffected rows affected."
    }
    else {
      Write-Warning "Trigger definition file not found: $filePath"
    }
  }

}
 
 
  $DBConn.Close();
  Write-Output "Success! The Trigger Function and the selected audit triggers have been added to the integrity hash database." | Green
}

catch {
  Write-Output "An error occurred: $($_.Exception.Message)" | Red
  Write-Output "Contact peter.westin@pwss.dev or stefan.smudja@pwss.decv for support!" | Red
}