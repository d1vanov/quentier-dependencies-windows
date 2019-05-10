cd c:\dev
echo "Building zlib"
md zlib-win-build
cd zlib-win-build
curl -fsSL https://zlib.net/zlib-1.2.11.tar.gz -o zlib-1.2.11.tar.gz
7z x zlib-1.2.11.tar.gz
7z x zlib-1.2.11.tar
del zlib-1.2.11.tar
del zlib-1.2.11.tar.gz
cd zlib-1.2.11
C:\MinGW\bin\mingw32-make.exe install -f win32\Makefile.gcc INCLUDE_PATH=%cd%\installdir\include BINARY_PATH=%cd%\installdir\bin LIBRARY_PATH=%cd%\installdir\lib SHARED_MODE=1
cd installdir
7z a zlib-1.2.11-mingw530_x86.zip *
mv zlib-1.2.11-mingw530_x86.zip %APPVEYOR_BUILD_FOLDER%
