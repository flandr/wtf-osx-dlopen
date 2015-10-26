# DYLD_LIBRARY_PATH considered silly

Did you know that OS X's `dlopen` will search for dynamic libraries relative to
the `DYLD_LIBRARY_PATH` first _even if the input path is absolute_? Does that
seem crazy to you?. It seems crazy to me.

Build:

```
$ make
+ cc foo.o
+ ld libfoo.dylib
+ cc fakefoo.o
+ ld libfakefoo.dylib
+ cc main
```

A sane system (Ubuntu 14.04):

```
Doing dlopen on the real libfoo. Any sane system will report so:
=== Invoking the real foo
```

OS X 10.10.4, aka Crazy Town:

```
$ ./wtf.sh
Doing dlopen on the real libfoo. Any sane system will report so:
=== Invoking the fake foo
```

OK, hope this helps.
