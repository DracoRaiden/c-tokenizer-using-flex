%{
#include <stdio.h>
#include <stdlib.h>
int line_no = 1;
extern FILE *yyin;
%}

digit               [0-9]
letter              [A-Za-z_]
identifier          {letter}({letter}|{digit})*
data_type           int|float|double|char|bool|string|long|short|void
accessspecifier     private|protected|public
keyword             if|else|while|for|return|break|continue|switch|case|default|sizeof|do|goto|enum|typedef|struct|class|const|static|volatile|signed|unsigned|try|catch|throw|new|delete
brackets            [\{\}\[\]\(\)]
line_comment        \/\/[^\n]*
block_comment       "\/\*([^*]|\*+[^*/])*\*+\/"
integer_constant    {digit}+
float_constant      {digit}+"."{digit}+
character_constant  \'([^\\']|\\.)\'
string_literal      \"([^\\\"]|\\.)*\"
library             \#include[ \t]*<[^>]+>
delimiter           [;,]
assignment_operator =
arithmetic_operator [+\-*/%]
relational_operator (==|!=|<=|>=|<|>)
logical_operator    (\|\||&&|!)
bitwise_operator    (&|\||\^|~|<<|>>)
increment_decrement (\+\+|--)

%option noyywrap

%%

{library}               { printf("Line %d: Library Include = %s\n", line_no, yytext); }

{line_comment}          { printf("Line %d: Line Comment = %s\n", line_no, yytext); }

{block_comment}         { printf("Line %d: Block Comment = %s\n", line_no, yytext); }

{accessspecifier}       { printf("Line %d: Access Specifier = %s\n", line_no, yytext); }

{data_type}             { printf("Line %d: Data Type = %s\n", line_no, yytext); }

{keyword}               { printf("Line %d: Keyword = %s\n", line_no, yytext); }

{brackets}              { printf("Line %d: Bracket/Parenthesis = %s\n", line_no, yytext); }

{delimiter}             { printf("Line %d: Delimiter = %s\n", line_no, yytext); }

{assignment_operator}   { printf("Line %d: Assignment Operator = %s\n", line_no, yytext); }

{increment_decrement}   { printf("Line %d: Increment/Decrement Operator = %s\n", line_no, yytext); }

{arithmetic_operator}   { printf("Line %d: Arithmetic Operator = %s\n", line_no, yytext); }

{relational_operator}   { printf("Line %d: Relational Operator = %s\n", line_no, yytext); }

{logical_operator}      { printf("Line %d: Logical Operator = %s\n", line_no, yytext); }

{bitwise_operator}      { printf("Line %d: Bitwise Operator = %s\n", line_no, yytext); }

{integer_constant}      { printf("Line %d: Integer Constant = %s\n", line_no, yytext); }

{float_constant}        { printf("Line %d: Float Constant = %s\n", line_no, yytext); }

{character_constant}    { printf("Line %d: Character Constant = %s\n", line_no, yytext); }

{string_literal}        { printf("Line %d: String Literal = %s\n", line_no, yytext); }

{identifier}            { printf("Line %d: Identifier = %s\n", line_no, yytext); }

\n                      { line_no++; }

[ \t\r]+                ;   // Ignore whitespace

.                       { printf("Line %d: Unknown Token = %s\n", line_no, yytext); }

%%


int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <source-file>\n", argv[0]);
        return EXIT_FAILURE;
    }
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("fopen");
        return EXIT_FAILURE;
    }
    yylex();
    fclose(yyin);
    return EXIT_SUCCESS;
}
