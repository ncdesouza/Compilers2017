# Assignment 2

You are going to create a lexer, parser, and compiler for a new language named A2!

Your compiler will take A2 source code, and output Java code that could then be compiled and ran without errors. If there is an error in the g4 source code, then the Parser will print an error (Antlr handles that for you).

## Files Provided

* A2.g4
* ParseFile.java  
* test directory
* antlr-4.6-complete.jar
* Makefile
* README.md

The only file you will need to modify in the project folder is the A2.g4, but your submission will be the entire folder as a zip.

## A2 Language Details 

### my program

Defines the program name, and is also used as the class name in the Java code. This rule will be given to you along with the start symbol in the g4.

### num

Allows you to declare a number variable, which will get translated into a Java integer.

### str

Defines a String variable, which gets translated into a Java String.

### assign 

Allows you to assign a value to a variable, works for both num and str.

### show

This will print a variable to the console.

### loop

This loop will take a number and then repeat a block of statements that number of time. The block of statements is surrounded by braces.

### check

This check is the equivalent of a if statement, there are no else blocks in the A2 language though.

### Example

An example source code is:
```
my program AdelesExample/
num x/
num y/
str name/
assign name "Adele"/
assign x 5/

loop 3 { 
	show x / 
}

assign y 10/

loop x {
	show y/
}

loop y {
	show name/
	loop 3 {
		show y/
	}
}
```

Which gets compiled into the following Java:
```
/*
Adele Hedrick
100xxxxxx
*/
public class AdelesExample {
	public static void main(String[] args){
		int x;

		int y;

		String name;

		name = "Adele";

		x = 5;

		for(int i1 = 0; i1 < 3; i1++) {
			System.out.println(x);

		}

		y = 10;

		for(int i2 = 0; i2 < x; i2++) {
			System.out.println(y);

		}

		for(int i4 = 0; i4 < y; i4++) {
			System.out.println(name);
			for(int i3 = 0; i3 < 3; i3++) {
			System.out.println(y);

		}

		}


	}
}
```
 
## Context Free Grammar

```
start --> my_program statements+
my_program --> 'my program' ID '/'
statement --> num_decl | str_decl | var_assign | loop | show | check
loop --> 'loop' var '{' statement+ '}'
check --> check condition '{' statement+ '}'
condition --> var OP var
num_decl --> 'num' ID '/'
str_decl --> 'str' ID '/'
var_assign --> 'assign' ID var '/'
show --> 'show' var '/'
var --> ID | NUM | STR
```

## Makefile Commands

### make all

`make all` will generate your Lexer and Parser from your A2.g4. If you have errors in your g4, this command will error out.

### make test<num>

`make test1` .. `make test6` will test different input files on your generated Lexer and Parser, so make sure you run `make all` before the tests.

### make clean

`make clean` will remove all the generated files.

### make tree<num>

`make tree1` .. `make tree6` will show a parse tree of the input file that correctly parses for that same test case.

## Your Tasks

### 1. Fill in the variables in the @members with your information at the top of the A2.g4
 
```
@members {
	String firstName = "Adele";
	String lastName = "Hedrick";
	String studentNum = "100xxxxxx";
	int uniqueLoops = 0;
}
```

### 2. Implement num_decl, str_decl, and statement

Implement num_decl and str_decl, your statement rule should only have two productions at this point:
```
statement --> num_decl | str_decl
```

Once you pass `make test1` you can move on.

### 3. Implement var_assign and modify statement

Implement var_assign, your statement rule should only have three productions at this point:
```
statement --> num_decl | str_decl | var_assign
```

Once you pass `make test2` you can move on.

### 4. Implement show and modify statement

Implement show, your statement rule should only have four productions at this point:
```
statement --> num_decl | str_decl | var_assign | show
```

Once you pass `make test3` you can move on.

### 5. Implement loop and modify statement

Implement loop, your statement rule should only have all productions at this point:
```
statement --> num_decl | str_decl | var_assign | show | loop
```

The naive approach is to break this into two new statements of loop_start and loop_end. This will give you working Java code so long as your source code is correct, but it wont catch errors such as a missing end to the loop.

```
statement --> num_decl | str_decl | var_assign | show | loop_start | loop_end
loop_start --> 'loop' var '{'
loop_end --> '}'
```

Once you pass `make test4` you can move on.

### 6. Implement loop _correctly_

Can you implement loop correctly with the original rule of:
```
loop --> 'loop' var '{' statement+ '}'
```

This task is not for the faint of heart, and should you complete loop correctly, your Parser will be capable of catching a missing end to a loop, *and* be able to have nested loops! I left in a loopCounter variable in the @members, you will need to append this value to the temporary variable name used in the for loop generated, and then _increment_ the loopCounter in the appropriate spot. The loopCounter is necessary in getting nested loops working.

You need to pass all of `make test5`.

### 7. Implement check _correctly_

If you implemented loop correctly, then you can implement check as well! Go for 100%!

You will need to pass `make test6`.

### 7. Meet all of the submission guidelines

Submission Guidelines:

* A2.g4 includes your name and student number properly
* A2.g4 is nicely indented for readability 
* Folder has been renamed with your student number _before_ zipping
* Folder has been zipped
* Zipped folder has been uploaded to blackboard

## Tests

### Test 1

