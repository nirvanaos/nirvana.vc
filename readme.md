# MS Visual Studio solution for building Nirvana for Windows

### Content

This repository contains MS Visual Studio 2019 solution for build the Nirvana subprojects.

Other Nirvana projects included here as submodules.

## Folders

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

## Running

After building the solution you can run the Nirvana test:

\> cd Win32\Debug *(or other platform/configuration)*

\> .\Nirvana.exe -s TestProcess.nex

## Examples

Folder .\TestORB.vc\TestORB contains the test sources.

