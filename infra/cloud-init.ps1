# -----------------------------------
# Visual Studio Code
# -----------------------------------
New-Item -Force -Path $env:HOMEDRIVE\temp -ItemType Directory
cd $env:HOMEDRIVE\temp

# Visual Studio Code
Invoke-WebRequest -Uri https://az764295.vo.msecnd.net/stable/74b1f979648cc44d385a2286793c226e611f59e7/VSCodeSetup-x64-1.71.2.exe -OutFile VSCodeSetup.exe
./VSCodeSetup.exe /VERYSILENT /NORESTART /MERGETASKS=!runcode

# Visual Studio Code - Extension
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
code --force --install-extension MS-CEINTL.vscode-language-pack-ja
code --force --install-extension ms-azuretools.vscode-azureappservice
code --force --install-extension ms-dotnettools.csharp


# -----------------------------------
# Git
# -----------------------------------
New-Item -Force -Path $env:HOMEDRIVE\temp -ItemType Directory
cd $env:HOMEDRIVE\temp

# Git
Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.37.3.windows.1/Git-2.37.3-64-bit.exe -OutFile Git.exe
./Git.exe /VERYSILENT /NORESTART


# -----------------------------------
# .Net 6 SDK
# -----------------------------------
New-Item -Force -Path $env:HOMEDRIVE\temp -ItemType Directory
cd $env:HOMEDRIVE\temp

# .Net 6 SDK
Invoke-WebRequest -Uri https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
./dotnet-install.ps1 -Architecture x64 -Channel 6.0


# -----------------------------------
# SQL Server Management Studio
# -----------------------------------
New-Item -Force -Path $env:HOMEDRIVE\temp -ItemType Directory
cd $env:HOMEDRIVE\temp

# SQL Server Management Studio
Invoke-WebRequest -Uri https://aka.ms/ssmsfullsetup -OutFile ssmsfullsetup.exe
./ssmsfullsetup.exe /install /quiet /norestart /passive


# -----------------------------------
# 再起動
Restart-Computer -Force
