# eLaws2ePub
## About (概要)
[e-Gov法令検索](http://elaws.e-gov.go.jp)で公開されている法令のXMLデータから電子書籍を生成し、Kindleなどの *電子書籍リーダ* やMicrosoft Edgeなどの *ePub対応ブラウザ* で閲覧できるようにするスクリプトです。

- 総務省e-Lawsの **[法令標準XMLスキーマ](http://search.e-gov.go.jp/servlet/Public?CLASSNAME=PCMMSTDETAIL&id=145208896)** に準拠したXMLが対象です。
- 頻用の要素以外はほぼ未テストなので、不具合がある可能性が高いです。

## Requirements (準備)
Linux環境で動作検証していますが、Windows環境でもxsltproc, Python3やkindlegenのWindows版を用意すれば、大体同じ流れで使えるはずです。

### LibXSLT
主にXSLTで記述されているため、 **[Libxslt](http://xmlsoft.org)** に含まれるxsltprocやxmllintが必要です。

### HTMLBook
GitHubより、O'reillyが公開している **[HTMLBook](https://github.com/oreillymedia/HTMLBook)** を入手します。

```git checkout https://github.com/oreillymedia/HTMLBook.git```

### Python3
一部の機能やレイアウトの調整を行うelawstidy.pyを動かすには、 **Python3** が必要です。

### kindlegen
ePubからKindleで読めるmobi形式に変換するには、Amazonが公開している **[kindlegen](https://www.amazon.com/gp/feature.html?docId=1000765211)** が必要です。


## Usage (使い方)
### XMLファイルの入手
0. [e-Gov法令検索](http://elaws.e-gov.go.jp)の **「法令索引検索」** で法令の名称(e.g. 刑法)を入力します。
0. 「索引検索結果一覧画面」で目的の法令名をクリックします。
0. 法令の条文が表示されたら、ページ上部の **「XML形式ダウンロード」** をクリックし、書庫を展開してXMLファイル(e.g. 140AC0000000045_20160623.xml)を入手します。

### elaws2epub.shの編集/実行
**elaws2epub.sh** (シェルスクリプト)を環境に合わせて編集してください。

0. HTMLBook, kindlegen(必要な場合)のパスを手元の環境に合わせてください。
0. Windows環境の場合は手作業でコマンドを実行してください。
0. elawstidy.py, kindlegenが不要な場合はコメントアウトしてください。
0. *elaws2epub.shを実行* すると、ePubやmobiが生成されます。

```./elaws2epub.sh 140AC0000000045_20160623.xml```

## Support/Contact
XSLTなどはPublic domainとしますが、不具合などがあればIssuesへ投げてください。

## Acknowledgements
- [HTMLBook Specification日本語訳 - JAGAT XMLパブリッシング準研究会](http://jagat-xml-publishing-study-group.github.io/HTMLBook-JA)
- [オライリーが公開しているHTMLBookでEPUBはつくれるのか - 買い物ログ別館](https://skoji.jp/blog/2014/03/htmlbookepub.html)
