import std.stdio;

import lehmer;

int main(string[] args) {
    writefln("Hello World");
    if (lehmer.lehmer() == 0)
        writefln("It works!");
    return 0;
}
