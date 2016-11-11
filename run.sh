#!/bin/sh

echo "bison...";
bison -d syntax.y;
echo "flex...";
flex lexical.l;
echo "gcc...";
gcc syntax.tab.c lex.yy.c syntax_tree.c;
echo "result:\n";
cat $1 | ./a.out;