Test 1 will parse two input files: inputfile1 and inputfile2, and give you the following output:
```
$ make test1
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile1 >Test11.java
javac Test11.java
java -cp . Test11
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile2 >Test12.java
line 4:0 extraneous input 'str' expecting ID

```

Parsing inputfile2 should give you the error you see above, and parsing inputfile1 should give you the Test11.java file you see below.

```
/*
Adele Hedrick
100xxxxxx
*/
public class Test11 {
	public static void main(String[] args){
		int x;

		int y;

		String name;


	}
}
```

### Test 2

Test 2 will parse two input files: inputfile3 and inputfile4, and give you the following output:
```
$ make test2
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile3 >Test21.java
javac Test21.java
java -cp . Test21
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile4 >Test22.java
line 7:0 extraneous input 'assign' expecting {NUM, ID, STR}
line 7:12 extraneous input '"Bob"' expecting '/'

```

Parsing inputfile4 should give you the error you see above, and parsing inputfile3 should give you the Test21.java file you see below.

```
/*
Adele Hedrick
100xxxxxx
*/
public class Test21 {
	public static void main(String[] args){
		int x;

		int y;

		String name;

		x = 4;

		y = 3;

		name = "Bob";


	}
}
```

### Test 3

Test 3 will parse two input files: inputfile5 and inputfile6, and give you the following output:
```
$ make test3
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile5 >Test31.java
javac Test31.java
java -cp . Test31
4
Bob
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile6 >Test32.java
line 9:0 extraneous input 'show' expecting {NUM, ID, STR}

```

Parsing inputfile6 should give you the error you see above, and parsing inputfile5 should give you the output you see above and the Test31.java file you see below.

```
/*
Adele Hedrick
100xxxxxx
*/
public class Test31 {
	public static void main(String[] args){
		int x;

		int y;

		String name;

		x = 4;

		y = 3;

		name = "Bob";

		System.out.println(x);

		System.out.println(name);


	}
}
```

### Test 4

Test 4 will parse two input files: inputfile7 and inputfile8, and give you the following output:
```
$ make test4
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile7 >Test41.java
javac Test41.java
java -cp . Test41
Bob
Bob
Bob
Bob
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile8 >Test42.java
line 8:5 mismatched input '{' expecting {NUM, ID, STR}

```

Parsing inputfile8 should give you the error you see above, and parsing inputfile7 should give you the output you see above and the Test41.java file you see below.

```
/*
Adele Hedrick
100xxxxxx
*/
public class Test41 {
	public static void main(String[] args){
		int x;

		int y;

		String name;

		x = 4;

		y = 3;

		name = "Bob";

		for(int i1 = 0; i1 < x; i1++) {
			System.out.println(name);

		}


	}
}
```

### Test 5

Test 5 will parse two input files: inputfile9 and inputfile10, and give you the following output:
```
$ make test5
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile9 >Test51.java
javac Test51.java
java -cp . Test51
Bob
o
o
o
Bob
o
o
o
Bob
o
o
o
Bob
o
o
o
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile10 >Test52.java
line 14:0 missing '}' at '<EOF>'

```

Parsing inputfile10 should give you the error you see above, and parsing inputfile9 should give you the output you see above and the Test51.java file you see below.

```
/*
Adele Hedrick
100xxxxxx
*/
public class Test51 {
	public static void main(String[] args){
		int x;

		int y;

		String name;

		x = 4;

		y = 3;

		name = "Bob";

		for(int i2 = 0; i2 < x; i2++) {
			System.out.println(name);
			for(int i1 = 0; i1 < y; i1++) {
			System.out.println("o");

		}

		}


	}
}
```

### Test 6

Test 6 will parse two input files: inputfile11 and inputfile12, and give you the following output:
```
$ make test6
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile11 >Test61.java
javac Test61.java
java -cp . Test61
Bob
x
x
x
Bob
o
o
o
Bob
o
o
o
Bob
o
o
o
java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile12 >Test62.java
line 11:13 mismatched input '{' expecting {NUM, ID, STR}

```

Parsing inputfile12 should give you the error you see above, and parsing inputfile11 should give you the output you see above and the Test61.java file you see below.

```
/*
Adele Hedrick
100xxxxxx
*/
public class Test61 {
	public static void main(String[] args){
		int x;

		int y;

		String name;

		x = 4;

		y = 3;

		name = "Bob";

		int a;

		int b;

		a = 1;

		b = 0;

		for(int i4 = 0; i4 < x; i4++) {
			System.out.println(name);
			for(int i3 = 0; i3 < y; i3++) {
			if (a==b) {
			System.out.println("o");

		}
			if (a!=b) {
			System.out.println("x");

		}

		}
			b = a;

		}


	}
}
```

## Notes

* I don't care how your output Java code is indented, no marks will be taken off
* No part marks are given in this one, it is an all or nothing sort of deal
* I'm marking the console output and generated Java files
* I will be replacing the 12 input files with my own that are similar, so hard coding output wont work

## Marking Scheme

* 30 marks for implementing num_decl and str_decl and passing `make test1`
* 20 marks for implementing var_assign and passing `make test2`
* 10 marks for implementing show and passing `make test3`
* 15 marks for implementing loop and passing `make test4`
* 10 marks for _correctly_ implementing loop and passing `make test5`
* 10 marks for _correctly_ implementing check and passing `make test6`
* 5 marks for following submission guidelines

