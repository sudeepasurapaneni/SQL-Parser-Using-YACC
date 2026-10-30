-- Valid examples
SELECT name, age FROM students WHERE age > 18;
SELECT * FROM students ORDER BY name ASC;
INSERT INTO students VALUES (1, 'Ravi');
UPDATE students SET age = 20 WHERE id = 1;
DELETE FROM students WHERE id = 1;
CREATE TABLE students (id INT, name VARCHAR(50), age INTEGER);

-- Invalid examples
SELECT FROM WHERE;
INSERT students VALUES (1, 'Ravi');
UPDATE students SET WHERE id = 1;
