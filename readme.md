# MS Visual Studio solution for building Nirvana for Windows

[![CI](https://gist.githubusercontent.com/silver-popov/5e83ddfb2531206b60b6451851c51b2a/raw/badge.svg)](https://github.com/nirvanaos/nirvana.vc/actions/workflows/build.yml)
[![CI](https://gist.githubusercontent.com/silver-popov/5e83ddfb2531206b60b6451851c51b2a/raw/test_core.svg)](https://github.com/nirvanaos/nirvana.vc/actions/workflows/test_core.yml)
[![CI](https://gist.githubusercontent.com/silver-popov/5e83ddfb2531206b60b6451851c51b2a/raw/test2019.svg)](https://github.com/nirvanaos/nirvana.vc/actions/workflows/test2019.yml)

### Content

This is a part of the [Nirvana project](https://github.com/nirvanaos/home).

This repository contains MS Visual Studio 2022 solution for building the Nirvana projects with MS Visual C compiler and libraries.

Other Nirvana projects included here as submodules.

This project relates to the first stage of Nirvana development and will be obsolete soon.
The new [Nirvana SDK](https://github.com/nirvanaos/nirvana-sdk) has own C runtime library, LLVM standard C++ library and uses CLang compiler.

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

Nirvana tests.

## Build

Open the `Nirvana.sln` solution in Visual Studio 2022 or 2019.
Right-click on the solution and select Open in Terminal.

In Developer PowerShell window enter commands:
```console
> .\Build.ps1 "x64" "Debug 2022"
> .\Build.ps1 "Win32" "Debug 2022"
```

For Visual Studio 2019 use configuration "Debug 2019" instead of "Debug 2022".

Also the following configurations are available:

* "Release 2022" - release build with VS 2022.
* "Release 2019" - release build with VS 2019.

If you have CLang toolset installed in Visual Studio, you can also use the following configurations:

* "Debug LLVM" - debug build with CLang-CL (CLang support must be installed in VS).
* "Release LLVM"

## Test

After building both x64 and Win32 platforms, use PowerShell command:

In Developer PowerShell window enter commands:
```console
> .\Test.ps1 "x64" "Debug 2022"
> .\Test.ps1 "Win32" "Debug 2022"
```

## Examples

Folder `.\TestORB.vc\TestORB` contains the test sources.
These sources may be used to explore different Nirvana features.
