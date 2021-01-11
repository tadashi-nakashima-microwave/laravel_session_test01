FROM mysql:5.6

EXPOSE 3306

# 環境変数設定はdocker-omposeの方で行うのでコメントアウト
# ENV MYSQL_ROOT_PASSWORD="root" \
#     MYSQL_DATABASE="epark" \
#     MYSQL_USER="user" \
#     MYSQL_PASSWORD="user"

#MySQL設定ファイルをイメージ内にコピー
COPY ./my.cnf /etc/mysql/conf.d/mysql.cnf

#環境構築時に実行するsql(スキーマ作成、初期データなど)
#COPY ./20201214_faspa_DDL.sql /docker-entrypoint-initdb.d/20201214_faspa_DDL.sql

# mysql -u root --password=root epark < 20201214_faspa_DDL.sql

