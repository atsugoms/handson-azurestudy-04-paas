# Exercise7: 閉域化

## 【目次】

![](images/ex07-0000-closed.png)

1. SQL Database の 閉域化
1. SQL Database へ接続できないことの確認
1. App Service の閉域化
1. App Service の動作確認


## SQL Database の 閉域化

(*) Azureポータル上で実施

1. Azureポータル上で作成済みの SQL Database を開く

1. 概要欄にある「サーバー名」を選択

    ![](images/ex07-0101-closed.png)

1. [セキュリティ]-[ネットワーク]を開く

    ![](images/ex07-0102-closed.png)

1. 「プライベートアクセス」タブへ移動

    ![](images/ex07-0103-closed.png)

1. 「プライベートエンドポイントを作成」を選択

    ![](images/ex07-0104-closed.png)

1. プライベートエンドポイントの作成

    1. 基本

        * サブスクリプション： (ハンズオン用に用意したもの)
        * リソースグループ： (環境準備で用意したもの)
        * 名前： (任意)
        * ネットワークインターフェース名： (任意)
        * 地域： `Japan East`

        ![](images/ex07-0105-closed.png)

    1. リソース

        * 対象サブリソース： `sqlServer`

        ![](images/ex07-0106-closed.png)

    1. 仮想ネットワーク

        * 仮想ネットワーク： (環境準備で作成済みのもの)
        * サブネット： (DB用のサブネット)
        * プライベートIP構成： `IPアドレスを動的に割り当てる`

        ![](images/ex07-0107-closed.png)

    1. DNS

        * プライベートDNSゾーンと統合する： `はい`

        ![](images/ex07-0108-closed.png)

    1. タグ

        特に指定なし

    1. 確認および作成

        内容を確認して「作成」

1. プライベートエンドポイントの作成が終わったら
    [セキュリティ]-[ネットワーク]の「パブリックアクセス」へ戻って
    「パブリックネットワークアクセス」を `無効化` して「保存」

    ![](images/ex07-0109-closed.png)



## SQL Database へ接続できないことの確認

(*) Azureポータル上で実施

1. Azureポータル上で作成済みの SQL Database を開く

1. [クエリエディター]を開く

    ![](images/ex07-0201-closed.png)


1. SQL Server 認証でログインを試行

    エラーになってログインできないことを確認

    ![](images/ex07-0202-closed.png)


1. Azureポータル上で作成済みの App Service を開く

1. 概要欄にある URL を確認

1. 別ブラウザ/タブ で URL を開く

    データが取得できずレコードが空になっていることを確認

    ![](images/ex07-0203-closed.png)




## App Service の閉域化

(*) Azureポータル上で実施

1. Azureポータル上で作成済みの App Service を開く

1. [構成]-[ネットワーク]を開く

    ![](images/ex07-0301-closed.png)

1. 「VNET統合」を選択

    ![](images/ex07-0302-closed.png)

1. 「VNetの追加」を選択

    ![](images/ex07-0303-closed.png)

1. 作成済みのサブネットを選択して「OK」

    ![](images/ex07-0304-closed.png)


## App Service の動作確認

(*) Azureポータル上で実施

1. Azureポータル上で作成済みの App Service を開く

1. 概要欄にある URL を確認

1. 別ブラウザ/タブで URL を開く

    問題なく初期ページ（ToDoの一覧）が表示されることを確認

    ![](images/ex07-0401-closed.png)


