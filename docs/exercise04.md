# Exercise4: App Service へアプリのデプロイ

## 【目次】

![](images/ex04-0000-deploy.png)


1. [アプリケーションのローカル動作確認](#アプリケーションのローカル動作確認)
1. [アプリケーションのデプロイ](#アプリケーションのデプロイ)
1. [アプリケーションの設定](#アプリケーションの設定)
1. [アプリケーションの動作確認](#アプリケーションの動作確認)
1. [SQL Database へデータ登録されたことを確認](#sql-database-へデータ登録されたことを確認)


## アプリケーションのローカル動作確認

(*) 仮想マシンの中で実施

1. RDP で開発用仮想マシンへ接続

1. 環境準備にてクローンしておいたプロジェクトを Visual Studio Code で開く

1. 統合ターミナル（PowerShell）を開き、ビルド＆実行

    ```
    dotnet run
    ```

1. メッセージに出てくるホストへ接続

    ![](images/ex04-0001-localrun.png)

1. 統合ターミナル上で `[Ctrl]+[C]` を押下して実行停止


## アプリケーションのデプロイ

(*) 仮想マシンの中で実施

1. RDP で開発用仮想マシンへ接続

1. 環境準備にてクローンしておいたプロジェクトを Visual Studio Code で開く

1. 左メニューの「Azure」アイコンを選択

    ![](images/ex04-0101-deploy.png)

1. 「Sign in to Azure」を選択、Azureにサインイン

    ![](images/ex04-0102-deploy.png)

1. サブスクリプション、App Services を展開して 作成済 の App Service を右クリック、「Deploy to Web App」を選択

    ![](images/ex04-0103-deploy.png)

1. デプロイする対象のフォルダ選択がでるので `msdocs-app-service-sqldb-dotnetcore` を選択

    ![](images/ex04-0104-deploy.png)

    設定ファイルの追加メッセージが表示された場合、 `Add Config` を選択

    ![](images/ex04-0105-deploy.png)
<!-- 
    設定を更新するかどうかのメッセージが表示された場合、 `No` を選択

    ![](images/ex04-0106-deploy.png)
-->


## アプリケーションの設定

(*) Azureポータル上で実施

1. Azure ポータルで作成済みの App Service を開き、[設定]-[環境変数] を開く

1. 「アプリ設定」タブにある「追加」を選択して、以下の環境変数を追加

    |名前|値|デプロイスロットの設定|
    |---|---|---|
    | ASPNETCORE_ENVIRONMENT | `Development` | ✓ (ON) |
    | MyDbConnection | (SQL Database への接続文字列) | ✓ (ON) |

1. 「適用」を選択、「確認」を選択して保存


## アプリケーションの動作確認

(*) Azureポータル上で実施

1. Azure ポータルで作成済みの App Service を開き、 URL を確認

    ![](images/ex04-0201-deploy.png)

1. 別ブラウザで開いてアプリが動作していることを確認

    ![](images/ex04-0202-deploy.png)

1. 「Create New」を選択

    ![](images/ex04-0203-deploy.png)

1. 適当な値を入力して「Create」

    * Description: (任意)
    * Created Date: (任意)

    ![](images/ex04-0204-deploy.png)

1. 新規にレコードが追加されたことを確認

    ![](images/ex04-0205-deploy.png)


## SQL Database へデータ登録されたことを確認

(*) Azureポータル上で実施

1. Azureポータルで作成済みの SQL Database を開く

1. 「クエリエディター」を開く

1. 以下のクエリを実行、登録したデータが存在することを確認

        select * from [dbo].[Todo];

   ![](images/ex04-0206-deploy.png)


# 次の Exercise へ

* [App Service スロットの活用](exercise05.md)

