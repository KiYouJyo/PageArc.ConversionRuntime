param(
    [string]$Version = '9.13.0',
    [string]$PackageVersion = '9.13.0-pagearc.1',
    [string]$OutputDirectory = (Join-Path $PSScriptRoot '..\artifacts')
)

$ErrorActionPreference = 'Stop'
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
$work = Join-Path ([IO.Path]::GetTempPath()) "PageArc-ConversionRuntime-$PackageVersion"
Remove-Item $work -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force $work, $OutputDirectory | Out-Null

$releaseBase = "https://download.calibre-ebook.com/$Version"
$installerName = "calibre-64bit-$Version.msi"
$sourceName = "calibre-$Version.tar.xz"
$msi = Join-Path $work $installerName
$source = Join-Path $OutputDirectory $sourceName

Write-Host "Downloading official calibre $Version installer..."
Invoke-WebRequest -Uri "$releaseBase/$installerName" -OutFile $msi -UseBasicParsing
if (-not (Test-Path $msi) -or (Get-Item $msi).Length -lt 1MB) { throw 'calibre installer download is missing or unexpectedly small.' }

$extract = Join-Path $work 'extract'
New-Item -ItemType Directory -Force $extract | Out-Null
$process = Start-Process msiexec.exe -ArgumentList @('/a', "`"$msi`"", '/qn', "TARGETDIR=`"$extract`"") -PassThru -Wait
if ($process.ExitCode -ne 0) { throw "calibre administrative extraction failed with exit code $($process.ExitCode)." }

$converter = Get-ChildItem $extract -Recurse -Filter 'ebook-convert.exe' | Select-Object -First 1
if (-not $converter) { throw 'ebook-convert.exe was not found in the extracted calibre installer.' }
$runtimeRoot = Split-Path -Parent $converter.FullName

$packageRoot = Join-Path $work 'package'
$runtimeTarget = Join-Path $packageRoot 'runtime'
New-Item -ItemType Directory -Force $runtimeTarget | Out-Null
Copy-Item (Join-Path $runtimeRoot '*') $runtimeTarget -Recurse -Force
Copy-Item (Join-Path $PSScriptRoot '..\THIRD_PARTY_NOTICES.md') $packageRoot

@("PageArc Conversion Runtime", "Package: $PackageVersion", "calibre: $Version", "Platform: Windows x64", "Executable: runtime/ebook-convert.exe") | Set-Content (Join-Path $packageRoot 'RUNTIME.txt') -Encoding utf8

$archive = Join-Path $OutputDirectory 'PageArc.ConversionRuntime-win-x64.zip'
Remove-Item $archive -Force -ErrorAction SilentlyContinue
Compress-Archive -Path (Join-Path $packageRoot '*') -DestinationPath $archive -CompressionLevel Optimal

Write-Host 'Downloading corresponding calibre source...'
Invoke-WebRequest -Uri "$releaseBase/$sourceName" -OutFile $source -UseBasicParsing
if (-not (Test-Path $source) -or (Get-Item $source).Length -lt 1MB) { throw 'calibre source archive download is missing or unexpectedly small.' }

$archiveInfo = Get-Item $archive
$sha = (Get-FileHash $archive -Algorithm SHA256).Hash.ToLowerInvariant()
$sourceSha = (Get-FileHash $source -Algorithm SHA256).Hash.ToLowerInvariant()
$manifest = [ordered]@{ schemaVersion = 1; runtimeId = 'pagearc-calibre'; packageVersion = $PackageVersion; calibreVersion = $Version; minimumPageArcVersion = '1.4.0'; platform = 'windows'; architecture = 'x64'; archiveFileName = $archiveInfo.Name; archiveSize = $archiveInfo.Length; sha256 = $sha; executableRelativePath = 'runtime/ebook-convert.exe'; sourceFileName = $sourceName }
$manifest | ConvertTo-Json -Depth 4 | Set-Content (Join-Path $OutputDirectory 'runtime-manifest.json') -Encoding utf8
@("$sha  $($archiveInfo.Name)", "$sourceSha  $sourceName") | Set-Content (Join-Path $OutputDirectory 'SHA256SUMS.txt') -Encoding ascii

& (Join-Path $runtimeTarget 'ebook-convert.exe') --version
if ($LASTEXITCODE -ne 0) { throw 'Prepared ebook-convert runtime failed to start.' }
Write-Host "Prepared $PackageVersion at $OutputDirectory"
Write-Host "Runtime archive SHA-256: $sha"
