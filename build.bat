pushd %~dp0

7z u -tzip qemistry.mpackage^
 *.lua -r^
 qemistry.trigger^
 license.txt

mkdir f:\projects\dev\doc\github.com\oneymus\qemistry\doc
ldoc ./ -p Qemistry -d f:\projects\dev\doc\github.com\oneymus\qemistry\doc

popd
