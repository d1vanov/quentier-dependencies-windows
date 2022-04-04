cd c:\dev
echo "Building breakpad"
git clone https://chromium.googlesource.com/breakpad/breakpad
cd breakpad
git checkout chrome_90
cd src
git clone https://github.com/google/googletest.git testing
cd ..\..
git clone https://chromium.googlesource.com/external/gyp
cd gyp
git checkout 203fee270b606ad8e0e9c2d6314b59eb30369579
C:\msys64\usr\bin\bash -lc "cd /c/dev/gyp && sed '7 i import collections' pylib/gyp/generator/msvs.py && sed -i -e '200s/.*/folders = collections.OrderedDict()/' pylib/gyp/generator/msvs.py"
python setup.py install
cd ..\breakpad
md installdir
md installdir\include\breakpad\client\windows
md installdir\include\breakpad\common\windows
md installdir\lib
md installdir\bin
xcopy src installdir\include\breakpad /e /y >NUL
set GYP_MSVS_VERSION=2017
C:\msys64\usr\bin\bash -lc "cd /c/dev/breakpad/src/build && sed -i -e \"s/'WarnAsError': 'true'/'WarnAsError': 'false'/g\" common.gypi"
call ..\gyp\gyp.bat src\client\windows\breakpad_client.gyp --no-circular-check -Dwin_release_RuntimeLibrary=2 -Dwin_debug_RuntimeLibrary=3
cd src\client\windows
devenv /Upgrade breakpad_client.sln
if %build_suite%==msvc2019_32 msbuild breakpad_client.sln /p:Configuration="Release" /p:Platform="Win32" /clp:ErrorsOnly
if %build_suite%==msvc2019_32 msbuild breakpad_client.sln /p:Configuration="Debug" /p:Platform="Win32" /clp:ErrorsOnly
if %build_suite%==msvc2017_32 msbuild breakpad_client.sln /p:Configuration="Release" /p:Platform="Win32" /clp:ErrorsOnly
if %build_suite%==msvc2017_32 msbuild breakpad_client.sln /p:Configuration="Debug" /p:Platform="Win32" /clp:ErrorsOnly
if %build_suite%==msvc2019_64 msbuild breakpad_client.sln /p:Configuration="Release" /p:Platform="x64" /clp:ErrorsOnly
if %build_suite%==msvc2019_64 msbuild breakpad_client.sln /p:Configuration="Debug" /p:Platform="x64" /clp:ErrorsOnly
if %build_suite%==msvc2017_64 msbuild breakpad_client.sln /p:Configuration="Release" /p:Platform="x64" /clp:ErrorsOnly
if %build_suite%==msvc2017_64 msbuild breakpad_client.sln /p:Configuration="Debug" /p:Platform="x64" /clp:ErrorsOnly
copy Release\lib\common.lib c:\dev\breakpad\installdir\lib
copy Release\lib\crash_generation_client.lib c:\dev\breakpad\installdir\lib
copy Release\lib\crash_generation_server.lib c:\dev\breakpad\installdir\lib
copy Release\lib\exception_handler.lib c:\dev\breakpad\installdir\lib
copy Debug\lib\common.lib c:\dev\breakpad\installdir\lib\common_d.lib
copy Debug\lib\crash_generation_client.lib c:\dev\breakpad\installdir\lib\crash_generation_client_d.lib
copy Debug\lib\crash_generation_server.lib c:\dev\breakpad\installdir\lib\crash_generation_server_d.lib
copy Debug\lib\exception_handler.lib c:\dev\breakpad\installdir\lib\exception_handler_d.lib
copy Debug\common.pdb c:\dev\breakpad\installdir\bin\
copy Debug\crash_generation_client.pdb c:\dev\breakpad\installdir\bin\
copy Debug\crash_generation_server.pdb c:\dev\breakpad\installdir\bin\
copy Debug\exception_handler.pdb c:\dev\breakpad\installdir\bin\
cd c:\dev\breakpad
call ..\gyp\gyp.bat src\tools\windows\tools_windows.gyp --no-circular-check -Dwin_release_RuntimeLibrary=2 -Dwin_debug_RuntimeLibrary=3
cd src\tools\windows
devenv /Upgrade tools_windows.sln
if %build_tool%==msvc2019 set INCLUDE="C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\DIA SDK\include";%INCLUDE%
if %build_suite%==msvc2019_32 msbuild tools_windows.sln /p:Configuration="Release" /p:Platform="Win32" /clp:ErrorsOnly
if %build_suite%==msvc2019_64 msbuild tools_windows.sln /p:Configuration="Release" /p:Platform="x64"  /clp:ErrorsOnly
if %build_suite%==msvc2017_32 msbuild tools_windows.sln /p:Configuration="Release" /p:Platform="Win32" /clp:ErrorsOnly
if %build_suite%==msvc2017_64 msbuild tools_windows.sln /p:Configuration="Release" /p:Platform="x64"  /clp:ErrorsOnly
copy Release\dump_syms.exe c:\dev\breakpad\installdir\bin
REM Finalization
cd c:\dev\breakpad\installdir\bin
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/minidump_stackwalk.exe -o minidump_stackwalk.exe
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/cygwin1.dll -o cygwin1.dll
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/cygstdc++-6.dll -o cygstdc++-6.dll
curl -fsSL http://hg.mozilla.org/build/tools/raw-file/755e58ebc9d4/breakpad/win32/cyggcc_s-1.dll -o cyggcc_s-1.dll
cd ..
7z a breakpad-%build_tool%_%arch_name%.zip *
mv breakpad-%build_tool%_%arch_name%.zip %APPVEYOR_BUILD_FOLDER%
