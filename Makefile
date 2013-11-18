D=dmd
DEBUG=-debug -g
RELEASE=-release -O -inline
FLAGS=-c -w
EXE=-ofSIM

all: next

next: main lehmerstream.o lehmer.o
	$(D) main.o lehmer.o $(EXE)

main:
	$(D) main.d $(FLAGS) $(DEBUG)

lehmerstream.o: lehmer.o
	$(D) lehmerstream.d $(FLAGS) $(DEBUG)

lehmer.o:
	$(D) lehmer.d $(FLAGS) $(DEBUG)

clean:
	rm *.o SIM
