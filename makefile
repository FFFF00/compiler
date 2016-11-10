#!/bin/sh

bison -d syntax.y
flex lexical.l
gcc syntax.tab.c lex.yy.c syntax.c 
