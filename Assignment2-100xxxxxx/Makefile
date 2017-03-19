all:
	java -cp ./antlr-4.6-complete.jar:. org.antlr.v4.Tool -no-listener -no-visitor *.g4
	javac -cp ./antlr-4.6-complete.jar:. *.java

test1: 
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile1 >Test11.java
	javac Test11.java
	java -cp . Test11
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile2 >Test12.java

tree1: 
	java -cp ./antlr-4.6-complete.jar:. org.antlr.v4.runtime.misc.TestRig A2 start -gui <test/inputfile1

tokens1:
	java -cp ./antlr-4.6-complete.jar:. org.antlr.v4.runtime.misc.TestRig A2 start -tokens <test/inputfile1


test2:
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile3 >Test21.java
	javac Test21.java
	java -cp . Test21
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile4 >Test22.java

tree2:
	java -cp ./antlr-4.6-complete.jar:. org.antlr.v4.runtime.misc.TestRig A2 start -gui <test/inputfile3

test3:
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile5 >Test31.java
	javac Test31.java
	java -cp . Test31
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile6 >Test32.java

tree3:
	java -cp ./antlr-4.6-complete.jar:. org.antlr.v4.runtime.misc.TestRig A2 start -gui <test/inputfile5

test4:
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile7 >Test41.java
	javac Test41.java
	java -cp . Test41
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile8 >Test42.java

tree4:
	java -cp ./antlr-4.6-complete.jar:. org.antlr.v4.runtime.misc.TestRig A2 start -gui <test/inputfile7

test5:
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile9 >Test51.java
	javac Test51.java
	java -cp . Test51
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile10 >Test52.java

tree5:
	java -cp ./antlr-4.6-complete.jar:. org.antlr.v4.runtime.misc.TestRig A2 start -gui <test/inputfile9

test6:
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile11 >Test61.java
	javac Test61.java
	java -cp . Test61
	java -cp ./antlr-4.6-complete.jar:. ParseFile test/inputfile12 >Test62.java

tree6:
	java -cp ./antlr-4.6-complete.jar:. org.antlr.v4.runtime.misc.TestRig A2 start -gui <test/inputfile11
	

#for windows change rm to del
clean:
	rm A2*.java *.tokens *.class Test*.java
