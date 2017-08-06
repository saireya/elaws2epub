#!/bin/sh
# 一時ディレクトリを作成
mkdir $1-epub
cd $1-epub

# eLaws XMLをHTMLBookへ変換
xsltproc --noout ../$1 -o $1.html
if [ $? != 0 ]; then
	exit 1
fi
# XSLTでは不可能な変換を実施
python3 ../elawstidy.py < $1.html > $1.tidy.html
if [ $? != 0 ]; then
	exit 1
fi
# XMLを整形
XMLLINT_INDENT=$' ' xmllint --format --encode utf-8 $1.tidy.html -o $1.lint.html
if [ $? != 0 ]; then
	exit 1
fi

# HTMLBookでePubの元データを生成
# HTMLBookのパス: 絶対パスで記述するほうが無難
HTMLBook=../HTMLBook
mkdir OEBPS
# HTMLBookのCSSをそのまま使う場合
# cp ../$HTMLBook/stylesheets/epub/epub.css OEBPS/
cp ../elaws.css OEBPS/epub.css
xsltproc $HTMLBook/htmlbook-xsl/epub.xsl $1.lint.html
if [ $? != 0 ]; then
	exit 1
fi
# 圧縮してePubを生成
zip -0 -X ../$1.epub mimetype
zip -r ../$1.epub META-INF/ OEBPS/
cd ..

# kindlegenがあればePubからmobiを生成
KINDLEGEN=.
$KINDLEGEN/kindlegen $1.epub -o $1.mobi
