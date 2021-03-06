# Create source code directory
New-Item -ItemType Directory -Path $PWD -Name src

# Create tools directory and NuGet subdirectory
New-Item -ItemType Directory -Path $PWD -Name tools\nuget

$webClient = New-Object System.Net.WebClient

# Download NuGet binary
$url = "http://nuget.org/nuget.exe"
$file = "$PWD\tools\nuget\nuget.exe"
$webClient.DownloadFile($url, $file)

# Download Git ignore file
$url = "https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore"
$file = "$PWD\.gitignore"
$webClient.DownloadFile($url, $file)

# Comment out "build/" from .gitignore
$lines = [System.IO.File]::ReadAllLines($file)
$newLines = @()
foreach($line in $lines)
{
	if($line.ToLower().Contains("build/") -and !$line.ToLower().Contains("#"))
	{
		$line = "# " + $line
	}
	$newLines += $line
}
[System.IO.File]::WriteAllLines($file, $newLines)

# Download Git attributes file
$url = "https://raw.githubusercontent.com/Danimoth/gitattributes/master/CSharp.gitattributes"
$file = "$PWD\.gitattributes"
$webClient.DownloadFile($url, $file)

# Init Git repo
iex -Command "git init"
iex -Command "git add ."
iex -Command "git commit -m 'Scaffolding'"