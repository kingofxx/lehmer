D=dmd
DEBUG=-debug -gc
RELEASE=-release -O -inline
FLAGS=-c
EXE=-ofSIM

all: next

next: main stream.o rng.o
	$(D) main.o stream.o rng.o $(DEBUG) $(EXE)

main: stream.o rng.o
	$(D) main.d $(FLAGS) $(DEBUG)

stream.o: rng.o
	$(D) lehmer/stream.d $(FLAGS) $(DEBUG)

rng.o:
	$(D) lehmer/rng.d $(FLAGS) $(DEBUG)

test:
	$(D) main.d lehmer/stream.d lehmer/rng.d -unittest $(FLAGS) $(DEBUG) $(EXE)

clean:
	rm *.o SIM
