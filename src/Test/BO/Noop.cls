Class Test.BO.Noop Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method Exec(pRequest As Ens.StreamContainer, Output pResponse As Ens.Response) As %Status
{
	Set tSC=$$$OK
	Try {
		$$$LOGINFO(pRequest.OriginalFilename)
		Set pResponse=##class(Ens.Response).%New()
	}
	Catch e {
		Set tSC=e.AsStatus()
	}

	Return tSC
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.StreamContainer"> 
		<Method>Exec</Method>
	</MapItem>

</MapItems>
}

}
