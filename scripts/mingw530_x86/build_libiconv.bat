cd c:\dev
echo "Building libiconv"
md libiconv-win-build
cd libiconv-win-build
curl -fsSL https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz -o libiconv-1.15.tar.gz
7z x libiconv-1.15.tar.gz
7z x libiconv-1.15.tar
del libiconv-1.15.tar
del libiconv-1.15.tar.gz
cd libiconv-1.15
C:\cygwin\bin\bash -lc "cd /cygdrive/c/dev/libiconv-win-build/libiconv-1.15 && export PATH=/usr/local/mingw32/bin:$PATH && ./configure --host=i686-w64-mingw32 --prefix=$(pwd)/installdir CC=i686-w64-mingw32-gcc CPPFLAGS='-I/usr/local/mingw32/include -Wall' LDFLAGS='-L/usr/local/mingw32/lib' && make && make check && make install"
REM Finalization
cd installdir
7z a libiconv-1.15-mingw530_x86.zip *
mv libiconv-1.15-mingw530_x86.zip %APPVEYOR_BUILD_FOLDER%
