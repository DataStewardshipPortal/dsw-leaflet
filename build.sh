#!/bin/bash
# Suggested distro: Ubuntu/Debian
# Dependencies: wget, inkscape, pdftk
# Marek Suchanek @ 2018
if [ -z "$1" ]; then
	echo "Specify the name of output file as argument"
	exit 1
fi

FINAL=$1
PROJECT_ROOT=$(pwd)

echo "------------------------------------------------"
echo "Installing fonts"
mkdir ~/.fonts 2> /dev/null
cd ~/.fonts
wget -q https://www.wfonts.com/download/data/2014/11/28/corbel/corbel.zip
unzip -o corbel.zip
wget -q https://www.wfonts.com/download/data/2014/05/29/impact/impact.zip
unzip -o impact.zip

cd $PROJECT_ROOT

echo "------------------------------------------------"
echo "Building $FINAL"
mkdir -p _build/parts 2>/dev/null
for SVG_FILE in $(ls *.svg);
	do
		PDF_FILE=$(echo $SVG_FILE | sed 's/\.svg$/\.pdf/')
		inkscape $SVG_FILE --export-pdf=_build/parts/$PDF_FILE
done
pdftk $(ls _build/parts/*.pdf) cat output _build/$FINAL

echo "------------------------------------------------"
