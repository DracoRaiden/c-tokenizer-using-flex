---This is a read me file on how to work this out.---

First, copy the code for FlexLexer.h, lexer.flex and input.cpp i the same folder. Also, create an empty Output.txt file.


Run these commands one by one:

win_flex -o lex.yy.c lexer.flex

g++ lex.yy.c -o lexer.exe

.\lexer.exe input.cpp

.\lexer.exe input.cpp > output.txt

Get-Content output.txt
