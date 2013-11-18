module lehmer.rng;

class Lehmer {
    public:
    pure nothrow @safe this(long s = 1, long a = A, long m = M) {
        state = s;
        modulus = m;
        multiplier = a;
        quotient = modulus / multiplier;
        remainder = modulus % multiplier;
    }

    pure nothrow @safe @property long state() const { return mstate; }
    pure nothrow @safe @property void state(long s) { mstate = s; }

    pure nothrow @safe double random() {
        long t = multiplier * (state % quotient) - remainder * (state / quotient);
        state = t > 0 ? t : t + modulus;
        return cast(double)state / cast(double)modulus;
    }

    pure nothrow @safe static bool isModCompatible(in long a, in long m) {
        return m % a < m / a;
    }

    static const long M = 2147483647;
    static const long A = 48271;

    private:
    // Simply a prime number, this is the upper bound (exclusive) of the stream
    // generated
    long modulus;

    // Any full-period, modulus-compatible number to generate the sequence of
    // random numbers
    long multiplier;

    // This "state" is the seed, it picks the starting point of the stream.
    long mstate;

    long quotient;
    long remainder;
}

// From the book:
// If multiplier is set to 48271, and initial value of state is 1, then
// after 10,000 calls to random() state should be 399268537
unittest {
    Lehmer rand = new Lehmer();
    assert(rand.state == 1);

    for(int i = 0; i < 10000; i++) {
        rand.random();
    }
    assert(rand.state == 399268537);
}
