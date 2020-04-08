cd c:\dev
echo "Building libxml2"
git clone https://github.com/kiyolee/libxml2-win-build.git libxml2-win-build
cd libxml2-win-build
cd build-VS2019
REM Prepare libiconv build dependency
md libiconv
cd libiconv
7z x %APPVEYOR_BUILD_FOLDER%\libiconv-1.15-msvc2019_x64.zip
set PATH=%cd%\bin;%PATH%
set INCLUDE=%cd%\include;%INCLUDE%
set LIB=%cd%\lib;%LIB%
cd ..
REM Prepare zlib build dependency
md zlib
cd zlib
7z x %APPVEYOR_BUILD_FOLDER%\zlib-1.2.11-msvc2019_x64.zip
set PATH=%cd%\bin;%PATH%
set INCLUDE=%cd%\include;%INCLUDE%
set LIB=%cd%\lib;%LIB%
cd ..
REM Build
msbuild libxml2.sln /p:Configuration="Release" /p:Platform="x64" /clp:ErrorsOnly
md installdir
md installdir\include
md installdir\bin
md installdir\lib
copy x64\Release\libxml2.dll installdir\bin\libxml2.dll
copy x64\Release\libxml2.lib installdir\lib\libxml2.lib
xcopy ..\include installdir\include /e >NUL
REM Finalization
cd installdir
7z a libxml2-2.9.7-msvc2019_x64.zip *
mv libxml2-2.9.7-msvc2019_x64.zip %APPVEYOR_BUILD_FOLDER%
