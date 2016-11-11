extern int yylineno;
extern char * yytext;
void yyerror(char* s, ...);

struct SyntreeNode{
    int line;
    char* name;
    struct SyntreeNode * leftchild;
    struct SyntreeNode * rightchild;
    union{//
        char* idtype;
        int intgr;
        float flt;
    };
};

//
struct SyntreeNode * newSyntreeNode(char* name, int num, ...);

//generate tree
void generate(struct SyntreeNode *, int level);
