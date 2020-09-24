[ja](./README.ja.md)

# JapaneseNames.Rate

Randomly obtain the full name of a Japanese person with SQLite3 (male / female ratio 1: 1)

# DEMO

```sh
$ run.sh
1	あさこ	そうすけ	旦来	壮亮	m
2	あさじま	れいか	朝島	鈴蘭	f
3	あみくら	まつり	網蔵	まつり	f
4	いがた	りか	伊形	梨和	f
5	いしたに	しずま	石谷	鎮麻	m
6	いそじま	よしひと	礒嶋	善人	m
7	いながわ	つぐみ	稲川	紬玖美	f
8	いりょうだ	このか	井料田	来遥	f
9	いんべ	ゆきな	斎部	悠綺奈	f
10	うきはし	みみか	浮橋	美実果	f
11	おおみさき	かいる	大岬	界瑠	m
12	おくじま	えれん	奥嶋	咲蓮	f
13	かわらい	せいや	河原井	晟耶	m
14	きすい	あやは	木須井	恵葉	f
15	きだち	みゆか	木立	実有佳	f
16	きんたか	しょうじ	金高	招二	m
17	くらいえ	たけお	倉家	丈夫	m
18	ぐんじょう	りいち	郡上	莉市	m
19	こいかわ	てんしょう	鯉川	天章	m
20	こもち	ありさ	小餅	有里彩	f
21	これのり	まさき	是則	正樹	m
22	ごろかわ	みこと	五郎川	望詞	f
23	さだて	えみな	左舘	咲奈	f
24	しおがま	しげのり	塩竃	茂記	m
25	しもくがき	ゆういち	下工垣	遊一	m
26	しもまき	まほ	下牧	真捗	f
27	すぎかわ	いちた	杉川	壱舵	m
28	たけなみ	けいすけ	武濤	恵佑	m
29	たてやま	げんと	竪山	弦兎	m
30	ちごどう	さおり	児堂	紗織	f
31	となき	りく	渡名喜	龍来	m
32	どえ	きよこ	土江	樹世子	f
33	なかやま	もか	名嘉山	文奏	f
34	はたしま	しょうき	畑島	昌葵	m
35	ひやま	ひろたか	比山	紘宗	m
36	ひらきざわ	れいな	開澤	礼奈	f
37	ふじしま	みれい	藤島	美澪	f
38	みの	ひまり	身野	妃万理	f
39	もりみや	ともや	森宮	朋矢	m
40	りゅうの	たけよし	龍野	竹義	m
```
```sh
$ time run.sh
...
real	0m0.656s
user	0m0.614s
sys	0m0.056s
```

# Features

* You can pass the number of outputs as the first argument

# Requirement

* <time datetime="2020-09-24T16:36:33+0900">2020-09-24</time>
* [Raspbierry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 4 Model B Rev 1.2
* [Raspbian](https://ja.wikipedia.org/wiki/Raspbian) buster 10.0 2019-09-26 <small>[setup](http://ytyaru.hatenablog.com/entry/2019/12/25/222222)</small>
* bash 5.0.3(1)-release
* SQLite 3.33.0 2020-08-14 13:23:32 fca8dc8b578f215a969cd899336378966156154710873e68b3d9ac5881b0ff3f

```sh
$ uname -a
Linux raspberrypi 4.19.97-v7l+ #1294 SMP Thu Jan 30 13:21:14 GMT 2020 armv7l GNU/Linux
```

# Installation

```sh
git clone https://github.com/ytyaru/Sqlite3.JapaneseNames.Rate.20200924163636
```

# Usage

```sh
cd Sqlite3.JapaneseNames.Rate.20200924163636/src
./run.sh
```

# Note

* Must be SQLite [3.25.0](https://sqlite.org/releaselog/3_25_0.html) or later
    * To use [Window Functions](https://sqlite.org/windowfunctions.html)

# Author

ytyaru

* [![github](http://www.google.com/s2/favicons?domain=github.com)](https://github.com/ytyaru "github")
* [![hatena](http://www.google.com/s2/favicons?domain=www.hatena.ne.jp)](http://ytyaru.hatenablog.com/ytyaru "hatena")
* [![mastodon](http://www.google.com/s2/favicons?domain=mstdn.jp)](https://mstdn.jp/web/accounts/233143 "mastdon")

# License

This software is CC0 licensed.

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.en)

