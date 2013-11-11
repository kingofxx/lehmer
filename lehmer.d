module lehmer;

class Random {
    private:
    // Any full-period, modulus-compatible number to generate the sequence of
    // random numbers
    long multiplier;

    // 2147483647, 2^31 - 1
    long modulus;

    // This "state" is the seed.
    // not static to allow multiple instances of this lehmer generator, just
    // because
    long mstate;

    public:
    this(long s = 1) {
        mstate = s;
        modulus = 2147483647;
        multiplier = 48271;
    }

    long state() const @property {
        return mstate;
    }

    void state(long s) @property {
        mstate = s;
    }

    double random() {
        long quotient = modulus / multiplier;
        long remainder = modulus % multiplier;
        long t = multiplier * (mstate % quotient) - remainder * (mstate / quotient);
        if (t > 0)
            mstate = t;
        else
            mstate = t + modulus;
        return cast(double)state / cast(double)modulus;
    }
}

// From the book:
// If multiplier is set to 48271, and initial value of state is 1, then
// after 10,000 calls to random() state should be 399,268,537
unittest {
    Random rand = new Random(1);
    assert(rand.state == 1);

    for(int i = 0; i < 10000; i++) {
        rand.random();
    }
    assert(rand.state == 399268537);
}
