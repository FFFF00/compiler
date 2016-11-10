# include<stdio.h>
# include<stdlib.h>
# include<stdarg.h>

# include"syntax_tree.h"

int i;

struct SyntreeNode * newSyntreeNode(char* name, int num, ...){
    va_list valist; 
    struct SyntreeNode * node = (struct SyntreeNode * )malloc( sizeof(struct SyntreeNode));
    struct SyntreeNode * temp = (struct SyntreeNode * )malloc( sizeof(struct SyntreeNode));
    
    node->name = name;
    va_start(valist, num);

    if(num >= 1){//¿¿¿
        temp = va_arg(valist, struct SyntreeNode *);
        node->leftchild = temp;
        node->line = temp->line;

	int i;
        if(num >= 2){//¿¿¿¿¿¿
            for(i = 0; i < num-1; i++){
                temp->rightchild = va_arg(valist, struct SyntreeNode *);
                temp = temp->rightchild;
            }
        }
    }else {//¿¿¿¿
        int t = va_arg(valist, int); 
        node->line = t;
        if((!strcmp(node->name, "ID" ))||(!strcmp(node->name, "TYPE" ))){//¿¿¿¿¿¿ID,TYPE,INTEGER
            char * t; t = (char *)malloc(sizeof(char* ) * 40);
	    strcpy(t, yytext);
	    node->idtype = t;
    	}
        else if(!strcmp(node->name, "INTEGER")) {//¿¿¿¿¿¿¿¿¿¿
	    node->intgr = atoi(yytext);
	}
    }
    return node;
}

void generate(struct SyntreeNode * node,int level){
    if(node != NULL){
        for( i = 0; i < level; i++)
            printf("  ");
        if( node->line != -1){ 
            printf("%s ", node->name);
            if((!strcmp(node->name,"ID"))||(!strcmp(node->name,"TYPE")))printf(":%s ",node->idtype);
            else if(!strcmp(node->name,"INTEGER"))printf(":%d",node->intgr);
            else
                printf("(%d)", node->line);
        }
        printf("\n");

        generate(node->leftchild, level + 1);//¿¿¿
        generate(node->rightchild, level);//¿¿¿
    }
}

int main(){
    printf(">");
    return yyparse(); 
}
