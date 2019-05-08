echo "Building boost for msvc2015 x86"
set BOOSTBUILDDIR=msvc_builddir
set BOOSTTOOLCHAIN=msvc-14.0
set BOOSTADDRESSMODE=32
..\common\build_boost.bat
