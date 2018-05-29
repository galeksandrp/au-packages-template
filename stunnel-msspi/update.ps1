import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
	$release = (curl "https://api.github.com/repos/deemru/stunnel/releases/latest?client_id=$env:GITHUB_CLIENT_ID&client_secret=$env:GITHUB_CLIENT_SECRET" | ConvertFrom-Json)
	
	@{
        URL32   = ($release.assets -match '_windows-386.zip').browser_download_url
		URL64   = ($release.assets -match '_windows-amd64.zip').browser_download_url
        Version = $release.tag_name -replace 'stunnel-','' -replace '-msspi-','.'
    }
}

update