# DuckDB.Client

Welcome to the DuckDB.Client module, a PowerShell project to interact with [DuckDB](https://duckdb.org/).
It contains everything you need for a small, local database without requiring a server installation.

> This module is designed to work Cross-Platform on both x64 or ARM architectures.

## Installation

To install the module, run:

```powershell
Install-Module -Name 'DuckDB.Client' -Scope CurrentUser
```

Alternatively, if you have any trouble getting modules installed, this might work instead:

```powershell
Invoke-WebRequest 'https://raw.githubusercontent.com/PowershellFrameworkCollective/PSFramework.NuGet/refs/heads/master/bootstrap.ps1' -UseBasicParsing | Invoke-Expression
Install-PSFModule -Name 'DuckDB.Client'
```

## Profit

> Create a new database (if needed) with a single table

```powershell
Invoke-DuckDBQuery -Path C:\Temp\users.duckdb -Query @'
CREATE TABLE IF NOT EXISTS Users (
    SamAccountName STRING PRIMARY KEY,
    Email VARCHAR NOT NULL,
    ProfilePath VARCHAR NOT NULL,
    Enabled BOOLEAN
)
'@
```

> Query a Database

```powershell
$db = New-DuckDBConnection -Path C:\Temp\users.duckdb
$db.Query('SELECT * FROM Users')
```
