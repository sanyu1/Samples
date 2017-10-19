foreach($process in Get-Process)
{
   # Write-Host $process.name
    if($process.name -eq "EXCEL")
    {
        Stop-Process -name $process.name;
    }
}

$excel=New-Object -ComObject Excel.Application


$workbook = $excel.Workbooks.add()
#删除多余的两个表格
#$workbook.workSheets.item(3).delete()
#$workbook.workSheets.item(2).delete()
#获取要操作的表格

$sheet= = $workbook.worksheets.Item(1)
#修改表格名
$sheet.Name="Process"

#设置表头
$sheet.cells.item(1,1)="ProcessName"
$sheet.cells.item(1,2)="Working Set Size"


Function WriteData
{
     Param (
        [Parameter(ValueFromPipeline=$true)]
        [int]$Row = 2,
        [int]$Clu = 1,
        [string]$Value = ""
    )
    Write-Host $Row   $Clu  $Value
    #$sheet.cells.item($Row,$Clu) = $Value
}



#第一行为表头 数据从第二行还是
$row=2


#查询数据
#$processes = Get-Process

foreach($process in Get-Process)
{
    WriteData -Row $row -Clu 1 -Value $process.name
    WriteData -Row $row -Clu 2 -Value $process.WorkingSet
    $row++
}
#$range = $sheet.usedRange
#$range.EntireColumn.AutoFit() | out-null
#$excel.Visible =$true
$folder = Split-Path -Parent $MyInvocation.MyCommand.Definition
$workbook.SaveAs($folder+"\test.xlsx")

foreach($process in Get-Process)
{
   # Write-Host $process.name
    if($process.name -eq "EXCEL")
    {
        Stop-Process -name $process.name;
    }
}
