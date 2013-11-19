module lehmer.stream;

import std.stdio;
import lehmer.rng;

class LehmerStream {
    public:
    this(long s = 1, long streams = 256, long a = Lehmer.A, long m = Lehmer.M) {
        numStreams = streams;
        rng = new Lehmer(s, a, m);
        if (a == Lehmer.A && m == Lehmer.M) {
            switch (streams) {
            case 128:
                jumpMult = jump128;
                break;
            case 256:
                jumpMult = jump256;
                break;
            case 512:
                jumpMult = jump512;
                break;
            case 1024:
                jumpMult = jump1024;
                break;
            default:
                jumpMult = calcJumpMult(numStreams, a, m);
            }
        } else {
            jumpMult = calcJumpMult(numStreams, a, m);
        }
        calls = new ulong[numStreams];
        states = new long[numStreams];
        long q = m / a;
        long r = m % a;
        for (ulong i = 0UL; i < numStreams; i++) {
            states[i] = s;
            s = jumpMult * (s % q) - r * (s / q);
            if (s < 0) { s += rng.m; }
        }
    }

    pure nothrow @safe double random(in ulong stream) {
        calls[stream]++;
        rng.state = states[stream];
        double num = rng.random();
        states[stream] = rng.state;
        return num;
    }

    static pure nothrow @safe long calcJumpMod(in long streamCount, in long a, in long m) {
        long jump = m / streamCount;
        long mult = modpow(a, jump, m);
        //long mult = (a ^^ jump) % m;
        while (!Lehmer.isModCompatible(mult, m)) {
            mult = modpow(a, --jump, m);
            //mult = (a ^^ --jump) % m;
        }
        return mult;
    }

    static pure nothrow @safe long modpow(ulong b, ulong e, ulong mod) {
        ulong result = 1;
        while (e > 0) {
            if (e % 2 == 1) {
                result = result * b % mod;
            }
            e >>= 1;
            b = (b ^^ 2) % mod;
        }
        return result;
    }

    pure nothrow @safe @property const(long[]) state() const { return states; }
    pure nothrow @safe @property ulong streams() const { return numStreams; }
    pure nothrow @safe @property long streamLength() const { return rng.m / streams; }

    static const long jump128 = 40509L;
    static const long jump256 = 22925L;
    static const long jump512 = 44857L;
    static const long jump1024 = 97070L;

    private:
    Lehmer rng;
    long jumpMult;
    ulong[] calls;
    long[] states;
    ulong numStreams;
}
