all:
	java -cp ./antlr-4.6-complete.jar:. org.antlr.v4.Tool -no-listener -no-visitor *.g4
	javac -cp ./antlr-4.6-complete.jar:. *.java

run:
	java -cp ./antlr-4.6-complete.jar:. ParseFile inputfile >SillyOut.java


silly:
	javac SillyOut.java
	java SillyOut
	

#for windows change rm to del
clean:
	rm Silly*.java *.tokens *.class 
