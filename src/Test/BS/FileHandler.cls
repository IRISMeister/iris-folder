Class Test.BS.FileHandler Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Parameter SETTINGS = "basepath,targetpath";

Property basepath As %String;

Property targetpath As %String;

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC=$$$OK
	Try {
		;If ##class(%File).Exists(..targetpath_"\READY.SEM") Quit
		If ##class(%File).Exists($$$FileNormalizeFilename(..targetpath_"/READY.SEM",)) Quit
		
		Set latest=$G(^log)-1 Quit:latest<1
		Set tSC=..Exec(latest)
	}
	Catch(e) {
		Set tSC=e.AsStatus()
	}

	Quit tSC
}

Method Exec(latest) As %Status
{
	Set done=0
	kill ^||work
	Set tSC=$$$OK
	Try {	
		tstart
		Set c="" For {
			Set c=$O(^log(c),1,folder) q:c>latest
			Set ^||work(folder)=c k ^log(c)
		}

		; Copy files to target folder where EnsLib.File.* is watching
		Set folder="" For {
			; does order matter?
			Set folder=$O(^||work(folder)) q:folder=""
			Set rs=##class(%ResultSet).%New("%File:FileSet") 
			Do rs.Execute(folder,"*.txt")

			Set fromfile=""
			Set tofile=""

			; +++ Put some app logic here to "reduce" files to be processed +++ 
			; Otherwise they will increase linierly.
			;
			While(rs.Next()) {
				Set fromfile=rs.Name
				Set tofile=$$$FileNormalizeFilename(..targetpath_"/"_rs.ItemName)
				Set done=1
			}
			; process the latest file only.
			If fromfile'="" {
				$$$LOGINFO("Copy "_fromfile_" to "_tofile)
				Set tBool=##class(%Library.File).CopyFile(fromfile,tofile,,.ret)
				If tBool=0 { Throw ##class(%Exception.General).%New() }
			}
			; --- Put some app logic here to "reduce" files to be processed ---
			
		}
		; If there is no file to process, don't create a semaphore file.
		If done {
			Set fromfile=$$$FileNormalizeFilename(..basepath_"/../READY.SEM")
			Set tofile=$$$FileNormalizeFilename(..targetpath_"/READY.SEM")
			Set tBool=##class(%Library.File).CopyFile(fromfile,tofile,,.ret)
			$$$LOGINFO("Create semaphor. Copy "_fromfile_" to "_tofile_" tBool:"_tBool_" ret:"_ret)
		}
		tcommit
	}
	Catch(e) {
		trollback
		Set tSC=e.AsStatus()
	}

	Quit tSC
}

}
