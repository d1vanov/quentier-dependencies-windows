cd c:\dev
echo "Building openssl"
REM Checkout zlib first as it's needed as a hard dependency
git clone https://github.com/kiyolee/zlib-win-build.git zlib-win-build
cd zlib-win-build
git checkout v1.2.11
cd ..
REM Checkout openssl
git clone https://github.com/kiyolee/openssl1_1-win-build.git openssl1_1-win-build
cd openssl1_1-win-build
git checkout v1.1.1f
cd build-VS2019
REM Build
msbuild openssl1_1.sln /p:Configuration="Release" /p:Platform="Win32" /clp:ErrorsOnly
md installdir
md installdir\include
md installdir\bin
md installdir\lib
dir /s /b
copy Release\libcrypto-1_1.dll installdir\bin\libcrypto-1_1.dll
copy Release\libcrypto.lib installdir\bin\libcrypto.lib
copy Release\libssl-1_1.dll installdir\bin\libssl-1_1.dll
copy Release\libssl.lib installdir\bin\libssl.lib
xcopy ..\include installdir\include /e >NUL
REM Finalization
cd installdir
7z a openssl-1_1_1f-msvc2019_x86.zip *
mv openssl-1_1_1f-msvc2019_x86.zip %APPVEYOR_BUILD_FOLDER%
