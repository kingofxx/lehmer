import std.stdio;

import lehmer;

int main(string[] args) {
    auto rand = new Lehmer(12345);
    writefln("%s", Lehmer.isModCompatible(48271, 2147483647));
    for (int i = 0; i < 13; i++) {
        writefln("%s\t%s", rand.state, rand.random());
    }
    //writefln("Hello World");
    return 0;
}
