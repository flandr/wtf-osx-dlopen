#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>

typedef void(*foo_fn)(void);

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Don't forget your library name\n");
        exit(1);
    }
    void *handle = dlopen(argv[1], RTLD_NOW);
    if (!handle) {
        fprintf(stderr, "Fail: %s\n", dlerror());
        exit(1);
    }

    foo_fn foohandle = (foo_fn) dlsym(handle, "foo");
    if (!foohandle) {
        fprintf(stderr, "Couldn't find foo: %s\n", dlerror());
    } else {
        (*foohandle)();
    }

    dlclose(handle);
}
