INSTALL
========

This project is configured and built using CMake (http://www.cmake.org).
Please make sure you have a recent version (>2.6) of CMake installed.

Quick install for the impatient
--------------------------------
To configure, build and install the package in the simplest manner::

    $ ./setup 
    $ cd build
    $ make install

Detailed compilation instructions
-----------------------------------

The top level source directory contains a ``setup`` script to configure the 
project for compilation. The setup script is a frontend for CMake, and it can 
configure install paths, compilers, libraries, etc. before executing cmake.
Run ``./setup --help`` for a full list of valid options. 

To configure the project run setup with the appropriate flags for your system::

    $ ./setup --prefix=$HOME/apps --release 

(Alternatively you can run cmake by hand in an empty build directory.)
The project is built in a directory separate from the source (out-of-source
build). The default build directory is called ``build/``, but it can be
changed in the setup. 

If cmake succeeds to configure the project::

    $ cd build
    $ make

If the compilation is successful, you should run the test suite (this may take
some time!)::

    $ make test

If all tests pass, you are ready to install the software::

    $ make install

Changing compiler flags and other configurations
.................................................

If you have special requirements, or are not happy with the default
compiler flags or configuration, you can easily change these using the
``ccmake`` tool. Make sure you are in the build directory, and run::

    $ ccmake .

This start a GUI editor which allows you to change any configuration (except
the compiler(s)).

Bundling and packaging
----------------------------

If you are going to install the software on multiple machines, you can create
binary packages for easy distribution. In the build directory, execute::

    $ make package

This creates a compressed tar.gz archive, a Debian/Ubuntu .deb package and a
RedHat/Fedora .rpm package for convenient installation.
