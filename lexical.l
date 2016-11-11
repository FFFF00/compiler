%{
#include "stdio.h"
#include "stdlib.h"
# include "syntax_tree.h"
#include "syntax.tab.h"
%}
%option yylineno
TYPE int|float
STRUCT struct
RETURN return
IF if
ELSE else
WHILE while
PLUS \+
MINUS -
INTEGER [1-9]+[0-9]*|0 
FLOAT   [0-9]+\.[0-9]*  
ID [a-z_A-Z][a-zA-Z_0-9]*
SPACE [ \t\r]*
EOL \n
SEMI ;
COMMA ,
ASSIGNOP =
RELOP >|<|>=|<=|==|!=
STAR \*
DIV \/
AND &&
OR \|\|
DOT \.
NOT !
LP \(
RP \)
LB \[
RB \]
LC \{
RC \}
AERROR .
%%
int|float {yylval.node = newSyntreeNode("TYPE",0,yylineno);return TYPE;}
struct {yylval.node = newSyntreeNode("STRUCT",0,yylineno);return STRUCT;}
{RETURN} {yylval.node = newSyntreeNode("RETURN",0,yylineno); return RETURN;}
{IF} { yylval.node = newSyntreeNode("IF",0,yylineno);return IF;}
{ELSE} {yylval.node = newSyntreeNode("ELSE",0,yylineno); return ELSE;}
{WHILE} {yylval.node = newSyntreeNode("WHILE",0,yylineno); return WHILE;}
{PLUS} {yylval.node = newSyntreeNode("PLUS",0,yylineno); return PLUS;}
{MINUS} {yylval.node = newSyntreeNode("MINUS",0,yylineno); return MINUS;}
{INTEGER} {yylval.node = newSyntreeNode("INTEGER",0,yylineno); return INTEGER;}
{ID} {yylval.node = newSyntreeNode("ID",0,yylineno); return ID;}
{SPACE} {}
{EOL} {}
{SEMI} {yylval.node = newSyntreeNode("SEMI",0,yylineno); return SEMI;}
{COMMA} {yylval.node = newSyntreeNode("COMMA",0,yylineno); return COMMA;}
{ASSIGNOP} {yylval.node = newSyntreeNode("ASSIGNOP",0,yylineno); return ASSIGNOP;}
{RELOP} {yylval.node = newSyntreeNode("RELOP",0,yylineno); return RELOP;}
{STAR} {yylval.node = newSyntreeNode("STAR",0,yylineno); return STAR;}
{DIV} {yylval.node = newSyntreeNode("DIV",0,yylineno); return DIV;}
{AND} {yylval.node = newSyntreeNode("AND",0,yylineno); return AND;}
{OR} {yylval.node = newSyntreeNode("OR",0,yylineno); return OR;}
{DOT} {yylval.node = newSyntreeNode("DOT",0,yylineno); return DOT;}
{NOT} {yylval.node = newSyntreeNode("NOT",0,yylineno); return NOT;}
{LP} {yylval.node = newSyntreeNode("LP",0,yylineno); return LP;}
{RP} {yylval.node = newSyntreeNode("RP",0,yylineno); return RP;}
{LB} {yylval.node = newSyntreeNode("LB",0,yylineno); return LB;}
{RB} {yylval.node = newSyntreeNode("RB",0,yylineno); return RB;}
{LC} {yylval.node = newSyntreeNode("LC",0,yylineno); return LC;}
{RC} {yylval.node = newSyntreeNode("RC",0,yylineno); return RC;}
{AERROR} { printf("Error type A at line %d: Mystirious charachter '%s'\n",yylineno,yytext);}

%%
int yywrap()
{
        return 1;
}
