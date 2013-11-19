import std.stdio;

import lehmer.rng;
import lehmer.stream;

int main(string[] args) {
    Lehmer rand = new Lehmer(12345);
    LehmerStream thing = new LehmerStream(1);
    //writefln("%s", thing.state[0]);
    writefln("%s", Lehmer.isModCompatible(48271, 2147483647));
    for (int i = 0; i < 13; i++) {
        writefln("%s\t%s", rand.state, rand.random());
    }
    //writefln("Hello World");
    return 0;
}
