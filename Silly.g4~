grammar A2;

@header {
import java.util.TreeMap;
}

@members {
	
}

start 
	: {System.out.println("public class A2_apples {\n\tpublic static void main(String[] args){");}( statement {System.out.println("\t\t" + $statement.s+"\n");})+ EOF {System.out.println("\n\t}\n}");} EOF
	;	

statement returns [String s]
	: var_decl { $s = $var_decl.s; }
	| var_assign { $s = $var_assign.s; }
	| repeat_show { $s = $repeat_show.s; }
	;

var_decl returns [String s]
	: 'variable' ID ';' 
		{ 
			$s = "int "+$ID.getText()+";";
			
		}
	;

var_assign returns [String s]
	: 'make' name=ID var ';' 
		{ 
			$s = $name.getText() + " = " + $var.number + ";";
		}
	;

repeat_show returns [String s]
	: 'repeat' iterations=var 'show' x=var ';'
		{ 
			$s = "for(int i = 0; i < " + $iterations.number + "; i++)";
			$s = $s + "System.out.print(" + $x.number + ");";
		}
	;

var returns [String number]
	: ID 
		{ 
			$number = $ID.getText(); 
		}
	| NUM 
		{ 
			$number = ""+ $NUM.getText(); 
		}
	;

/* Terminal Symbols */
NUM : ('0' .. '9')+ ;
ID : ('a' .. 'z' | 'A' .. 'Z')+ ('a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' | '-')* ;
WS : (' ' | '\t' | '\r' | '\n') {skip();} ;

