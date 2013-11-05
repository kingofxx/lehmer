D=dmd
DEBUG=-debug -g
RELEASE=-release -O -inline
FLAGS=-c -w
EXE=-ofSIM

all: next

next: main lehmer
	$(D) main.o lehmer.o $(EXE)

main:
	$(D) main.d $(FLAGS) $(DEBUG)

lehmer:
	$(D) lehmer.d $(FLAGS) $(DEBUG)

clean:
	rm *.o SIM
