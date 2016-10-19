DROP DATABASE  IF EXISTS `gpix`;
CREATE DATABASE IF NOT EXISTS `gpix`;
USE `gpix`;

  CREATE TABLE IF NOT EXISTS `preference` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `_key` varchar(100) NOT NULL,
    `_value` text NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `_key` (`_key`)
  );

  INSERT INTO `preference` (`id`, `_key`, `_value`) VALUES
  (1, 'gmail_username', 'gpixofficial@gmail.com'),
  (2, 'gmail_password', 'thepassword');

CREATE TABLE `servers`(
  id INT(11) NOT NULL AUTO_INCREMENT,
  _name VARCHAR (10) NOT NULL,
  _authorization VARCHAR (10) NOT NULL,
  data_url_format VARCHAR(60) NOT NULL,
  is_active TINYINT(4)  NOT NULL  DEFAULT 1 ,
  PRIMARY KEY (id)
);

INSERT INTO servers (_name, _authorization, data_url_format) VALUES ('SERVER 1', 'mySecretServerKey', 'http://gpix_server1.net23.net/?keyword=%s');

CREATE TABLE `users`(
  id INT(11) NOT NULL AUTO_INCREMENT,
  email VARCHAR(100) NOT NULL,
  api_key VARCHAR (10) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE `requests`(
  id INT(11) NOT NULL AUTO_INCREMENT,
  server_id INT(11),
  user_id INT(11) NOT NULL,
  keyword VARCHAR (20) NOT NULL,
  _limit INT(11) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (server_id) REFERENCES servers(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `images`(
  id INT(11) NOT NULL AUTO_INCREMENT,
  image_url TEXT NOT NULL,
  thumb_url TEXT NOT NULL,
  width INT(4) NOT NULL,
  height INT(4) NOT NULL,
  is_active TINYINT(4)  NOT NULL  DEFAULT 1 ,
  PRIMARY KEY(id)
);

CREATE TABLE request_image_rel(
  id INT(11) NOT NULL AUTO_INCREMENT,
  request_id INT(11) NOT NULL,
  image_id INT(11) NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (request_id) REFERENCES requests(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (image_id) REFERENCES images(id) ON UPDATE CASCADE ON DELETE CASCADE
);