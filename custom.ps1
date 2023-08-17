# Path to the AssemblyInfo.cs file
#$assemblyInfoPath = "C:\C#_PROGRAM\Devops student task IAI\custom_student_task\copy_project_of_assemblyinfo.cs"
#$assemblyInfoPath = "C:\C#_PROGRAM\Devops student task IAI\custom_student_task\Assembly_info\Program.cs"
# Read the content of AssemblyInfo.cs
assemblyInfoPath ='$(Build.SourcesDirectory)/Assembly_info'
$content = Get-Content -Path $assemblyInfoPath

# Value to replace with from pipeline
param(
    [string]$ValueFromPipeline_1,
    [string]$ValueFromPipeline_2,
    [string]$ValueFromPipeline_3
)

# Define regex patterns to match AssemblyDescription and AssemblyCompany attributes
$pattern_des = '(\[assembly: AssemblyDescription\("")|(\[assembly: AssemblyDescription\(")([^"]*)("\)\])'
$pattern_com = '(\[assembly: AssemblyCompany\("")|(\[assembly: AssemblyCompany\(")([^"]*)("\)\])'
$pattern_pro = '(\[assembly: AssemblyProduct\("")|(\[assembly: AssemblyCompany\(")([^"]*)("\)\])'
$pattern_ver = '(\[assembly: AssemblyVersion\(")(\d+\.\d+\.\d+\.)(\d+)("\)\])'
$pattern_ver_file = '(\[assembly: AssemblyFileVersion\(")(\d+\.\d+\.\d+\.)(\d+)("\)\])'
# Process each line from the file
$newContent = foreach ($line in $content) {
    if ($line -match $pattern_des) {
        $newLine_1 = $line -replace $pattern_des, ('[assembly: AssemblyDescription("{0}")]' -f $ValueFromPipeline_1)
        $newLine_1
    }
    elseif ($line -match $pattern_com) {
        $newLine_2 = $line -replace $pattern_com, ('[assembly: AssemblyCompany("{0}")]' -f $ValueFromPipeline_2)
        $newLine_2
    }
    elseif ($line -match $pattern_pro) {
        $newLine_2 = $line -replace $pattern_pro, ('[assembly: AssemblyCompany("{0}")]' -f $ValueFromPipeline_3)
        $newLine_2
    }
    elseif($line -match $pattern_ver){
        $majorMinorBuild = $matches[2]
        $lastDigit = [int]$matches[3] + 1
        $newVersion = "${majorMinorBuild}$lastDigit"
        $newLine = $line -replace $pattern_ver, ('[assembly: AssemblyVersion("{0}")]' -f $newVersion)
        $newLine
    }
    elseif($line -match $pattern_ver_file){
        $majorMinorBuild = $matches[2]
        $lastDigit = [int]$matches[3] + 1
        $newVersion = "${majorMinorBuild}$lastDigit"
        $newLine = $line -replace $pattern_ver_file, ('[assembly: AssemblyFileVersion("{0}")]' -f $newVersion)
        $newLine
    }
    else {
        $line
    }
}

# Save the modified content back to AssemblyInfo.cs
$newContent | Set-Content -Path $assemblyInfoPath

