DROP DATABASE  IF EXISTS `gpix`;
CREATE DATABASE IF NOT EXISTS `gpix`;
USE `gpix`;

CREATE TABLE `servers`(
  id INT(11) NOT NULL AUTO_INCREMENT, o
  x_name VARCHAR (10) NOT NULL,
  domain_name VARCHAR(60) NOT NULL,
  is_active TINYINT(4) CHECK(is_active IN (0,1)) NOT NULL DEFAULT 1,
  PRIMARY KEY (id)
);

CREATE TABLE `users`(
  id INT(11) NOT NULL AUTO_INCREMENT,
  email VARCHAR(100) NOT NULL,
  api_key VARCHAR (10) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE `requests`(
  id INT(11) NOT NULL AUTO_INCREMENT,
  server_id INT(11) NOT NULL,
  user_id INT(11) NOT NULL,
  keyword VARCHAR (20) NOT NULL,
  result TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (server_id) REFERENCES servers(id) ON UPDATE CASCADE ON DELETE CASCADE
);

