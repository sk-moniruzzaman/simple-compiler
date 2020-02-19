%{
	
	#include<bits/stdc++.h>
	using namespace std;
	extern int yylex();
	extern int yyparse();
	extern FILE *yyin;
	int data[600];
	
	void yyerror(string s);

%}

/* bison declarations */

%token NUM VAR IF ELSE MAIN INTEGER FLOAT CHAR START END SWITCH CASE DEFAULT BREAK FOR PRINTLN SIN COS TAN LOG BIGMOD GCD LCM FACT SQRT LOG10

%left '<' '>'
%left '+' '-'
%left '*' '/'
%left '%' '^'

/* Grammar rules and actions follow.  */

%%

program: MAIN ':' START cstatement END
	 ;

cstatement: /* NULL */

	| cstatement statement
	;

statement: ';'			
	| declaration ';'		{  }

	| expression ';' 			{   //$$=$1;
									}
	
	| VAR '=' expression ';' { 
							data[$1] = $3; 
							//$$=$3;
						} 
   
	| FOR '(' NUM ',' NUM ')' START statement END {
	                                int i;
	                                for(i=$3+1 ; i<$5 ; i++) {printf("%d\n");}									
				               }

	
	| IF '(' expression ')' START statement END {
																
								
										}

	| IF '(' expression ')' START statement END ELSE START statement END {
								
							}

	| PRINTLN '(' expression ')' ';' { printf("%d\n",$3); }

	| SW
	;

SW: SWITCH '(' expression ')' START block END { }

block: case block { }
	| default { }

case: CASE  expression  ':' statement BREAK ';' {
										$$ = $3;
								}
default: DEFAULT ':' statement { $$ =$3;
								}	

declaration : TYPE ID1   
             ;


TYPE : INTEGER   
     | FLOAT  
     | CHAR   
     ;



ID1 : ID1 ',' VAR  
    |VAR  
    ;

expression: NUM					{ $$ = $1; 	}

	| VAR						{ $$ = data[$1]; }
	
	| expression '+' expression	{ $$ = $1 + $3; }

	| expression '-' expression	{ $$ = $1 - $3; }

	| expression '*' expression	{ $$ = $1 * $3; }

	| expression '/' expression	{ if($3){
				     					$$ = $1 / $3;
				  					}
				  					else{
										$$ = 0;
										printf("\ndivision by zero\t");
				  					} 	
				    			}
	| expression '%' expression	{ if($3){
				     					$$ = $1 % $3;
				  					}
				  					else{
										$$ = 0;
										printf("\nMOD by zero\t");
				  					} 	
				    			}
	| expression '^' expression	{ $$ = pow($1 , $3);}
	| expression '<' expression	{ $$ = $1 < $3; }
	
	| expression '>' expression	{ $$ = $1 > $3; }

	| '(' expression ')'		{ $$ = $2;	}
	| SIN '(' expression ')'			{ $$= sin($2*3.1416/180);}

    | COS '(' expression ')'			{ $$= cos($2*3.1416/180);}

    | TAN '(' expression ')'			{ $$= tan($2*3.1416/180);}

	| LOG '(' expression ')' 			{ $$= (log($3));}
	| LOG10 '(' expression ')' 			{ $$= (log10($3));}
	| BIGMOD '(' expression ',' expression ',' expression ')' {
			long long res = 1;
			long long x = $3;
			long long p= $5;
			long long m=$7;
			while ( p )
			{
				if (p%2== 1) //p is odd
				{
					res = ( res * x ) % m;
				}
				x = ( x * x ) % m;
				p = p / 2;
			}
			
			$$=res;
		}

	| LCM '(' expression ',' expression ')' { $$ =  ($3*$5)/__gcd($3,$5); }
	
	| GCD '(' expression ',' expression ')' { $$ =__gcd($3,$5); }
	| FACT '(' expression ')' {
								int fact=1;
								for(int i=1;i<=$3;i++)
								{
									fact*=i;
								}
	
								$$ = fact; 
							}
	| SQRT '(' expression ')' {
							int s = sqrt($3);
							$$ = s;}
		
	;
%%


int main()
{
	freopen("input.txt","r",stdin);
	freopen("output.txt","w",stdout);
	yyparse();
    
}

void yyerror(string s){
	printf( "%s\n", s);
}

