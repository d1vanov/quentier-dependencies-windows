cd c:\dev
echo "Building openssl"
git clone https://github.com/openssl/openssl.git
cd openssl
git checkout OpenSSL_1_1_1d
C:\MinGW\msys\1.0\bin\bash -lc "cd /c/dev/openssl && ./Configure shared mingw --prefix=/c/dev/openssl/installdir && make depend > /dev/null && make > /dev/null && make test > /dev/null && make install"
REM Finalization
cd installdir
7z a openssl-1_1_1d-mingw530_x86.zip *
mv openssl-1_1_1d-mingw530_x86.zip %APPVEYOR_BUILD_FOLDER%
