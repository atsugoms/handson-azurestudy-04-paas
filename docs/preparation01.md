# Preparation1: 事前準備

![](images/prep01-0000-network.png)

### ⏳ 推定時間

- 25 ~ 40分

### 🗒️ 目次

1. [インフラの展開](#インフラの展開)
1. [Windows Server の設定](#windows-server-の設定)
1. [リポジトリのクローン](#リポジトリのクローン)


## インフラの展開

1. テンプレートを利用して展開

   [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fakinaritsugo%2Fhandson-azurestudy-04-paas%2Fmain%2Finfra%2Ftemplate.json)

    (*) "Deploy ボタン" からうまく飛べない場合、 以下のJSONファイルをダウンロードして「カスタムテンプレートのデプロイ」に読み込ませる

    [ARMテンプレート JSON ファイル](https://raw.githubusercontent.com/akinaritsugo/handson-azurestudy-04-paas/main/infra/template.json)

    テンプレート設定

    |項目|設定値|設定例|
    |---|---|---|
    |サブスクリプション| AzureStudy用に準備したもの | - |
    |リソースグループ| 任意名 | `rg-{YOUR_NAME}` |
    |リージョン| 展開するリージョン | `japan east` |
    |Virtual Network Name| 仮想ネットワーク名 | `vnet-{YOUR_NAME}-main` |
    |NSG VM NAme| 仮想マシンを展開するサブネット( `snet-vm` )に取り付けるNSG名 | `nsg-{YOUR_NAME}-vm` |
    |NSG AppSvc Name| AppliactionGatewayを展開するサブネット（ `snet-gateway` ）に取り付けるNSG名 | `nsg-{YOUR_NAME}-appsvc` |
    |NSG Db Name| Private Peering を展開するサブネット（ `snet-peering` ）に取り付けるNSG名 | `nsg-{YOUR_NAME}-db` |
    |Virtual Machine Name| 仮想マシン名 | `vm-{YOUR_NAME}-winsvr` |
    |Virtual Machine Admin Username| 仮想マシンのログインユーザー名 | `azureuser` |
    |Virtual Machine Admin Password| 仮想マシンのログインパスワード| - |



## Windows Server の設定

1. RDP 接続

    1. Azureポータルにて、起動済みの仮想マシンを開く

    1. [概要]-[パブリックIPアドレス]を確認

        ![](images/prep01-0101-network.png)

    1. RDPを起動して接続

        接続できない場合、仮想マシンが所属するサブネットのセキュリティグループ `nsg-handson-vm` を確認

        必要に応じて RDP ( `TCP 3389` ) の受信ができるように設定する

1. 仮想マシンに以下を順番にインストール

    * Visual Studio Code および 拡張機能
    * Git
    * .Net 8.0 SDK
    * SQL Server Management Studio (任意)

    インストーラーは以下の通り

    1. Visual Studio Code インストール

        https://code.visualstudio.com/Download

        ダウンロードするインストーラー

          * `Windows 8, 10, 11 用`
          * `System Installer 64bit`

          ![](images/prep01-0102-network.png)

        以下の拡張機能をインストール

        <!-- * [日本語化（任意）](https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-ja) -->
        * [Azure App Service](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureappservice)

            ![](images/prep01-0103-network.png)

        * [C#](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)

            ![](images/prep01-0104-network.png)


    1. Git インストール

        https://git-scm.com/download/win

        ダウンロードするインストーラー

          * `64-bit Git for Windows Setup`

            ![](images/prep01-0105-network.png)


    1. .NET 8 SDK インストール

        https://dotnet.microsoft.com/en-us/download/dotnet/8.0

        ダウンロードするインストーラー

          * `SDK 8.0.x Windows x64 (x: 最新を選択)`

            ![](images/prep01-0106-network.png)

    1. SQL Server Management Studio インストール (任意)

        https://learn.microsoft.com/ja-jp/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16

        ![](images/prep01-0107-network.png)

<!-- 
(*) 以下の PowerShell スクリプトを「実行コマンド」から実行するとすべてインストールされる

1. 仮想マシンを開く
1. [操作]-[実行コマンド] を開く
1. `RunPowerShellScript` を選択して、以下のコマンドを貼り付け、「実行」

    コマンド実行を利用する場合、タイムアウトするので順番に実行する。

    1. Visual Studio Code インストール

            New-Item -Force -Path $env:HOMEDRIVE\temp -ItemType Directory
            cd $env:HOMEDRIVE\temp

            # Visual Studio Code
            Invoke-WebRequest -Uri https://az764295.vo.msecnd.net/stable/74b1f979648cc44d385a2286793c226e611f59e7/VSCodeSetup-x64-1.71.2.exe -OutFile VSCodeSetup.exe
            ./VSCodeSetup.exe /VERYSILENT /NORESTART /MERGETASKS=!runcode

    1. Visual Studio Code 拡張機能 インストール

            # Visual Studio Code - Extension
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
            code --force --install-extension MS-CEINTL.vscode-language-pack-ja
            code --force --install-extension ms-azuretools.vscode-azureappservice
            code --force --install-extension ms-dotnettools.csharp

    1. Git インストール

            New-Item -Force -Path $env:HOMEDRIVE\temp -ItemType Directory
            cd $env:HOMEDRIVE\temp

            # Git
            Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.37.3.windows.1/Git-2.37.3-64-bit.exe -OutFile Git.exe
            ./Git.exe /VERYSILENT /NORESTART

    1. .Net 6 SDK インストール

            New-Item -Force -Path $env:HOMEDRIVE\temp -ItemType Directory
            cd $env:HOMEDRIVE\temp

            # .Net 6 SDK
            Invoke-WebRequest -Uri https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
            ./dotnet-install.ps1 -Architecture x64 -Channel 6.0

    1. SQL Server Management Studio インストール

            New-Item -Force -Path $env:HOMEDRIVE\temp -ItemType Directory
            cd $env:HOMEDRIVE\temp

            # SQL Server Management Studio
            Invoke-WebRequest -Uri https://aka.ms/ssmsfullsetup -OutFile ssmsfullsetup.exe
            ./ssmsfullsetup.exe /install /quiet /norestart /passive

    1. すべて完了したら再起動する

        # 再起動
        Restart-Computer -Force
-->

## リポジトリのクローン

以下のリポジトリを `C:\work` 以下にクローンします。

```
https://github.com/Azure-Samples/msdocs-app-service-sqldb-dotnetcore.git
```

1. `C:\work` フォルダを作成

1. 作成したフォルダで右クリック→[Git Bash here]を選択

    ![](images/prep01-0201-gitclone.png)

1. 以下のコマンドを実行

        git clone https://github.com/Azure-Samples/msdocs-app-service-sqldb-dotnetcore.git

    ![](images/prep01-0202-gitclone.png)
