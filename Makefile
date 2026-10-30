BISON ?= bison
FLEX ?= flex
CC ?= clang
CFLAGS ?= -Wall -Wextra

all: sql_parser

parser.tab.c parser.tab.h: parser.y
	$(BISON) -d -o parser.tab.c parser.y

lex.yy.c: lexer.l parser.tab.h
	$(FLEX) -o lex.yy.c lexer.l

sql_parser: parser.tab.c lex.yy.c
	$(CC) $(CFLAGS) -o sql_parser parser.tab.c lex.yy.c

clean:
	rm -f sql_parser parser.tab.c parser.tab.h lex.yy.c

.PHONY: all clean
