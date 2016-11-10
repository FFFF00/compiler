%{
#include "stdio.h"
#include "stdlib.h"
# include "gramtree_v1.h"
#include "gramtree_v1.tab.h"
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
int|float {yylval.a = newSyntreeNode("TYPE",0,yylineno);return TYPE;}
struct {yylval.a = newSyntreeNode("STRUCT",0,yylineno);return STRUCT;}
{RETURN} {yylval.a = newSyntreeNode("RETURN",0,yylineno); return RETURN;}
{IF} { yylval.a = newSyntreeNode("IF",0,yylineno);return IF;}
{ELSE} {yylval.a = newSyntreeNode("ELSE",0,yylineno); return ELSE;}
{WHILE} {yylval.a = newSyntreeNode("WHILE",0,yylineno); return WHILE;}
{PLUS} {yylval.a = newSyntreeNode("PLUS",0,yylineno); return PLUS;}
{MINUS} {yylval.a = newSyntreeNode("MINUS",0,yylineno); return MINUS;}
{INTEGER} {yylval.a = newSyntreeNode("INTEGER",0,yylineno); return INTEGER;}
{ID} {yylval.a = newSyntreeNode("ID",0,yylineno); return ID;}
{SPACE} {}
{EOL} {}
{SEMI} {yylval.a = newSyntreeNode("SEMI",0,yylineno); return SEMI;}
{COMMA} {yylval.a = newSyntreeNode("COMMA",0,yylineno); return COMMA;}
{ASSIGNOP} {yylval.a = newSyntreeNode("ASSIGNOP",0,yylineno); return ASSIGNOP;}
{RELOP} {yylval.a = newSyntreeNode("RELOP",0,yylineno); return RELOP;}
{STAR} {yylval.a = newSyntreeNode("STAR",0,yylineno); return STAR;}
{DIV} {yylval.a = newSyntreeNode("DIV",0,yylineno); return DIV;}
{AND} {yylval.a = newSyntreeNode("AND",0,yylineno); return AND;}
{OR} {yylval.a = newSyntreeNode("OR",0,yylineno); return OR;}
{DOT} {yylval.a = newSyntreeNode("DOT",0,yylineno); return DOT;}
{NOT} {yylval.a = newSyntreeNode("NOT",0,yylineno); return NOT;}
{LP} {yylval.a = newSyntreeNode("LP",0,yylineno); return LP;}
{RP} {yylval.a = newSyntreeNode("RP",0,yylineno); return RP;}
{LB} {yylval.a = newSyntreeNode("LB",0,yylineno); return LB;}
{RB} {yylval.a = newSyntreeNode("RB",0,yylineno); return RB;}
{LC} {yylval.a = newSyntreeNode("LC",0,yylineno); return LC;}
{RC} {yylval.a = newSyntreeNode("RC",0,yylineno); return RC;}
{AERROR} { printf("Error type A at line %d: Mystirious charachter '%s'\n",yylineno,yytext);}

%%
int yywrap()
{
        return 1;
}
