%option noyywrap yylineno caseless

%{
#include "parser.tab.h"
#include <stdlib.h>
%}

DIGIT       [0-9]
LETTER      [a-zA-Z_]
IDENT       {LETTER}({LETTER}|{DIGIT})*
NUMBERVAL   {DIGIT}+(\.{DIGIT}+)?
STRINGVAL   \'([^\'\n]|\\.)*\'

%%

[ \t\r]+                  ;
\n                        ;
"--"[^\n]*                ;

"SELECT"                  { return SELECT; }
"INSERT"                  { return INSERT; }
"INTO"                    { return INTO; }
"VALUES"                  { return VALUES; }
"UPDATE"                  { return UPDATE; }
"SET"                     { return SET; }
"DELETE"                  { return DELETE; }
"FROM"                    { return FROM; }
"WHERE"                   { return WHERE; }
"CREATE"                  { return CREATE; }
"TABLE"                   { return TABLE; }
"ORDER"                   { return ORDER; }
"BY"                      { return BY; }
"ASC"                     { return ASC; }
"DESC"                    { return DESC; }
"AND"                     { return AND; }
"OR"                      { return OR; }
"INT"                     { return INT_TYPE; }
"INTEGER"                 { return INTEGER_TYPE; }
"VARCHAR"                 { return VARCHAR_TYPE; }
"CHAR"                    { return CHAR_TYPE; }
"TEXT"                    { return TEXT_TYPE; }

"<="                      { return LE; }
">="                      { return GE; }
"<>"|"!="                 { return NE; }
"="                       { return EQ; }
"<"                       { return LT; }
">"                       { return GT; }
","                       { return COMMA; }
";"                       { return SEMICOLON; }
"("                       { return LPAREN; }
")"                       { return RPAREN; }
"*"                       { return STAR; }

{NUMBERVAL}               { return NUMBER; }
{STRINGVAL}               { return STRING; }
{IDENT}                   { return IDENTIFIER; }

.                         { return INVALID; }

%%
