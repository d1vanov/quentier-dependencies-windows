echo "Building boost"
cd c:\dev
curl -fsSL https://dl.bintray.com/boostorg/release/1.65.0/source/boost_1_65_0.7z -o boost_1_65_0.7z
7z x boost_1_65_0.7z
cd boost_1_65_0
if %build_tool%==mingw bootstrap.bat gcc
if not %build_tool%==mingw bootstrap.bat
set PATH=%cd%;%PATH%
.\b2 --build-dir=%cd%\%BOOSTBUILDDIR% --with-program_options toolset=%BOOSTTOOLCHAIN% link=shared address-model=%BOOSTADDRESSMODE% runtime-link=shared variant=release,debug --build-type=complete stage >NUL
REM Rearrange the location of some stuff within the installation dir
cd stage
md include\boost
xcopy c:\dev\boost_1_65_0\boost include\boost /e >NUL
md bin
move lib\*.dll bin\
set PATH=%cd%\bin;%PATH%
set LIB=%cd%\lib;%LIB%
set INCLUDE=%cd%\include;%INCLUDE%
REM Finalization
7z a boost-1_65_0-%build_suite%_%arch_name%.zip *
mv boost-1_65_0-%build_suite%_%arch_name%.zip %APPVEYOR_BUILD_FOLDER%
