# Path to the AssemblyInfo.cs file
#$assemblyInfoPath = "C:\C#_PROGRAM\Devops student task IAI\custom_student_task\copy_project_of_assemblyinfo.cs"
#$assemblyInfoPath = "C:\C#_PROGRAM\Devops student task IAI\custom_student_task\Assembly_info\Program.cs"
#$assemblyInfoPath= "https://dev.azure.com/ilaigamzu13/Devops_student_task/_git/DevOps_task3?path=/project_2/Assembly_info.cs&version=GBmaster"


# Get the directory where the script is located
$scriptDirectory = $PSScriptRoot

# Define the relative path to the AssemblyInfo.cs file
#$assemblyInfoPath = Join-Path $scriptDirectory "Assembly_info\Program.cs"
#$assemblyInfoPath= $(Build.SourcesDirectory)
# Read the content of AssemblyInfo.cs
#$content = Get-Content -Path $assemblyInfoPath

# Value to replace with from pipeline
#param(
#    [string]$ValueFromPipeline_1,
#    [string]$ValueFromPipeline_2,
#    [string]$ValueFromPipeline_3
#)

# Define regex patterns to match AssemblyDescription and AssemblyCompany attributes
$pattern_des = '(\[assembly: AssemblyDescription\("")|(\[assembly: AssemblyDescription\(")([^"]*)("\)\])'
$pattern_com = '(\[assembly: AssemblyCompany\("")|(\[assembly: AssemblyCompany\(")([^"]*)("\)\])'
$pattern_pro = '(\[assembly: AssemblyProduct\("")|(\[assembly: AssemblyCompany\(")([^"]*)("\)\])'
$pattern_ver = '(\[assembly: AssemblyVersion\(")(\d+\.\d+\.\d+\.)(\d+)("\)\])'
$pattern_ver_file = '(\[assembly: AssemblyFileVersion\(")(\d+\.\d+\.\d+\.)(\d+)("\)\])'
# Process each line from the file
#$newContent = 
#foreach ($line in $content) {
$directories = Get-ChildItem -Directory

foreach ($directory in $directories) {
    $assemblyInfoFiles = Get-ChildItem -Path $directory.FullName -Recurse -Include AssemblyInfo.*
    foreach ($file in $assemblyInfoFiles) {
        # Perform operations on each assembly info file
    if ($file -match $pattern_des) {
         $file -replace $pattern_des, ('[assembly: AssemblyDescription("{0}")]' -f $ValueFromPipeline_1)
        
    }
    elseif ($file -match $pattern_com) {
        $file -replace $pattern_com, ('[assembly: AssemblyCompany("{0}")]' -f $ValueFromPipeline_2)
        
    }
    elseif ($file -match $pattern_pro) {
         $file -replace $pattern_pro, ('[assembly: AssemblyCompany("{0}")]' -f $ValueFromPipeline_3)
        
    }
    elseif($$file -match $pattern_ver){
        $majorMinorBuild = $matches[2]
        $lastDigit = [int]$matches[3] + 1
        $newVersion = "${majorMinorBuild}$lastDigit"
        $file-replace $pattern_ver, ('[assembly: AssemblyVersion("{0}")]' -f $newVersion)
        
    }
    elseif($line -match $pattern_ver_file){
        $majorMinorBuild = $matches[2]
        $lastDigit = [int]$matches[3] + 1
        $newVersion = "${majorMinorBuild}$lastDigit"
        $file -replace $pattern_ver_file, ('[assembly: AssemblyFileVersion("{0}")]' -f $newVersion)
        
    }
    else {
        $file
    }
}
    }
}
   

# Save the modified content back to AssemblyInfo.cs
#$newContent | Set-Content -Path $assemblyInfoPath

