echo "Building boost"
cd c:\dev
curl -fsSL https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.7z -o boost_1_70_0.7z
7z x boost_1_70_0.7z
cd boost_1_70_0
if %build_tool%==mingw530 call bootstrap.bat gcc
if not %build_tool%==mingw530 call bootstrap.bat
.\b2 --build-dir=%cd%\%BOOSTBUILDDIR% --with-program_options toolset=%BOOSTTOOLCHAIN% link=shared address-model=%BOOSTADDRESSMODE% runtime-link=shared variant=release,debug --build-type=complete stage >NUL
REM Rearrange the location of some stuff within the installation dir
cd stage
md include\boost
xcopy c:\dev\boost_1_70_0\boost include\boost /e /y >NUL
md bin
move lib\*.dll bin\
REM Finalization
7z a boost-1_70_0-%build_tool%_%arch_name%.zip *
mv boost-1_70_0-%build_tool%_%arch_name%.zip %APPVEYOR_BUILD_FOLDER%
