import std.stdio;

import lehmer;

int main(string[] args) {
    auto rand = new Random(12345);
    for (int i = 0; i < 13; i++) {
        writefln("%s\t%s", rand.state, rand.random());
    }
    //writefln("Hello World");
    return 0;
}
