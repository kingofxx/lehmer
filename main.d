import std.stdio;

import lehmerrng;
import lehmerstream;

int main(string[] args) {
    auto rand = new Lehmer(12345);
    LehmerStream thing;
    writefln("%s", Lehmer.isModCompatible(48271, 2147483647));
    for (int i = 0; i < 13; i++) {
        writefln("%s\t%s", rand.state, rand.random());
    }
    //writefln("Hello World");
    return 0;
}
