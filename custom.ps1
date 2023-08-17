 $newCompany = 'New Company Name'
      $newDescription = 'New Description'
      $newProduct = 'New Product Name'
      $versionNumber = '1.0.0.'
      $fileVersionNumber = '1.0.0.'

      $lastDigit = $env:BUILD_BUILDNUMBER.Split('.')[-1]
      $newVersionNumber = $versionNumber + $lastDigit
      $newFileVersionNumber = $fileVersionNumber + $lastDigit

      Write-Host "Updating AssemblyInfo with Company: $newCompany, Description: $newDescription, Product: $newProduct, VersionNumber: $newVersionNumber, FileVersionNumber: $newFileVersionNumber"

      # Update AssemblyInfo using Assembly-Info-NetCore task
      Write-Host "##vso[task.setvariable variable=AssemblyInfo.Company;isOutput=true]$newCompany"
      Write-Host "##vso[task.setvariable variable=AssemblyInfo.Description;isOutput=true]$newDescription"
      Write-Host "##vso[task.setvariable variable=AssemblyInfo.Product;isOutput=true]$newProduct"
      Write-Host "##vso[task.setvariable variable=AssemblyInfo.VersionNumber;isOutput=true]$newVersionNumber"
      Write-Host "##vso[task.setvariable variable=AssemblyInfo.FileVersionNumber;isOutput=true]$newFileVersionNumber"