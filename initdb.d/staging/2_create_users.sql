USE database_staging;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
  id           INT(10),
  name     VARCHAR(40)
);