Class Test.BS.EmitFile Extends Ens.BusinessService [ Language = objectscript ]
{

Parameter ADAPTER = "Ens.InboundAdapter";

Parameter SETTINGS = "basepath";

Property basepath As %String;

Property Seq As %Numeric [ InitialExpression = 1 ];

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set target=$LISTBUILD("000","001","002")
	Set fromfile=##class(%File).NormalizeFilename("sample.txt",..basepath)
	Set RND=$R($LL(target))+1
	Set tofolder=##class(%File).NormalizeDirectory($LIST(target,RND),..basepath_"\in_folder")
	Set tofile=##class(%File).NormalizeFilename($LIST(target,RND)_$TR($J(..Seq,6)," ",0)_".txt",tofolder)
	Set tSC=$$$OK
	Try {
		Set tBool=##class(%Library.File).CopyFile(fromfile,tofile,,.ret)
		If tBool=0 { Set tSC='$$$OK }
		Else {
			Set ..Seq=..Seq+1
		}
	}
	Catch e {
		Set tSC=e.AsStatus()
	}
	
	Return tSC
}

}
