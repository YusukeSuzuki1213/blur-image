# Usage: sh convert.sh [dir] [blur]
#
# Arguments:
#   dir    directory e.g, `~/WorkSpace/hoge/`
#   blur   radius x sigma e.g, `10x10`

set -e

if [ $# != 2 ]; then
  echo "引数を確認してください" 1>&2
  exit 1
fi

DIR=$1
BLUR=$2

# png -> jpg
for file in `\find $DIR -maxdepth 1 -name '*.png'`;
do
    convert $file -quality 100 ${file%.png}.jpg
    # rm -rf $file
done

# mkdir
OUTPUT_DIR=${DIR%/}/output
mkdir -p $OUTPUT_DIR

# blur
for file in `\find $DIR -maxdepth 1 -name *.jpg -o -name *.jpeg -o -name *.jpe`
do
    convert $file -blur $BLUR ${OUTPUT_DIR}/${file##*/}
done
