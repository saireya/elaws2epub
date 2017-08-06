#!/usr/bin/env python3
# -*- coding: utf-8 -*-

def convert(xml):
	import re
	# xsltprocで生成される不完全なmetaタグをxhtml5対応に変形
	xml = xml.replace(' charset=utf-8">', ' charset=utf-8"/>')
	# ItemのXSLT操作で生成される連続するulタグを集約
	xml = xml.replace('</ul>\n<ul>', '\n')
	# 括弧()内を脚注(footnote)に(ネストする場合があるので3回置き換え)
	xml = re.sub(r"（([^（）「]+。)）", r'<span data-type="footnote">\1</span>', xml)
	xml = re.sub(r"（([^（）「]+。)）", r'<span data-type="footnote">\1</span>', xml)
	xml = re.sub(r"（([^（）「]+。)）", r'<span data-type="footnote">\1</span>', xml)
	# 脚注以外の括弧()内を小さく表示(ネストする場合があるので3回置き換え)
	xml = re.sub(r"（([^（）<]+)）", r'<small>(\1)</small>', xml)
	xml = re.sub(r"（([^（）<]+)）", r'<small>(\1)</small>', xml)
	xml = re.sub(r"（([^（）<]+)）", r'<small>(\1)</small>', xml)
	# カギ括弧「」を強調(strong)し索引に追加
	xml = re.sub(r"「([^\(」、。]{,20})」", r'「<strong>\1</strong><a data-type="indexterm" data-primary="\1"/>」', xml)
	# 全角空白を半角に
	xml = xml.replace('　', ' ')
	# TODO
	# 「第x条」をリンクに(他法が含まれてしまう)
	# 漢数字を半角数字に
	return xml

if __name__ == "__main__":
	import sys
	inputxml = sys.stdin.read()
	outputxml = convert(inputxml)
	print(outputxml)
