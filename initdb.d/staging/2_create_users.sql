USE staging_db;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
  id           INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name     VARCHAR(40),
  email     VARCHAR(120),
  nickname     VARCHAR(40)
);
