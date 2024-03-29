cd c:\dev
echo "Building openssl"
git clone https://github.com/openssl/openssl.git
cd openssl
git checkout OpenSSL_1_1_1v
c:\Strawberry\perl\bin\perl Configure VC-WIN32 no-asm --prefix=%cd%\installdir
nmake > NUL
nmake test >NUL 2>&1
nmake install >NUL
cd installdir
7z a openssl-1_1_1v-msvc2019_x86.zip *
mv openssl-1_1_1v-msvc2019_x86.zip %APPVEYOR_BUILD_FOLDER%
