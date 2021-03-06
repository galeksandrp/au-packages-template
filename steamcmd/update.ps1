import-module au
import-module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
	$URL32 = 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip'
	Get-ChocolateyWebFile 'steamcmd' "$env:TMP\steamcmd.zip" $URL32
    Get-ChocolateyUnzip "$env:TMP\steamcmd.zip" "$env:TMP" -SpecificFolder "steamcmd.exe"
	
	@{
        URL32   = $URL32
        Version = (Get-Item "$env:TMP\steamcmd.exe").VersionInfo.ProductVersion
    }
}

update
