cd c:\dev
echo "Building libbacktrace"
git clone https://github.com/ianlancetaylor/libbacktrace.git
cd libbacktrace
C:\msys64\usr\bin\bash -lc "cd /c/dev/libbacktrace && CC=C:/MinGW/bin/gcc CXX=C:/MinGW/bin/g++ ./configure --prefix=$(pwd)/installdir --host=i686-w64-mingw32 && make && make install"
cd installdir
7z a libbacktrace-mingw530_x86.zip *
mv libbacktrace-mingw530_x86.zip %APPVEYOR_BUILD_FOLDER%
