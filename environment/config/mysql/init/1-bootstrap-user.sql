USE sams_books_database;

SET CHARSET UTF8;
SET CHARACTER_SET_CLIENT = utf8;
SET CHARACTER_SET_CONNECTION = utf8;

CREATE USER 'samsbooks'@'%' IDENTIFIED BY '2hKFZFo@%y29&';
GRANT ALL ON `sams_books_database`.* TO 'samsbooks'@'%';
FLUSH PRIVILEGES;

