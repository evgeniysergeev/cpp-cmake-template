pushd ..\..

cmake ^
  -G "Visual Studio 17 2022" ^
  -B .\build ^
  .

popd
