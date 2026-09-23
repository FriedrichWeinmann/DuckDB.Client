function Invoke-DuckDBQuery {
	<#
		.SYNOPSIS
			Runs a SQL query against a DuckDB database.

		.DESCRIPTION
			Runs a SQL query using an existing DuckDB connection or a database path. When a path is supplied, the command creates a connection for the query and closes it afterward. Query results are written to the pipeline.

		.PARAMETER Query
			The SQL statement to run against the DuckDB database.

		.PARAMETER Connection
			An existing DuckDB connection to use for the query. The command leaves this connection open after the query completes.

		.PARAMETER Path
			The path to the DuckDB database file to query.

		.EXAMPLE
			PS C:\> Invoke-DuckDBQuery -Path 'C:\Data\sales.duckdb' -Query 'SELECT * FROM Orders'

			Queries the Orders table in C:\Data\sales.duckdb and writes the results to the pipeline. The temporary connection is closed after the query.

		.EXAMPLE
			PS C:\> $connection = New-DuckDBConnection -Path ':memory:'
			PS C:\> Invoke-DuckDBQuery -Connection $connection -Query 'SELECT 42 AS Answer'

			Runs the query through the existing in-memory connection and returns a row whose Answer value is 42. The connection remains open.
	#>
	[CmdletBinding(DefaultParameterSetName = 'ByPath')]
	param (
		[Parameter(Mandatory = $true)]
		[string]
		$Query,

		[Parameter(Mandatory = $true, ParameterSetName = 'ByDB')]
		[DuckDB.NET.Data.DuckDBConnection]
		$Connection,
		
		[Parameter(Mandatory = $true, ParameterSetName = 'ByPath')]
		[string]
		$Path
	)
	process {
		if ($Connection) {
			try { $Connection.Query($Query) }
			catch { Write-Error -ErrorRecord $_ }
			return
		}

		try { $conn = [DuckDB.NET.Data.DuckDBConnection]::new("Data Source=$Path") }
		catch {
			Write-Error -ErrorRecord $_
			return
		}

		try { $conn.Query($Query) }
		catch {
			$conn.Close()
			Write-Error -ErrorRecord $_
			return
		}

		$conn.Close()
	}
}