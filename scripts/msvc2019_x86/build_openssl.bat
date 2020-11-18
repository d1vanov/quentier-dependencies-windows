cd c:\dev
echo "Building openssl"
git clone https://github.com/openssl/openssl.git
cd openssl
git checkout OpenSSL_1_1_1h
c:\Strawberry\perl\bin\perl Configure VC-WIN32 no-asm --prefix=%cd%\installdir
nmake -C
nmake -C test
nmake -C install
cd installdir
7z a openssl-1_1_1h-msvc2019_x86.zip *
mv openssl-1_1_1h-msvc2019_x86.zip %APPVEYOR_BUILD_FOLDER%
