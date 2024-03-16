# Makefile for the CSC 7101 Verification Condition Generator

MAIN = VCG
LANG = IMP
PDIR = Parse
TDIR = Tree
START= program
EXE  = VCG.jar
JAR  = VCG.class Parse/*.class Parse/*.tokens Tree/*.class org

# Set CPSEP to ; on Windows and : on MacOS or Linux
CPSEP= :
ANTLR= antlr-4.13.1-complete.jar

ARUN = java -jar ${ANTLR}
GRUN = java -cp ".${CPSEP}${PDIR}/${ANTLR}" org.antlr.v4.gui.TestRig
JFLAG= -g -cp ${PDIR}/${ANTLR}

all: antlr
	javac ${JFLAG} ${MAIN}.java ${PDIR}/${LANG}*.java ${TDIR}/*.java

antlr: ${PDIR}/${LANG}.g4
	(cd ${PDIR}; ${ARUN} ${LANG}.g4)

test: all test.vcg
	${GRUN} ${PDIR}.${LANG} ${START} -gui test.vcg

jar: all
	mkdir tmp
	(cd tmp; jar xf ../Parse/${ANTLR}; mv org ..)
	jar cfm ${EXE} Manifest.txt ${JAR}
	rm -rf tmp org

clean:
	rm -f *.class *~ ${TDIR}/*.class ${TDIR}/*~
	(cd ${PDIR}; rm -f ${LANG}*.java ${LANG}*.tokens *.interp *.class *~)

veryclean:
	rm -f *.class *~ ${TDIR}/*.class ${TDIR}/*~ ${EXE}
	(cd ${PDIR}; rm -f ${LANG}*.java ${LANG}*.tokens *.interp *.class *~)

