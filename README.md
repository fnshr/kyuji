# kyuji
Data for processing Japanese kyūji-tai（旧字体）

## `shinji2kyuji.pl`
`shinji2kyuji.pl` is a Perl script which converts Japanese shinji-tai（新字体） to kyūji-tai（旧字体） for upLaTeX typesetting.

`shinji2kyuji.pl` は、upLaTeX でのタイプセットのために、日本語の新字体を旧字体に変換する Perl スクリプトです。

One shinji-tai may correspond to several kyūji-tai (e.g. 弁 corresponds to 辨, 辯, and 瓣), but only one kyūji-tai is link to one shinji-tai.

いくつかの漢字については、新字に対応する旧字が複数ある場合がありますが、ここでは1つの旧字にしか対応付けていません。例えば、「弁」に対応する旧字として、「辨・辯・瓣」がありますが、ここではとりあえず「辯」にしか変換されません。


### usage / 使用法

```
perl shinji2kyuji.pl input.tex > output.tex 
```

