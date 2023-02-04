# MS Visual Studio solution for building Nirvana for Windows

[![CI](https://gist.githubusercontent.com/silver-popov/5e83ddfb2531206b60b6451851c51b2a/raw/badge.svg)](https://github.com/nirvanaos/nirvana.vc/actions/workflows/build.yml)

## Folders
### Content

This repository contains MS Visual Studio (2019 and 2022) solution for build the Nirvana subprojects.

Other Nirvana projects included here as submodules.

### Core

The Nirvana core and tests.

### dumpolf.vc

Utility for dump Nirvana OLF (object loadable format) metadata.

### Library.vc

Libraries.

### nidl2cpp.vc

Nirvana IDL to C++ compiler.

### Port

The portability library.
The layer between the Core and the underlying host. Underlying host may
be the other operating system or the micro kernel. Currently implemented
the port for the Windows only.

### TestORB.vc

Nirvana ORB test.

## Build and Test

Right-click on the solution and select Open in Terminal.

In Developer PowerShell window enter command:
`.\BuildAndTest.ps1 "x64" "Debug 2022"

In the example above "x64" is platform and may be "Win32".

"Debug 2022" is the configuration and may be:

* "Release 2022"
* "Debug 2019"
* "Debug LLVM"
* "Release LLVM"

## Examples

Folder .\TestORB.vc\TestORB contains the test sources.

