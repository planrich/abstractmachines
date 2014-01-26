
%{
#include <stdio.h>
#include "lexer.h"
// yylex() is generated by flex
int yylex(void);
// we have to define yyerror()
void yyerror (YYLTYPE *locp, char const *msg);
%}

%locations 
%define api.pure full

%union {
    char * text;
    int ws;
}

%token TOK_UNIT
%token TOK_FUNC
%token TOK_VERSION
%token TOK_EOF

%token<text> TOK_ID
%token TOK_INT
%token<ws> TOK_WS
%token TOK_NL

%token TOK_COLON
%token TOK_EQUAL
%token TOK_SEMI_COLON

%left '+' '-'
%left '*' '/'
%right '('

%start file

%%

file: skip meta skip statements skip TOK_EOF
    ;

meta: TOK_UNIT ws TOK_ID ws TOK_VERSION ws TOK_INT { 
        printf("ok %s\n", $3);
      }
    ;

statements: TOK_FUNC ws TOK_ID ows TOK_COLON skip patterns {
                printf("ok2 \n");
            }
          ;

patterns: TOK_EQUAL ows TOK_SEMI_COLON skip expr skip patterns {
          }
        |
        ;


expr: TOK_INT
    ;

ows: TOK_WS
   | 
   ;

ws: TOK_WS;
nl: TOK_NL;
skip: TOK_WS skip
    | TOK_NL skip
    |
    ;

%%

