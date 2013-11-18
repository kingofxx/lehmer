D=dmd
DEBUG=-debug -g
RELEASE=-release -O -inline
FLAGS=-c -w
EXE=-ofSIM

all: next

next: main stream.o rng.o
	$(D) main.o stream.o rng.o $(EXE)

main:
	$(D) main.d $(FLAGS) $(DEBUG)

stream.o: rng.o
	$(D) lehmer/stream.d $(FLAGS) $(DEBUG)

rng.o:
	$(D) lehmer/rng.d $(FLAGS) $(DEBUG)

clean:
	rm *.o SIM
