cd c:\dev
echo "Building openssl"
git clone https://github.com/openssl/openssl.git
cd openssl
git checkout OpenSSL_1_0_2r
REM release MSVC build
perl Configure VC-WIN64A no-asm --prefix=%cd%\installdir
call ms\do_win64a.bat
nmake -f ms\ntdll.mak
cd out32dll
call ..\ms\test.bat
cd ..
nmake -f ms\ntdll.mak install
REM debug MSVC build
call perl Configure debug-VC-WIN64A no-asm --prefix=%cd%\installdir
call ms\do_win64a.bat
nmake -f ms\ntdll.mak
cd out32dll
call ..\ms\test.bat
cd ..
nmake -f ms\ntdll.mak install
REM Copy renamed debug libs into the release installation dir
copy installdir-dbg\lib\libeay32.lib installdir\lib\libeay32d.lib
copy installdir-dbg\lib\ssleay32.lib installdir\lib\ssleay32d.lib
REM Finalization
cd installdir
7z a openssl-1_0_2r-msvc2017_x64.zip *
mv openssl-1_0_2r-msvc2017_x64.zip %APPVEYOR_BUILD_FOLDER%
