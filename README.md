# SQL Parser Using Yacc/Bison

A small course project that recognizes a practical subset of SQL using Flex (Lex), Bison (Yacc), and C.

## Supported statements

- `SELECT` with `*` or comma-separated column names
- Optional `WHERE` conditions using comparisons and `AND` / `OR`
- Optional `ORDER BY` with `ASC` or `DESC`
- `INSERT INTO ... VALUES (...)`
- `UPDATE ... SET ...` with optional `WHERE`
- `DELETE FROM ...` with optional `WHERE`
- `CREATE TABLE` with basic column types: `INT`, `INTEGER`, `TEXT`, `VARCHAR(n)`, `CHAR(n)`
- Syntax error reporting and recovery at semicolons

This is a syntax checker for a defined SQL subset. It does not connect to or execute queries on a database.

## macOS setup

If Homebrew is already installed, install the tools:

```bash
brew install flex bison
```

Homebrew's Bison/Flex may not be on the default PATH. For the current Terminal session, run:

```bash
export PATH="$(brew --prefix bison)/bin:$(brew --prefix flex)/bin:$PATH"
```

Check the tools:

```bash
bison --version
flex --version
clang --version
```

If you do not have Homebrew, see its official installation instructions: https://brew.sh/

## Compile

Run these commands from the folder containing `parser.y` and `lexer.l`:

```bash
bison -d -o parser.tab.c parser.y
flex -o lex.yy.c lexer.l
clang -o sql_parser parser.tab.c lex.yy.c
```

If the compiler reports a warning about `fileno`, it is usually not fatal. If the final executable `sql_parser` is created, continue to run it.

## Run interactively

```bash
./sql_parser
```

Type one or more SQL statements, each ending in a semicolon. To finish input on Mac, press **Control+D** on a new line.

## Run the sample file

```bash
./sql_parser < input.sql
```

## Demo queries

Valid:

```sql
SELECT name, age FROM students WHERE age > 18;
INSERT INTO students VALUES (1, 'Ravi');
UPDATE students SET age = 20 WHERE id = 1;
DELETE FROM students WHERE id = 1;
CREATE TABLE students (id INT, name VARCHAR(50));
```

Invalid:

```sql
SELECT FROM WHERE;
INSERT students VALUES (1, 'Ravi');
UPDATE students SET WHERE id = 1;
```

## Important limitation

The grammar recognizes only the SQL features listed above. It is not a complete implementation of the SQL standard and does not validate whether tables or columns exist in a database.
