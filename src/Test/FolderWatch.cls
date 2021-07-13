Class Test.FolderWatch Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Test.FolderWatch" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="EnsLib.File.PassthroughService" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">C:\temp\iris-folder\work_folder\</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.txt</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Noop</Setting>
    <Setting Target="Adapter" Name="SemaphoreSpec">READY.SEM</Setting>
    <Setting Target="Adapter" Name="DeleteFromServer">1</Setting>
    <Setting Target="Adapter" Name="Charset">utf-8</Setting>
    <Setting Target="Adapter" Name="ConfirmComplete">0</Setting>
  </Item>
  <Item Name="Noop" Category="" ClassName="Test.BO.Noop" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="EmitFile" Category="" ClassName="Test.BS.EmitFile" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="basepath">C:\temp\iris-folder</Setting>
    <Setting Target="Adapter" Name="CallInterval">10</Setting>
  </Item>
  <Item Name="FolderWatcher" Category="" ClassName="Test.BS.FolderWatcher" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="CallInterval">30</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\temp\iris-folder\in_folder</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.txt</Setting>
    <Setting Target="Adapter" Name="DeleteFromServer">0</Setting>
    <Setting Target="Adapter" Name="SubdirectoryLevels">5</Setting>
  </Item>
  <Item Name="FileHandler" Category="" ClassName="Test.BS.FileHandler" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="basepath">C:\temp\iris-folder\in_folder</Setting>
    <Setting Target="Host" Name="targetpath">C:\temp\iris-folder\work_folder</Setting>
  </Item>
</Production>
}

}
