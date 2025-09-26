#!/usr/bin/bash

# v2
# Original author: Christian Sacks
# https://github.com/christiansacks/tqwnet_nodelist/


ORIGDIR=$PWD
IWORKDIR="$HOME/git/ghostnet/ftn/nodelist"
IPACKDIR="$HOME/git/ghostnet/ftn/infopack"
WORKDIR="${1:-$IWORKDIR}"
PACKDIR="${2:-$IPACKDIR}"

COMMIT="Post compile auto-commit: $(date "+%Y-%m-%d %H:%M:%S")"

echo "*** DID YOU SAVE AND COMMIT YOUR CHANGES TO BOTH $WORKDIR AND $PACKDIR? ***"
for i in {5..1}; do
  echo -n "$i... "
  sleep 1
done
echo "0. Times up!"

# Ensure directories exist
if [ ! -d "$WORKDIR" ] || [ ! -d "$PACKDIR" ]; then
  echo "Error: $WORKDIR or $PACKDIR does not exist."
  exit 1
fi

cd "$WORKDIR" || exit
git pull || { echo "Failed to pull $WORKDIR"; exit 1; }

echo "Compiling nodelist..."
if ! ./makenl -d nodelist.txt >/dev/null; then
  echo "Error compiling nodelist."
  exit 1
fi

absfile=$(ls -rt outfile/ghostftn.[0-9]* 2>/dev/null | tail -1)
if [ -z "$absfile" ]; then
  echo "No nodelist output file found."
  exit 1
fi

file=$(basename "$absfile")
ext=$(echo "$file" | awk -F. '{ print $2 }')
newext="z${ext:1:2}"

echo "Creating zip archive ghostftn.$newext..."
[ -f "zip/ghostftn.$newext" ] && mv "zip/ghostftn.$newext" "zip/ghostftn.$newext.$(date +%Y%m%d)"
zip -j9 "zip/ghostftn.$newext" "$absfile" || { echo "Failed to create zip."; exit 1; }

git add . -A
git commit -m "$COMMIT"
git push

cd "$PACKDIR" || exit
echo "Now in $PACKDIR directory..."

git pull || { echo "Failed to pull $PACKDIR"; exit 1; }

echo "Removing old files..."
rm -f ghostftn.z* ghostftninfo.zip

if [ ! -f "$WORKDIR/zip/ghostftn.$newext" ]; then
  echo "File $WORKDIR/zip/ghostftn.$newext does not exist."
  exit 1
fi

echo "Copying $WORKDIR/zip/ghostftn.$newext to $PACKDIR..."
cp "$WORKDIR/zip/ghostftn.$newext" "$PACKDIR/"

echo "Creating zip archive ghostftninfo.zip..."
zip -j9 ghostftninfo.zip ./* || { echo "Failed to create ghostftninfo.zip."; exit 1; }

git add . -A
git commit -m "$COMMIT"
git push

cd "$ORIGDIR" || exit
echo "Done."
