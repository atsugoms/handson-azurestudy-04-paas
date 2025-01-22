# Exercise3: SQL Database のスキーマ生成

![](images/ex03-0000-schema.png)

### ⏳ 推定時間

- 5 ~ 10分

### 🗒️ 目次

1. [SQL Database への接続文字列取得](#sql-database-への接続文字列取得)
1. [SQL Database への接続設定](#sql-database-への接続設定)
1. [SQL Database の初期化](#sql-database-の初期化)
1. [SQL Database のスキーマ確認](#sql-database-のスキーマ確認)

## SQL Database への接続文字列取得

(*) Azureポータル上で実施

1. Azure ポータルで作成した SQL Database を開く

1. [設定]-[接続文字列]を開く

1. ADO.NET の 「接続文字列」を取得

    **記載された接続文字列は「パスワード」がプレースホルダになっているので、**
    **ご自身のパスワードに書き換えを行ってから利用します。**

    ![](images/ex03-0101-schema.png)

## SQL Database への接続設定

(*) 仮想マシンの中で実施


1. RDP で開発用仮想マシンへ接続

1. 環境準備にてクローンしておいたプロジェクトを Visual Studio Code で開く

1. 接続文字列を修正

    1. `/appsettings.json` を開く

    1. `ConnectionsStrings.MyDbConnection` の値をあらかじめ取得しておいた接続文字列で書き換え

        ![](images/ex03-0102-schema.png)

## SQL Database の初期化
<!-- 
(*) 仮想マシンの中で実施

1. RDP で開発用仮想マシンへ接続

1. PowerShell を管理者で起動、プロジェクトディレクトリに移動して、以下のコマンドを実行

    ```
    dotnet tool install -g dotnet-ef --version 8.*
    dotnet ef migrations add InitialCreate
    dotnet ef database update
    ```

    実行結果イメージ

    ![](images/ex03-0103-schema.png)

(*) Visual Studio Code の統合ターミナルでうまく動作しない場合、PowerShellを管理者起動して実行を試す
-->

(*) Azure ポータルで実施

1. Azure ポータルへ入って作成済みの SQL Database を開く

1. [クエリエディター] を開く

1. 「SQL Server 認証」 を使ってログイン

    ![](images/ex03-0401-schema.png)

1. 以下のクエリを実行

    ```
    IF OBJECT_ID(N'__EFMigrationsHistory', N'U') IS NOT NULL
        DROP TABLE __EFMigrationsHistory;

    IF OBJECT_ID(N'Todo', N'U') IS NOT NULL
        DROP TABLE Todo;

    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );

    CREATE TABLE [Todo] (
        [ID] int NOT NULL IDENTITY,
        [Description] nvarchar(max) NULL,
        [CreatedDate] datetime2 NOT NULL,
        CONSTRAINT [PK_Todo] PRIMARY KEY ([ID])
    );
    ```

    ![](images/ex03-0403-schema.png)

## SQL Database のスキーマ確認

(*) Azureポータル上で実施

1. Azure ポータルへ入って作成済みの SQL Database を開く

1. [クエリエディター] を開く

1. 「SQL Server 認証」 を使ってログイン

    ![](images/ex03-0401-schema.png)

1. [テーブル]-[db.Todo]を開き、スキーマが登録されていることを確認

    ![](images/ex03-0402-schema.png)


# 次の Exercise へ

* [App Service へアプリのデプロイ](exercise04.md)

