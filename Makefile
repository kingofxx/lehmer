D=dmd
DEBUG=-debug -gc
RELEASE=-release -O -inline
FLAGS=-c
EXE=-ofSIM

all: lehmer

lehmer: test.o stream.o rng.o
	$(D) test.o stream.o rng.o $(DEBUG) $(EXE)

test.o: stream.o rng.o
	$(D) test.d $(FLAGS) $(DEBUG)

stream.o: stream.d
	$(D) stream.d $(FLAGS) $(DEBUG)

rng.o: rng.d
	$(D) rng.d $(FLAGS) $(DEBUG)

test:
	$(D) test.d stream.d rng.d -unittest $(FLAGS) $(DEBUG) $(EXE)

clean:
	rm *.o SIM
