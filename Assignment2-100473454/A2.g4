grammar A2;

@header {

}

@members {
	String firstName = "Nicholas";
	String lastName = "De Souza";
	String studentNum = "100473454";
	int uniqueLoops = 0;
}

/* 
		start --> my_program statements+ 
*/
start 
	: {System.out.print("/**\n * " + firstName + " " + lastName + "\n * " + studentNum + "\n */\npublic class ");}
		my_program {System.out.print($my_program.s);}
		{System.out.println(" {\n\n\tpublic static void main(String[] args){\n");}
		( statement {System.out.println("\t\t" + $statement.s + "\n");})+
		{System.out.println("\t}\n\n}");}
	;	

/*
		my_program --> 'my program' ID '/'
*/
my_program returns [String s]
	: 'my program' ID '/'
		{ 
			$s = $ID.getText();	
		}
	;

/*
		statement --> num_decl | str_decl | var_assign | loop | show | check
*/
statement returns [String s]
    : num_decl { $s = $num_decl.s; }
    | str_decl { $s = $str_decl.s; }
    | var_assign { $s = $var_assign.s; }
    | show  { $s = $show.s; }
    | loop  { $s = $loop.s; }
    | check { $s = $check.s; }
    ;

/*
		loop --> 'loop' var '{' statement+ '}'
*/
loop returns [String s]
    :
        {
            String body = "";
            uniqueLoops++;
            String bodyIndent = String.format("%0" + (uniqueLoops+2) + "d", 0).replace("0","\t");
            String bracketIndent = String.format("%0" + (uniqueLoops+1) + "d", 0).replace("0","\t");
        }
        'loop' x=var '{' (statement { body += "\n" + bodyIndent + $statement.s + "\n"; })+ '}'
        {
            $s = "for(int i" + uniqueLoops + "= 0; i" + uniqueLoops + " < " + $x.s + "; i" + uniqueLoops + "++) {" +
                  "\n" + body + "\n"
                  + bracketIndent + "}";
        }
        {
            uniqueLoops--;
        }
    ;

/*
		check --> check condition '{' statement+ '}'
*/
check returns [String s]
    :
        {
            String body = "";
            String condition = "";
            String bodyIndent = String.format("%0" + (uniqueLoops+3) + "d", 0).replace("0","\t");
            String bracketIndent = String.format("%0" + (uniqueLoops+2) + "d", 0).replace("0","\t");
        }
        'check' (condition { condition += $condition.s; }) '{'
            (statement { body += "\n" + bodyIndent + $statement.s + "\n"; })+
        '}'
        {
            $s = "if (" + condition + ") {" +
                  "\n" + body + "\n"
                  + bracketIndent + "}";
        }
    ;

/*
		condition --> var OP var
*/
condition returns [String s]
    : a=var OP b=var
        {
            $s = $a.s + " " + $OP.getText() + " " + $b.s;
        }
    ;

/*
		num_decl --> 'num' ID '/'
*/
num_decl returns [String s]
	: 'num' ID '/'
		{
			$s = "int "+$ID.getText()+";";
		}
	;

/*
		str_decl --> 'str' ID '/'
*/
str_decl returns [String s]
    : 'str' ID '/'
        {
            $s = "String "+$ID.getText()+";";
        }
    ;

/*
		var_assign --> 'assign' ID var '/'
*/
var_assign returns [String s]
    : 'assign' name=ID var '/'
        {
            $s = $name.getText() + " = " + $var.s + ";";
        }
    ;

/*
		show --> 'show' var '/'
*/
show returns [String s]
    : 'show' x=var '/'
        {
            $s = "System.out.println(" + $x.s + ");";
        }
    ;

/*
		var --> ID | NUM | STR
*/
var returns [String s]
	: ID 
		{ 
			$s = $ID.getText(); 
		}
	| NUM 
		{ 
			$s = ""+ $NUM.getText(); 
		}
	| STR
		{
			$s = $STR.getText();
		}
	;

/* Terminal Symbols */
NUM : ('0' .. '9')+ ;
OP : ('>' | '<' | '==' | '<=' | '>=' | '!=') ;
ID : ('a' .. 'z' | 'A' .. 'Z')+ ('a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' | '-')* ;
STR : '"'('a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' | '-' | ' ')*'"' ;
WS : (' ' | '\t' | '\r' | '\n') {skip();} ;

