cd c:\dev
echo "Building libiconv"
git clone https://github.com/kiyolee/libiconv-win-build.git libiconv-win-build
cd libiconv-win-build
cd build-VS2019
msbuild libiconv.sln /p:Configuration="Release" /p:Platform="Win32" /clp:ErrorsOnly
md installdir
md installdir\bin
md installdir\lib
md installdir\include
copy Release\libiconv.dll installdir\bin\libiconv.dll
copy Release\libiconv.pdb installdir\bin\libiconv.pdb
copy Release\libiconv.lib installdir\lib\libiconv.lib
copy ..\include\iconv.h installdir\include
REM Finalization
cd installdir
7z a libiconv-1.15-msvc2019_x86.zip *
mv libiconv-1.15-msvc2019_x86.zip %APPVEYOR_BUILD_FOLDER%
