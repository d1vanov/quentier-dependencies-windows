cd c:\dev
echo "Building hunspell"
git clone https://github.com/hunspell/hunspell.git hunspell
cd c:\dev\hunspell
git checkout v1.7.0
md installdir
md installdir\include
md installdir\include\hunspell
md installdir\lib
md installdir\bin
msbuild %cd%\msvc\Hunspell.sln /p:Configuration="Release_dll" /p:Platform="Win32" /clp:ErrorsOnly
copy msvc\Release_dll\libhunspell\libhunspell.lib installdir\lib\
copy msvc\Release_dll\libhunspell\libhunspell.dll installdir\bin\
xcopy src\hunspell installdir\include\hunspell /e >NUL
REM Finalization
cd installdir
7z a libhunspell-1.7.0-msvc2017_x86.zip *
mv libhunspell-1.7.0-msvc2017_x86.zip %APPVEYOR_BUILD_FOLDER%
