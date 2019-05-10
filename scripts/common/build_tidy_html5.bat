cd c:\dev
echo "Building tidy-html5"
git clone https://github.com/htacg/tidy-html5.git
cd tidy-html5
git checkout 5.6.0
md build-tidy
cd build-tidy
if %build_tool%==mingw set PATH=%PATH:C:\Program Files\Git\usr\bin;=%
if not %build_tool%==mingw C:\msys64\usr\bin\bash -lc "cd /c/dev/tidy-html5 && echo 'install(FILES $<TARGET_PDB_FILE:${name}> DESTINATION bin OPTIONAL)' >> CMakeLists.txt"
cmake .. -G %MAKEFILES% -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_SHARED_LIB=ON -DCMAKE_INSTALL_PREFIX="c:\dev\tidy-html5\build-tidy\installdir"
cmake --build . --target all
cmake --build . --target install
if not %build_tool%==mingw copy c:\dev\tidy-html5\build-tidy\CMakeFiles\tidy-static.dir\tidy-static.pdb c:\dev\tidy-html5\build-tidy\installdir\lib\
if %build_tool%==mingw set PATH=%PATH%;C:\Program Files\Git\usr\bin
REM Finalization
cd installdir
7z a tidy-html5-5.6.0-%build_suite%_%arch_name%.zip *
mv tidy-html5-5.6.0-%build_suite%_%arch_name%.zip %APPVEYOR_BUILD_FOLDER%
