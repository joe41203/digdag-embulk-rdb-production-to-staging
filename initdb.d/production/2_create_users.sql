USE production_db;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
  id           INT(10),
  name      VARCHAR(40),
  email     VARCHAR(40)
);
