#!/bin/sh

function convertDir() {
	mkdir "$1"
    for file in ./*
	do
	if test -f $file
	then
	    if [ "${file##*.}" = "xsd" ]
	    then
	    	"${0%/*}"/SchemaToBean "${PWD}"/"${file##*/}" -out="$1"
	    fi
	fi
	if test -d $file
	then
	    cd "$file"
	    convertDir "$1"/"${file##*/}"
	    cd ..
	fi
	done
}

cd "${0%/*}"
rm -drf ./beans
cd ./source
convertDir "${0%/*}"/beans
echo success




