USE production_db;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
  id           INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name      VARCHAR(40),
  email     VARCHAR(120),
  nickname     VARCHAR(40)
);

CREATE TABLE articles
(
  id           INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
  title      VARCHAR(40),
  user_id    INT,
  INDEX user_id (user_id), FOREIGN KEY (user_id) REFERENCES users(id)
);
