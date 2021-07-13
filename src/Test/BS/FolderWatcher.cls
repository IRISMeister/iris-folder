Class Test.BS.FolderWatcher Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Method OnProcessInput(pInput As %Stream.Object, Output pOutput As %RegisteredObject) As %Status
{
	Set filename=pInput.Attributes("Filename")
	$$$LOGINFO(filename)
	Set tSC=$$$OK
	Try {
		Set foldername=##class(%File).GetDirectory(filename)
		; Picks up only folder name
		Set seq=$INCREMENT(^log)
		Set ^log(seq)=foldername
	}
	Catch(e) {
		Set tSC=e.AsStatus()
	}

	Quit tSC
}

}
