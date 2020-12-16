cd c:\dev
echo "Building qtkeychain"
git clone https://github.com/frankosterfeld/qtkeychain.git
cd c:\dev\qtkeychain
git checkout v0.9.1
md build
cd build
C:\msys64\usr\bin\bash -lc "cd /c/dev/qtkeychain && echo 'install(FILES $<TARGET_PDB_FILE:${QTKEYCHAIN_TARGET_NAME}> DESTINATION bin OPTIONAL)' >> CMakeLists.txt"
cmake .. -G %MAKEFILES% -DCMAKE_BUILD_TYPE=RelWithDebInfo -DUSE_CREDENTIAL_STORE=OFF -DBUILD_TEST_APPLICATION=OFF -DCMAKE_INSTALL_PREFIX="c:\dev\qtkeychain\build\installdir" -DCMAKE_PREFIX_PATH="C:/Qt/5.13/%qt%" -DCMAKE_CXX_FLAGS="/wd4365 /wd4464 /wd4571 /wd4577 /wd4619 /wd4625 /wd4626 /wd4668 /wd4710 /wd4774 /wd4820 /wd4946 /wd5026 /wd5027 /wd5045 /wd5219"
cmake --build . --target all
cmake --build . --target install
REM Finalization
cd installdir
7z a qtkeychain-0.9.1-%build_tool%_%arch_name%.zip *
mv qtkeychain-0.9.1-%build_tool%_%arch_name%.zip %APPVEYOR_BUILD_FOLDER%
