%{
#include<unistd.h>
#include<stdio.h>   
#include "syntax_tree.h"
%}

%union{
struct SyntreeNode* node;
double d;
}
/*declare tokens*/
%token  <node> INTEGER FLOAT
%token <node> TYPE STRUCT RETURN IF ELSE WHILE ID SPACE SEMI COMMA ASSIGNOP RELOP PLUS
MINUS STAR DIV AND OR DOT NOT LP RP LB RB LC RC AERROR
%token <node> EOL
%type  <node> Program ExtDefList ExtDef ExtDecList Specifire StructSpecifire 
OptTag  Tag VarDec  FunDec VarList ParamDec Compst StmtList Stmt DefList Def DecList Dec Exp Args

/*priority*/
%right ASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left STAR DIV
%right NOT 
%left LP RP LB RB DOT
%%
Program:|ExtDefList {$$ = newSyntreeNode("Program",1,$1);printf("printf syntax tree:\n");generate($$,0);printf("syntax tree over\n\n");}
    ;
ExtDefList:ExtDef ExtDefList {$$ = newSyntreeNode("ExtDefList",2,$1,$2);}
	| {$$ = newSyntreeNode("ExtDefList",0,-1);}
	;
ExtDef:Specifire ExtDecList SEMI    {$$ = newSyntreeNode("ExtDef",3,$1,$2,$3);}    
	|Specifire SEMI	{$$ = newSyntreeNode("ExtDef",2,$1,$2);}
	|Specifire FunDec Compst	{$$ = newSyntreeNode("ExtDef",3,$1,$2,$3);}
	;
ExtDecList:VarDec {$$ = newSyntreeNode("ExtDecList",1,$1);}
	|VarDec COMMA ExtDecList {$$ = newSyntreeNode("ExtDecList",3,$1,$2,$3);}
	;
/*Specifire*/
Specifire:TYPE {$$ = newSyntreeNode("Specifire",1,$1);}
	|StructSpecifire {$$ = newSyntreeNode("Specifire",1,$1);}
	;
StructSpecifire:STRUCT OptTag LC DefList RC {$$ = newSyntreeNode("StructSpecifire",5,$1,$2,$3,$4,$5);}
	|STRUCT Tag {$$ = newSyntreeNode("StructSpecifire",2,$1,$2);}
	;
OptTag:ID {$$ = newSyntreeNode("OptTag",1,$1);}
	|{$$ = newSyntreeNode("OptTag",0,-1);}
	;
Tag:ID {$$ = newSyntreeNode("Tag",1,$1);}
	;
/*Declarators*/
VarDec:ID {$$ = newSyntreeNode("VarDec",1,$1);}
	| VarDec LB INTEGER RB {$$ = newSyntreeNode("VarDec",4,$1,$2,$3,$4);}
	;
FunDec:ID LP VarList RP {$$ = newSyntreeNode("FunDec",4,$1,$2,$3,$4);}
	|ID LP RP {$$ = newSyntreeNode("FunDec",3,$1,$2,$3);}
	;
VarList:ParamDec COMMA VarList {$$ = newSyntreeNode("VarList",3,$1,$2,$3);}
	|ParamDec {$$ = newSyntreeNode("VarList",1,$1);}
	;
ParamDec:Specifire VarDec {$$ = newSyntreeNode("ParamDec",2,$1,$2);}
    ;

/*Statement*/
Compst:LC DefList StmtList RC {$$ = newSyntreeNode("Compst",4,$1,$2,$3,$4);}
	;
StmtList:Stmt StmtList{$$ = newSyntreeNode("StmtList",2,$1,$2);}
	| {$$ = newSyntreeNode("StmtList",0,-1);}
	;
Stmt:Exp SEMI {$$ = newSyntreeNode("Stmt",2,$1,$2);}
	|Compst {$$ = newSyntreeNode("Stmt",1,$1);}
	|RETURN Exp SEMI {$$ = newSyntreeNode("Stmt",3,$1,$2,$3);}
	|IF LP Exp RP Stmt {$$ = newSyntreeNode("Stmt",5,$1,$2,$3,$4,$5);}
	|IF LP Exp RP Stmt ELSE Stmt {$$ = newSyntreeNode("Stmt",7,$1,$2,$3,$4,$5,$6,$7);}
	|WHILE LP Exp RP Stmt {$$ = newSyntreeNode("Stmt",5,$1,$2,$3,$4,$5);}
	;
/*Local Definitions*/
DefList:Def DefList{$$ = newSyntreeNode("DefList",2,$1,$2);}
	| {$$ = newSyntreeNode("DefList",0,-1);}
	;
Def:Specifire DecList SEMI {$$ = newSyntreeNode("Def",3,$1,$2,$3);}
	;
DecList:Dec {$$ = newSyntreeNode("DecList",1,$1);}
	|Dec COMMA DecList {$$ = newSyntreeNode("DecList",3,$1,$2,$3);}
	;
Dec:VarDec {$$ = newSyntreeNode("Dec",1,$1);}
	|VarDec ASSIGNOP Exp {$$ = newSyntreeNode("Dec",3,$1,$2,$3);}
	;
/*Expressions*/
Exp:Exp ASSIGNOP Exp{$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |Exp AND Exp{$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |Exp OR Exp{$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |Exp RELOP Exp{$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |Exp PLUS Exp{$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |Exp MINUS Exp{$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |Exp STAR Exp{$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |Exp DIV Exp{$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |LP Exp RP{$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |MINUS Exp {$$ = newSyntreeNode("Exp",2,$1,$2);}
        |NOT Exp {$$ = newSyntreeNode("Exp",2,$1,$2);}
        |ID LP Args RP {$$ = newSyntreeNode("Exp",4,$1,$2,$3,$4);}
        |ID LP RP {$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |Exp LB Exp RB {$$ = newSyntreeNode("Exp",4,$1,$2,$3,$4);}
        |Exp DOT ID {$$ = newSyntreeNode("Exp",3,$1,$2,$3);}
        |ID {$$ = newSyntreeNode("Exp",1,$1);}
        |INTEGER {$$ = newSyntreeNode("Exp",1,$1);}
        |FLOAT{$$ = newSyntreeNode("Exp",1,$1);}
        ;
Args:Exp COMMA Args {$$ = newSyntreeNode("Args",3,$1,$2,$3);}
        |Exp {$$ = newSyntreeNode("Args",1,$1);}
        ;
%%
