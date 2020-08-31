# digdag-embulk-rdb-production-to-staging

DB の起動

```
$ docker-compose up --force-recreate --build production_db staging_db
```

staging テーブルの確認

```
$ docker-compose exec staging_db bash

# mysql -u root -ppassword

> USE staging_db;
> SHOW tables;
```

```
$ cd ./jobdag/
$ digdag run jobdag.dig
```

produciton のデータが移行されているか確認

```
$ docker-compose exec staging_db bash

# mysql -u root -ppassword

> USE staging_db;
> SHOW tables;
```
