vertx-mirah-sample
==================

Requirment
----------

1. Install mirah

2. Install vertx

3. Install proguard

Compile
-------

1. Modify Makefile to set project name, version, main class name ...

2. Copy Makefile.local from Makefile.local.example, and modify
   settings to fit your local enviornment

3. Execute `make` to compile the project.

Make module
-----------

Execute `make mod` to make the zip mod file, and check the result in
build dir. NAME-VERSION.zip is a proguarded zip mod, and
NAME-VERSION-origin.zip is unproguarded one.

Note
----

Don't call mirah in java source, because we compile java source code
first, then mirah source code.
