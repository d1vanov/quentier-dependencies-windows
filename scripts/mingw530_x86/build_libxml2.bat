cd c:\dev
echo "Building libxml2"
REM Prepare libiconv build dependency
md libiconv
cd libiconv
7z x %APPVEYOR_BUILD_FOLDER%\libiconv-1.15-mingw530_x86.zip
set PATH=%cd%\bin;%PATH%
set INCLUDE=%cd%\include;%INCLUDE%
set LIB=%cd%\lib;%LIB%
cd ..
REM Prepare zlib build dependency
md zlib
cd zlib
7z x %APPVEYOR_BUILD_FOLDER%\zlib-1.2.11-mingw530_x86.zip
set PATH=%cd%\bin;%PATH%
set INCLUDE=%cd%\include;%INCLUDE%
set LIB=%cd%\lib;%LIB%
cd ..
REM Build libxml2
git clone https://gitlab.gnome.org/GNOME/libxml2.git
cd libxml2
git checkout v2.9.7
cd win32
REM Need to rename the import library for libxml2.dll
C:\msys64\usr\bin\bash -lc "cd /c/dev/libxml2/win32 && sed -i -e s/\$\(XML_BASENAME\)\.lib/\$\(XML_BASENAME\).dll.a/g Makefile.mingw"
cscript configure.js compiler=mingw prefix=%cd%\installdir debug=no http=no ftp=no
C:\MinGW\bin\mingw32-make.exe install -f Makefile.mingw
REM Removing the static libxml2.a library as CMake seems to prefer it over
REM the shared library yet this static library requires the target application
REM to explicitly link to libiconv which is not desired
del installdir\lib\libxml2.a
REM Finalization
cd installdir
7z a libxml2-2.9.7-mingw530_x86.zip *
mv libxml2-2.9.7-mingw530_x86.zip %APPVEYOR_BUILD_FOLDER%
