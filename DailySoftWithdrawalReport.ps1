$SQLDailyPath = "C:\MiLEditorSchtasks\DailySoftwithdrawalReport\DailySoftWithdrawal.sql"
$CSVDailyPath = "C:\MiLEditorSchtasks\DailySoftwithdrawalReport\DailySoftWithdrawal.csv"
$SQLSummaryPath = "C:\MiLEditorSchtasks\DailySoftwithdrawalReport\DailySoftWithdrawalSummary.sql"
$CSVDailySummaryPath = "C:\MiLEditorSchtasks\DailySoftwithdrawalReport\DailySoftWithdrawalSummary.csv"

try
{
Echo "Now querying for daily soft-withdrawal..."
		sqlcmd -S "IDMILSQL03B\IDMILSQL03" -E -b -i $SQLDailyPath -h -1 -s "," -o $CSVDailyPath;
Echo "Done querying daily soft-withdrawal."
		$CSVDaily = Import-Csv $CSVDailyPath -Header "TitleID"
		if ($CSVDaily.TitleID)
			{
				$TitleIDs = @();
				$CSVDaily.TitleID | % {($TitleIDs += $_)};
				$TitleIDList = $TitleIDs[1..($TitleIDs.Length-1)] -join ",";
				#sqlcmd -S "IDMILSQL03B\IDMILSQL03" -E -b -v varTitleID ="849724,659510,656003,109131,883899" -i $SQLSummaryPath -h -1 -s "," -o $CSVDailySummaryPath
				sqlcmd -S "IDMILSQL03B\IDMILSQL03" -E -b -v varTitleID="$TitleIDList" -i $SQLSummaryPath -h -1 -s "," -o $CSVDailySummaryPath
				$CSVSummary = Import-Csv $CSVDailySummaryPath -Header "TitleID","MILISBN","CollectionID","Collection","CollectionTypeID","Account_ID","Name","Account_Type_ID" | sort "TitleID" -Unique;
			}
}
catch
{
	$ErrorMessage = $_.Exception.Message;
	$FailedItem = $_.Exception.ItemName;
	echo "Error on: $FailedItem; Message: $ErrorMessage";
	Break;
}
