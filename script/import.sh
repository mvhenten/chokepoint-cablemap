#!/bin/sh

if [ "$#" -eq 0 ];then
    echo "Usage: ./import.sh <filename>"
    exit 1
fi

SOURCE=`realpath $1`
TARGET=`realpath $(pwd)`/json
CWD=`pwd`
TMP_DIR=_tmp
PRETTYFY=$CWD/node_modules/js-beautify/js/bin/js-beautify.js

rm -rf $TARGET
rm -rf $TMP_DIR
mkdir $TMP_DIR
mkdir $TARGET

cd $TMP_DIR
unzip $SOURCE

SHAPE_FILES=`find . -name "*.shp"| sed -E "s/\.\/(\w+).shp/\1/g"`

for i in $SHAPE_FILES;
do
    zip $i.zip $i.*;
    $CWD/bin/shp2json.js $i.zip | $PRETTYFY -f - > $TARGET/$i.json;
done;

