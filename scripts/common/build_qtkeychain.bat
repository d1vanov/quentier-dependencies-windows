cd c:\dev
echo "Building qtkeychain"
git clone https://github.com/frankosterfeld/qtkeychain.git
cd c:\dev\qtkeychain
git checkout v0.9.1
if %build_tool%==mingw C:\msys64\usr\bin\bash -lc "cd /c/dev/qtkeychain && sed -i s/SecureZeroMemory/ZeroMemory/g keychain_win.cpp"
md build
cd build
if %build_tool%==mingw set PATH=%PATH:C:\Program Files\Git\usr\bin;=%
if not %build_tool%==mingw C:\msys64\usr\bin\bash -lc "cd /c/dev/qtkeychain && echo 'install(FILES $<TARGET_PDB_FILE:${QTKEYCHAIN_TARGET_NAME}> DESTINATION bin OPTIONAL)' >> CMakeLists.txt"
if not %build_tool%==mingw cmake .. -G %MAKEFILES% -DCMAKE_BUILD_TYPE=RelWithDebInfo -DUSE_CREDENTIAL_STORE=OFF -DBUILD_TEST_APPLICATION=OFF -DCMAKE_INSTALL_PREFIX="c:\dev\qtkeychain\build\installdir" -DCMAKE_PREFIX_PATH="C:/Qt/5.10/%qt%" -DCMAKE_CXX_FLAGS="/wd4365 /wd4464 /wd4571 /wd4577 /wd4619 /wd4625 /wd4626 /wd4668 /wd4710 /wd4774 /wd4820 /wd4946 /wd5026 /wd5027"
if %build_tool%==mingw cmake .. -G %MAKEFILES% -DCMAKE_BUILD_TYPE=RelWithDebInfo -DUSE_CREDENTIAL_STORE=OFF -DBUILD_TEST_APPLICATION=OFF -DCMAKE_INSTALL_PREFIX="c:\dev\qtkeychain\build\installdir" -DCMAKE_PREFIX_PATH="C:/Qt/5.5/%qt%"
cmake --build . --target all
cmake --build . --target install
if %build_tool%==mingw set PATH=%PATH%;C:\Program Files\Git\usr\bin
REM Finalization
cd installdir
7z a qtkeychain-0.9.1-%build_suite%_%arch_name%.zip *
mv qtkeychain-0.9.1-%build_suite%_%arch_name%.zip %APPVEYOR_BUILD_FOLDER%
