START TRANSACTION;
INSERT INTO `sams_books_database`.`author`
    (
        `name`,
        `date_of_birth`,
        `biography`,
        `date_of_death`,
        `slug`,
        `image_uri`
    )
VALUES
    (
        'Alexandre Dumas',
        '1802-07-24 00:00:00',
        'French novelist and playwright. His works have been translated into many languages and he is one of the most widely read French authors.',
        '1870-12-05 00:00:00',
        'alexandre-dumas',
        '/build/images/author-headshots/alexandre-dumas.jpg'
    ),
    (
        'Jane Austen',
        '1775-12-16 00:00:00',
        'English novelist known for novels which implicitly interpret, critique, and comment upon the British landed gentry at the end of the 18th century.',
        '1817-07-18 00:00:00',
        'jane-austen',
        '/build/images/author-headshots/jane-austen.jpg'
    ),
    (
        'Arthur Conan-Doyle',
        '1859-05-22 00:00:00',
        'British writer and physician. He created the character Sherlock Holmes in 1887 for A Study in Scarlet, the first of four novels and fifty-six short stories about Holmes and Dr. Watson.',
        '1930-07-7 00:00:00',
        'arthur-conan-doyle',
        '/build/images/author-headshots/conan-doyle.jpg'
    );
COMMIT;

START TRANSACTION;
INSERT INTO `sams_books_database`.`categories`
    (
        `label`,
        `handle`
    )
VALUES
    (
        'Adventure',
        'adventure'
    ),
    (
        'Historical',
        'historical'
    ),
    (
        'Swash-buckling',
        'swashbuckling'
    ),
    (
        'Romance',
        'romance'
    ),
    (
        'Satire',
        'satire'
    ),
    (
        'Mystery',
        'mystery'
    );

START TRANSACTION;
SET @AUTHOR_ID_DUMAS = (SELECT `id` FROM sams_books_database.author WHERE `slug` = 'alexandre-dumas');
SET @AUTHOR_ID_AUSTEN = (SELECT `id` FROM sams_books_database.author WHERE `slug` = 'jane-austen');
SET @AUTHOR_ID_DOYLE = (SELECT `id` FROM sams_books_database.author WHERE `slug` = 'arthur-conan-doyle');
INSERT INTO `sams_books_database`.`books`
    (
         `author_id`,
         `title`,
         `publication_date`,
         `price_centessimal`,
        `sku`,
         `cover_image_uri`
    )
VALUES
    (
        @AUTHOR_ID_DUMAS,
        'The Three Musketeers',
        '1844-03-01 00:00:00',
        '999',
        'AD.TTM.1844',
        '/build/images/book-covers/three-musketeers.jpg'
    ),
    (
        @AUTHOR_ID_DUMAS,
        'The Count of Monte Cristo',
        '1844-01-01 00:00:00',
        '1999',
        'AD.TCOMC.1844',
        '/build/images/book-covers/count-of-monte-cristo.png'
    ),
    (
        @AUTHOR_ID_DUMAS,
        'The Man in the Iron Mask',
        '1847-01-01 00:00:00',
        '1999',
        'AD.TMITIM.1847',
        '/build/images/book-covers/the-man-in-the-iron-mask.jpg'
    ),
    (
        @AUTHOR_ID_AUSTEN,
        'Sense and Sensibility',
        '1811-01-01 00:00:00',
        '999',
        'JA.SAS.1811',
        '/build/images/book-covers/sense-and-sensibility.jpg'
    ),
    (
        @AUTHOR_ID_AUSTEN,
        'Pride and Prejudice',
        '1813-01-28 00:00:00',
        '999',
        'JA.PAP.1813',
        '/build/images/book-covers/pride-and-prejudice.jpg'
    ),
    (
        @AUTHOR_ID_AUSTEN,
        'Emma',
        '1815-12-23 00:00:00',
        '999',
        'JA.E.1815',
        '/build/images/book-covers/emma.jpg'
    ),
    (
        @AUTHOR_ID_DOYLE,
        'A Study in Scarlet',
        '1888-07-01 00:00:00',
        '999',
        'ACD.ASIS.1888',
        '/build/images/book-covers/study-in-scarlet.jpg'
    ),
    (
        @AUTHOR_ID_DOYLE,
        'The Sign of the Four',
        '1890-02-01 00:00:00',
        '999',
        'ACD.TSOTF.1890',
        '/build/images/book-covers/sign-of-the-four.jpg'
    ),
    (
        @AUTHOR_ID_DOYLE,
        'The Hound of the Baskervilles',
        '1920-03-25 00:00:00',
        '999',
        'ACD.THOTB.1920',
        '/build/images/book-covers/hound-of-the-baskervilles.jpg'
    );
COMMIT;

START TRANSACTION;

INSERT INTO `sams_books_database`.`book_category` (`book_id`,`category_id`)
SELECT b.id, c.id
FROM sams_books_database.books AS b, sams_books_database.categories AS c
WHERE b.sku IN ('AD.TTM.1844', 'AD.TCOMC.1844', 'AD.TMITIM.1847')
  AND c.handle IN('adventure', 'swashbuckling', 'historical');


INSERT INTO `sams_books_database`.`book_category` (`book_id`,`category_id`)
SELECT b.id, c.id
FROM sams_books_database.books AS b, sams_books_database.categories AS c
WHERE b.sku IN ('JA.PAP.1813', 'JA.SAS.1811', 'JA.E.1815')
  AND c.handle IN('romance', 'satire');


INSERT INTO `sams_books_database`.`book_category` (`book_id`,`category_id`)
SELECT b.id, c.id
FROM sams_books_database.books AS b, sams_books_database.categories AS c
WHERE b.sku IN ('ACD.ASIS.1888', 'ACD.TSOTF.1890', 'ACD.THOTB.1920')
  AND c.handle IN('adventure', 'mystery');
COMMIT;