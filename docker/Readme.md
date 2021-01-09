
■起動方法
　コマンドラインで、カレントディレクトリをdocker-compose.ymlと同じディレクトリに変更後
　以下のコマンドを実行（Dockerがインストールされている前提）
　docker-compose up -d

■バージョン
　nginx：1.18.0 (開発標準の要件)
　MySQL：5.6 (開発標準の要件は5.7だが、一旦旧システムのDBを構築するため)
　PHP-FPM：7.4 (開発標準の要件)
　Lumen : 6.3.3  (開発標準の要件。2020/12/17時点の最新のLaravelのLTSが6.0でこのコンポーネントを使用している最新版)
　phpMyAdmin 5.0.4 (最新版。MySQLのメンテナンス用)

■各サービスのポート番号
　PHP(nginx) : 80
　phpMyAdmin : 8888
　MySQL : 3306

　phpとphpMyAdminは「localhost:ポート番号」でブラウザでアクセスできます。
  phpMyAdminは接続できるまで時間がかかる場合があります（MySQLの起動に時間がかかる場合があるため）。
