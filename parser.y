%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *message);
extern int yylineno;
%}

%define parse.error verbose

%token SELECT INSERT INTO VALUES UPDATE SET DELETE FROM WHERE CREATE TABLE
%token ORDER BY ASC DESC AND OR
%token INT_TYPE INTEGER_TYPE VARCHAR_TYPE CHAR_TYPE TEXT_TYPE
%token IDENTIFIER NUMBER STRING
%token EQ NE LT GT LE GE
%token COMMA SEMICOLON LPAREN RPAREN STAR
%token INVALID

%left OR
%left AND
%nonassoc EQ NE LT GT LE GE

%start input

%%

input
    : /* empty */
    | input statement
    ;

statement
    : select_stmt SEMICOLON
        { printf("Valid SQL SELECT statement.\n\n"); }
    | insert_stmt SEMICOLON
        { printf("Valid SQL INSERT statement.\n\n"); }
    | update_stmt SEMICOLON
        { printf("Valid SQL UPDATE statement.\n\n"); }
    | delete_stmt SEMICOLON
        { printf("Valid SQL DELETE statement.\n\n"); }
    | create_stmt SEMICOLON
        { printf("Valid SQL CREATE TABLE statement.\n\n"); }
    | error SEMICOLON
        { printf("Rejected: invalid SQL statement.\n\n"); yyerrok; }
    ;

select_stmt
    : SELECT select_list FROM IDENTIFIER optional_where optional_order
    ;

select_list
    : STAR
    | identifier_list
    ;

identifier_list
    : IDENTIFIER
    | identifier_list COMMA IDENTIFIER
    ;

optional_where
    : /* empty */
    | WHERE condition
    ;

condition
    : predicate
    | condition AND condition
    | condition OR condition
    | LPAREN condition RPAREN
    ;

predicate
    : value comparison value
    ;

comparison
    : EQ | NE | LT | GT | LE | GE
    ;

value
    : IDENTIFIER
    | NUMBER
    | STRING
    ;

optional_order
    : /* empty */
    | ORDER BY IDENTIFIER optional_direction
    ;

optional_direction
    : /* empty */
    | ASC
    | DESC
    ;

insert_stmt
    : INSERT INTO IDENTIFIER VALUES LPAREN value_list RPAREN
    ;

value_list
    : value
    | value_list COMMA value
    ;

update_stmt
    : UPDATE IDENTIFIER SET assignment_list optional_where
    ;

assignment_list
    : assignment
    | assignment_list COMMA assignment
    ;

assignment
    : IDENTIFIER EQ value
    ;

delete_stmt
    : DELETE FROM IDENTIFIER optional_where
    ;

create_stmt
    : CREATE TABLE IDENTIFIER LPAREN column_def_list RPAREN
    ;

column_def_list
    : column_def
    | column_def_list COMMA column_def
    ;

column_def
    : IDENTIFIER data_type
    ;

data_type
    : INT_TYPE
    | INTEGER_TYPE
    | TEXT_TYPE
    | VARCHAR_TYPE LPAREN NUMBER RPAREN
    | CHAR_TYPE LPAREN NUMBER RPAREN
    ;

%%

void yyerror(const char *message)
{
    fprintf(stderr, "Syntax error near line %d: %s\n", yylineno, message);
}

int main(void)
{
    printf("========================================\n");
    printf("       SQL PARSER USING YACC/BISON\n");
    printf("========================================\n");
    printf("Enter SQL statements ending with semicolons.\n");
    printf("Example: SELECT name FROM students;\n");
    printf("Press Ctrl+D (Mac/Linux) when finished.\n\n");

    yyparse();
    return 0;
}
