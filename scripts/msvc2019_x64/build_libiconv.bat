cd c:\dev
echo "Building libiconv"
REM MSVC branch
git clone https://github.com/kiyolee/libiconv-win-build.git libiconv-win-build
cd libiconv-win-build
cd build-VS2019
msbuild libiconv.sln /p:Configuration="Release" /p:Platform="x64" /clp:ErrorsOnly
md installdir
md installdir\bin
md installdir\lib
md installdir\include
copy x64\Release\libiconv.dll installdir\bin\libiconv.dll
copy x64\Release\libiconv.pdb installdir\bin\libiconv.pdb
copy x64\Release\libiconv.lib installdir\lib\libiconv.lib
copy ..\include\iconv.h installdir\include
REM Finalization
cd installdir
7z a libiconv-1.15-msvc2019_x64.zip *
mv libiconv-1.15-msvc2019_x64.zip %APPVEYOR_BUILD_FOLDER%
