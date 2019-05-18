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
call scripts\appveyor-gcc.bat install
call scripts\appveyor-gcc.bat build_script
call scripts\appveyor-gcc.bat test_script
set PATH=%PATH_BEFORE%
set APPVEYOR_BUILD_FOLDER=%APPVEYOR_BUILD_FOLDER_BAK%
mv staging\usr installdir
md installdir\include\breakpad\client\windows
md installdir\include\breakpad\client\windows\common
md installdir\include\breakpad\client\windows\crash_generation
md installdir\include\breakpad\client\windows\handler
md installdir\include\breakpad\client\windows\sender
md installdir\include\breakpad\common\windows
md installdir\include\breakpad\google_breapad\common
md installdir\include\breakpad\google_breapad\processor
md installdir\include\breakpad\processor
xcopy src\client\windows\common\*.h installdir\include\breakpad\client\windows\common\ /y /e
xcopy src\client\windows\crash_generation\*.h installdir\include\breakpad\client\windows\crash_generation\ /y /e
xcopy src\client\windows\handler\*.h installdir\include\breakpad\client\windows\handler\ /y /e
xcopy src\client\windows\sender\*.h installdir\include\breakpad\client\windows\sender\ /y /e
xcopy src\common\*.h installdir\include\breakpad\common\ /y /e
xcopy src\common\windows\*.h installdir\include\breakpad\common\windows\ /y /e
xcopy src\google_breakpad\common\*.h installdir\include\breakpad\google_breakpad\common\ /y /e
xcopy src\google_breakpad\processor\*.h installdir\include\breakpad\google_breakpad\processor\ /y /e
xcopy src\processor\*.h installdir\include\breakpad\processor\ /y /e
REM Finalization
cd c:\dev\breakpad\installdir\bin
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/minidump_stackwalk.exe -o minidump_stackwalk.exe
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/cygwin1.dll -o cygwin1.dll
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/cygstdc++-6.dll -o cygstdc++-6.dll
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/cyggcc_s-1.dll -o cyggcc_s-1.dll
cd ..
7z a breakpad-mingw530_x86.zip *
mv breakpad-mingw530_x86.zip %APPVEYOR_BUILD_FOLDER%
