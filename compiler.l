%{
	#include<bits/stdc++.h>
	using namespace std;
	#include "compiler.tab.h"

%}

alpha [a-zA-Z]
digit [0-9]
header					"import"[ ]*+[^\n]+[.h][ ]*
keyWord					IF|ELSE|FOR|RETURN|INTEGER|FLOAT|CHAR|SWITCH|CASE|BREAK|DEFAULT|PRINTLN|GCD|LCM|FACT|SQRT|LOG10
singleLineComment		[ ]*[#][#][a-zA-Z0-9@$%^&*(){}_+-,.:\|?>< ]*
multipleLineComment		[ ]*[!][!][a-zA-Z0-9@$*(){}_+-,.:\|?><\n\t ]*[!][!]	

%%

{digit}+	{ yylval = atoi(yytext); return NUM; }
{alpha}	    { yylval = *yytext - 'a'; return	VAR; }

SWITCH 		   { return SWITCH; }
PRINTLN 	   { return PRINTLN; }
CASE   		   { return CASE;  } 
IF 			   { return IF;   }
ELSE 		   { return ELSE; }
BREAK  		   { return BREAK;  }
DEFAULT 	   { return DEFAULT; }
"{" 		   { return START;  }
"}"  		   { return END;	}
FOR 		   { return FOR;}
SIN			   { return SIN;}
COS            { return COS;}
TAN            { return TAN;}
LOG			   { return LOG;}
LOG10		   { return LOG10;}
BIGMOD  	   { return BIGMOD;}
LCM 		   { return LCM ; }
GCD 		   { return GCD ; }
FACT           { return FACT; }
SQRT		   { return SQRT; }

{singleLineComment}		{}
{multipleLineComment}	{}
{header}  				{}
[-+/*<>=,():;%^]     {yylval = yytext[0];	return *yytext;	}
INTEGER  			 {return INTEGER;}
CHAR 		         {return CHAR;}
FLOAT 			 	{return FLOAT;}
"main"	   { return MAIN; }
[ ]*	    			{}
[\n]*					{}
[\t]*					{}
.						{printf("%s --> Invalid Input\n",yytext);}


%%

int yywrap()
{
	return 1;
}
