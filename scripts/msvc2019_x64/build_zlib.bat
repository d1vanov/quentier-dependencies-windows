cd c:\dev
echo "Building zlib"
git clone https://github.com/kiyolee/zlib-win-build.git zlib-win-build
cd zlib-win-build
cd build-VS2019
msbuild zlib.sln /p:Configuration="Release" /p:Platform="x64" /clp:ErrorsOnly
md installdir
md installdir\include
md installdir\bin
md installdir\lib
copy x64\Release\libz.dll installdir\bin\libz.dll
copy x64\Release\libz.lib installdir\lib\libz.lib
copy ..\zlib.h installdir\include
copy ..\zconf.h installdir\include
cd installdir
7z a zlib-1.2.11-msvc2019_x64.zip *
mv zlib-1.2.11-msvc2019_x64.zip %APPVEYOR_BUILD_FOLDER%
