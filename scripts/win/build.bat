pushd ..\..

cmake ^
  --build .\build ^
  --parallel %NUMBER_OF_PROCESSORS%

popd
