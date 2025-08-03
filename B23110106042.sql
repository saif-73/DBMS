-- Creating table:
CREATE TABLE book(
	book_id SERIAL PRIMARY KEY,
	title VARCHAR(100),
	author VARCHAR(100),
	year_published INTEGER,
	isAvailable BOOLEAN,
	price NUMERIC(10,2),
	publication_name VARCHAR(100)
);

-- Inserting data of 15 books:
INSERT INTO book (title, author, year_published, isAvailable, price, publication_name) VALUES
('The Catcher in the Rye', 'J.D. Salinger', 1951, TRUE, 399.99, 'Penguin Books'),
('To Kill a Mockingbird', 'Harper Lee', 1960, TRUE, 499.50, 'HarperCollins'),
('1984', 'George Orwell', 1949, FALSE, 350.75, 'Penguin Books'),
('Pride and Prejudice', 'Jane Austen', 1813, TRUE, 299.00, 'Doubleday'),
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, TRUE, 279.95, 'Doubleday'),
('Moby Dick', 'Herman Melville', 1851, FALSE, 320.00, 'HarperCollins'),
('War and Peace', 'Leo Tolstoy', 1869, TRUE, 699.99, 'Penguin Books'),
('The Hobbit', 'J.R.R. Tolkien', 1937, TRUE, 450.00, 'Bloomsbury'),
('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 1997, TRUE, 999.99, 'Bloomsbury'),
('The Da Vinci Code', 'Dan Brown', 2003, TRUE, 550.49, 'Doubleday'),
('The Alchemist', 'Paulo Coelho', 1988, FALSE, 425.75, 'HarperCollins'),
('Brave New World', 'Aldous Huxley', 1932, TRUE, 360.00, 'Penguin Books'),
('The Book Thief', 'Markus Zusak', 2005, TRUE, 620.40, 'HarperCollins'),
('Animal Farm', 'George Orwell', 1945, TRUE, 290.20, 'Penguin Books'),
('Angels & Demons', 'Dan Brown', 2000, TRUE, 510.00, 'Doubleday');

-- Select all books published after 2000
SELECT * FROM book WHERE year_published > 2000;

-- Select books with a price less than 599.00, ordered by price in descending order
SELECT * FROM book WHERE price < 599.00 ORDER BY price DESC;

-- Select the top 3 most expensive books
SELECT * FROM book ORDER BY price DESC LIMIT 3;

-- Select 2 books, skipping the first 2, ordered by publication_year in descending order
SELECT * FROM book ORDER BY price DESC OFFSET 2 LIMIT 2;

-- Select all books of the publication “XYZ” ordered alphabetically by title
SELECT * FROM book WHERE publication_name = 'Doubleday' ORDER BY title ASC;

