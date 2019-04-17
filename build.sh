#!/bin/bash
# Suggested distro: Ubuntu/Debian
# Dependencies: wget, inkscape, pdftk
# Marek Suchanek @ 2019
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
wget -q https://dl.1001fonts.com/roboto.zip
unzip -o roboto.zip
rm -rf Roboto-Black.ttf Roboto-BlackItalic.ttf

cd $PROJECT_ROOT

echo "------------------------------------------------"
echo "Building $FINAL"
mkdir -p _build/parts 2>/dev/null
for SVG_FILE in $(ls *.svg);
	do
		PDF_FILE=$(echo $SVG_FILE | sed 's/\.svg$/\.pdf/')
		inkscape $SVG_FILE --export-area-page --export-dpi=300 --export-pdf=_build/parts/$PDF_FILE
done
pdftk $(ls _build/parts/*.pdf) cat output _build/$FINAL

echo "------------------------------------------------"
