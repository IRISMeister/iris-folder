Class Test.Scan Extends %RegisteredObject
{

Property %CurrResultSet As %ResultSet;

Property %fileRS As %ResultSet;

Property %innerRS As %ResultSet;

Property cnt As %Integer [ InitialExpression = 0 ];

Method Run() As %Status
{
 Set rs=##class(%ResultSet).%New("EnsLib.File.InboundAdapter:DeepList") 
 Set handle=""
 Set FilePath="C:\temp\iris-watchdog\work\"
 Set FileSpec="*"
 Set SubdirectoryLevels=5
 Set SemaphoreSpec=""
 Set tSC=rs.Execute($this,FilePath,FileSpec,SubdirectoryLevels,,SemaphoreSpec)
 While(rs.Next()) {
	 ;w rs.Name,!
	 Set ..cnt=..cnt+1
 }
}

ClassMethod Test()
{
	Set st=$ZH
	s p=##class(Test.Scan).%New()
	Do p.Run()
	Set end=$ZH
	w end-st,!
	w p.cnt,!
}

}
