cd c:\dev
echo "Building hunspell"
git clone https://github.com/hunspell/hunspell.git hunspell
cd c:\dev\hunspell
git checkout v1.6.2
md installdir
md installdir\include
md installdir\include\hunspell
md installdir\lib
md installdir\bin
REM Need to apply a small patch for building with MinGW
C:\msys64\usr\bin\bash -lc "cd /c/dev/hunspell && autoreconf -i && sed -i -e s/\ \|\ S_IRWXG\ \|\ S_IRWXO//g src/tools/hzip.cxx && CC=C:/MinGW/bin/gcc CXX=C:/MinGW/bin/g++ ./configure --prefix=$(pwd)/installdir --host=i686-w64-mingw32 && make && make check && make install"
REM Finalization
cd installdir
7z a libhunspell-1.6.2-mingw530_x86.zip *
mv libhunspell-1.6.2-mingw530_x86.zip %APPVEYOR_BUILD_FOLDER%
