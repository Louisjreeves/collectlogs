 

#$cred = Get-Credential

 

 

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

 


$mydownloads = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

$MyTemp =(Get-Item $mydownloads).fullname

$myuser= $env:USERNAME


 

   $response = Invoke-WebRequest -Uri https://github.com/Louisjreeves/collectlogs/raw/7dc93217d0785e18bc54e8c6ec767d74cb3bf172/collectlogs.zip -OutFile $mytemp\collectlogs.zip

 


    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ;Expand-Archive -Path $mytemp\collectlogs.zip -DestinationPath $mydownloads\collectlogs -Force

 


 $activedirectory = "C:\Users\$myuser\downloads\collectlogs\"

cd c:\

set-location $activedirectory

  .\collectlogs.ps1 

 




  
