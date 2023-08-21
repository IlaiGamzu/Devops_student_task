param( #The value from pipeline
    [string]$ValueFromPipeline_1,
    [string]$ValueFromPipeline_2,
    [string]$ValueFromPipeline_3
)

# Check output
Write-Host "ValueFromPipeline_1 is: $ValueFromPipeline_1"
Write-Host "ValueFromPipeline_2 is: $ValueFromPipeline_2"
Write-Host "ValueFromPipeline_3 is: $ValueFromPipeline_3"

# Path to the AssemblyInfo.cs file
$assemblyInfoPath = Get-ChildItem "$PSScriptRoot\sort_list.AssemblyInfo.cs"

# Read the content of AssemblyInfo.cs
$content = Get-Content -Path $assemblyInfoPath


# Regex for assemblyInfo file
$pattern_des = '\[assembly: System\.Reflection\.AssemblyTitleAttribute\(".*?"\)\]'
$pattern_com = '\[assembly: System\.Reflection\.AssemblyCompanyAttribute\(".*?"\)\]'
$pattern_pro = '\[assembly: System\.Reflection\.AssemblyProductAttribute\(".*?"\)\]'
$pattern_ver = '\[assembly: System\.Reflection\.AssemblyVersionAttribute\("(\d+\.\d+\.\d+\.)(\d+)"\)\]'
#$pattern_ver_file  = '\[assembly: System\.Reflection\.AssemblyFileVersionAttribute\("(\d+\.\d+\.\d+\.)(\d+)"\)\]'
$pattern_ver_file = '\[assembly: System\.Reflection\.AssemblyFileVersionAttribute\("(\d+)\.(\d+)\.(\d+)\.(\d+)"\)\]'


# The new content that wiil overiding the current version of assembly info 
$newContent = foreach ($line in $content) {
    Write-Host "Processing line: $line"
    
        if( $line -match $pattern_des ){ #The description of file
            '[assembly: System.Reflection.AssemblyTitleAttribute("{0}")]' -f $ValueFromPipeline_1
        }
        elseif( $line -match $pattern_com ){ #The company file
            '[assembly: System.Reflection.AssemblyCompanyAttribute("{0}")]' -f $ValueFromPipeline_2
        }
         elseif( $line -match $pattern_pro ) { # The product line
            '[assembly: System.Reflection.AssemblyProductAttribute("{0}")]' -f $ValueFromPipeline_3
        }
        elseif( $line -match $pattern_ver ) { #The version line
            
            $digit_not_changes = $matches[1]
            $lastDigit = [int]$matches[2] + 1
            $newVersion = "${digit_not_changes}$lastDigit"
            ('[assembly: System.Reflection.AssemblyVersionAttribute("{0}")]' -f $newVersion)
        }
        elseif( $line -match $pattern_ver_file ) { #The versionFile
            $lastdig = [int]$matches[4] + 1
            $newVersion = "$($matches[1]).$($matches[2]).$($matches[3]).$lastdig"
            ('[assembly: System.Reflection.AssemblyFileVersionAttribute("{0}")]' -f $newVersion)      
        }
        else {
            $line 
            }
    }
#}

# Save the new content back to AssemblyInfo.cs
$newContent | Set-Content -Path $assemblyInfoPath
