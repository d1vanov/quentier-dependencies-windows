cd c:\dev
echo "Building breakpad"
md breakpad
git clone https://github.com/d1vanov/google-breakpad.git breakpad
cd breakpad
git checkout pecoff-dwarf-on-git-20171117
set APPVEYOR_BUILD_FOLDER_BAK=%APPVEYOR_BUILD_FOLDER%
set APPVEYOR_BUILD_FOLDER=%cd%
set PATH_BEFORE=%PATH%
set HOST=i686-w64-mingw32
set Configuration=Release
C:\cygwin64\bin\bash -lc "sed -i '23s#sh scripts/appveyor-gcc.sh#export PATH=/cygdrive/c/MinGW/bin:$PATH; export CC=/cygdrive/c/MinGW/bin/gcc.exe; export CXX=/cygdrive/c/MinGW/bin/g++.exe; sh scripts/appvryor-gcc.sh# /cygdrive/c/dev/breakpad/scripts/appveyor.bat"
call scripts\appveyor-gcc.bat install
call scripts\appveyor-gcc.bat build_script
call scripts\appveyor-gcc.bat test_script
set PATH=%PATH_BEFORE%
set APPVEYOR_BUILD_FOLDER=%APPVEYOR_BUILD_FOLDER_BAK%
mv staging\usr installdir
md installdir\include\breakpad\client\windows
md installdir\include\breakpad\common\windows
xcopy src installdir\include\breakpad /e /y >NUL
REM Finalization
cd c:\dev\breakpad\installdir\bin
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/minidump_stackwalk.exe -o minidump_stackwalk.exe
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/cygwin1.dll -o cygwin1.dll
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/cygstdc++-6.dll -o cygstdc++-6.dll
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/cyggcc_s-1.dll -o cyggcc_s-1.dll
cd ..
7z a breakpad-mingw530_x86.zip *
mv breakpad-mingw530_x86.zip %APPVEYOR_BUILD_FOLDER%
