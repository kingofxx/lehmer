class Random {
    // Any full-period, modulus-compatible number to generate the sequence of
    // random numbers
    long multiplier;

    // 2147483647, 2^31 - 1
    long modulus;

    // This "state" is the seed.
    // not static to allow multiple instances of this lehmer generator, just
    // because
    long state;

    //TODO D constructor allows for giving seed
    this(long s) {
        this.state = s;
    }

    //TODO Fancy D style accessor for seed

    double random() {
        long quotient = modulus / multiplier;
        long remainder = modulus % remainder;
        long t = multiplier * (state % quotient) - remainder * (state / quotient);
        if (t > 0)
            state = t;
        else
            state = t + M;
        return cast(double)state / cast(double)modulus;
    }

    //TODO Unit test
    // From the book:
    // If multiplier is set to 48271, and initial value of state is 1, then
    // after 10,000 calls to random() state should be 399,268,537
}

unittest {
    Random rand = new Random(1);

    for(int i = 0; i < 10000; i++) {
        rand.random();
    }
    assert(rand.state == 399268537);
}
