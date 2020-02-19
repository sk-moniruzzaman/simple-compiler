bison -d compiler.y
flex compiler.l
g++ lex.yy.c compiler.tab.c -o app
./app