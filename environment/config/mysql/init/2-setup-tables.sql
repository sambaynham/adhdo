USE sams_books_database;

SET CHARSET UTF8;
SET CHARACTER_SET_CLIENT = utf8;
SET CHARACTER_SET_CONNECTION = utf8;

CREATE TABLE `user` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `email` varchar(180) NOT NULL,
    `roles` longtext NOT NULL COMMENT '(DC2Type:json)',
    `user_forename` varchar(255) NOT NULL,
    `user_surname` varchar(255) NOT NULL,
    `user_foa` varchar(255) NOT NULL,
    `password` varchar(255) NOT NULL,
    PRIMARY KEY (`id`),
                        UNIQUE KEY `UQ_EMAIL` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `categories` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `label` varchar(255) NOT NULL,
    `handle` varchar(255) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_HANDLE` (`handle`),
    KEY `IDX_LABEL` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `author` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `name` varchar(255) NOT NULL,
      `date_of_birth` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
      `biography` longtext NOT NULL,
      `date_of_death` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
      `slug` varchar(255) NOT NULL,
      `image_uri` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`),
      UNIQUE KEY `slug_UNIQUE` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `books` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `author_id` int(11) DEFAULT NULL,
    `title` varchar(140) NOT NULL,
    `publication_date` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
    `price_centessimal` int(11) NOT NULL,
    `cover_image_uri` varchar(255) DEFAULT NULL,
    `sku` varchar(255) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UQ_sku` (`sku`),
    KEY `IDX_AUTHOR_ID` (`author_id`),
    KEY `ITX_TITLE` (`title`),
    CONSTRAINT `FK_AUTHOR_ID` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `book_category` (
    `book_id` int(11) NOT NULL,
    `category_id` int(11) NOT NULL,
    PRIMARY KEY (`book_id`,`category_id`),
    KEY `IDX_BOOK_ID` (`book_id`),
    KEY `IDX_CATEGORY_ID` (`category_id`),
    CONSTRAINT `FK_CATEGORIES_ID` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
    CONSTRAINT `FK_BOOKS_ID` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
