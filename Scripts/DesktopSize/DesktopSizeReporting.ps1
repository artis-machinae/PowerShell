<#
Copyright 2024 artis-machinae.github.io

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#>



$amReportLocation = "\\server01\Reports\DesktopSize\DesktopSizeReport.csv"

$amSelectedProfiles = @()  
$amUserProfiles = ( Get-ChildItem -Path $env:SystemDrive"\Users" -Exclude ("*$","Public","AppData","Default") ).Name

 
foreach ($ProfileName in $amUserProfiles) {
    if ( Test-Path $env:SystemDrive\Users\$ProfileName\Desktop ) {
		$amHashBuilder = New-Object -TypeName System.Management.Automation.PSObject
		$amDirSize = ( (Get-ChildItem $env:SystemDrive\Users\$ProfileName\Desktop -Recurse -Force | Measure-Object -property length -sum).sum / 1MB )
		$amHashBuilder | Add-Member -MemberType NoteProperty -Name "Computer Name" -Value $env:COMPUTERNAME.ToUpper()
		$amHashBuilder | Add-Member -MemberType NoteProperty -Name "User Profile" -Value $ProfileName
		$amHashBuilder | Add-Member -MemberType NoteProperty -Name "Dekstop Size (MB)" -Value $amDirSize
		$amHashBuilder | Add-Member -MemberType NoteProperty -Name "Date" -Value (Get-Date -Format "yyyy/MM/dd")
		$amSelectedProfiles += $amHashBuilder
	}
 }


function amOfflineReport {
	$amSelectedProfiles | Export-Csv -Path C:\Windows\Temp\DesktopSizeReport-Offline.CSV -NoClobber -Append -NoTypeInformation
	Write-Information "Offline report generated on local system $($env:computername) at C:\Windows\Temp"
}

 
function amReportScribe {	
	try {
		Test-Connection -Count 2 dst.local | Out-Null
		
		if (( (Test-Path $amReportLocation) -eq $False )) {
			$amSelectedProfiles | Export-Csv -Path $amReportLocation -NoClobber -Append -NoTypeInformation
		}
		elseif (  ( (Test-Path $amReportLocation) -eq $True ) -and ( (Select-String -Path $amReportLocation -pattern "$env:COMPUTERNAME" -Quiet) -ne $true) ) {
			$amSelectedProfiles | Export-Csv -Path $amReportLocation -NoClobber -Append -NoTypeInformation			
		}
	}
	
	catch [System.IO.IOException]{
		Write-Information "IO exception; trying again"
		Start-Sleep -Seconds 20
		amReportScribe
	}
	catch [System.Net.NetworkInformation.PingException] {
	amOfflineReport
	}
}
amReportScribe
