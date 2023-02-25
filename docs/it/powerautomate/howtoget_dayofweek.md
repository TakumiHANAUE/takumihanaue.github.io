---
layout: default
title: 曜日を使用する
nav_order: 1
parent: Microsoft Power Automate
grand_parent: IT
---

曜日の日本語表現（日～土）を変数に格納する。

始めに日時から曜日(整数値)を取得し、そのあと日本語表現（日～土）に変換する。

##  日付から曜日(整数値)を取得する

ここでは2つの方法を紹介する。
- インスタンスクラウドフローの"日付"を使用する方法
- utcNow()関数を使用する方法

### インスタンスクラウドフローの"日付"を使用する方法

始めに日時を取得する。

インスタンスクラウドフローを作成しているときは、フローが実行された **日付** を使用することができる。
![日付]({% link docs/it/powerautomate/assets/howtoget_dayofweek_02.png %})

次に **dayOfWeek()** 関数を使用して、日時を曜日(整数値)に変換する。
以下の手順で行う。

- **式** の **日時関数** から **dayOfWeek()** 関数を選択する。  
**dayOfWeek()** はデフォルトでは表示されていないので **もっと見る** をクリックして表示させる。  
<img src="{% link docs/it/powerautomate/assets/howtoget_dayofweek_03.png %}" width="40%" alt="曜日を取得">>
- **動的なコンテンツ** から先の手順で作成した「日付」変数を選択する。  
dayOfWeek()の括弧内に「日付」変数の値が入る。  
<img src="{% link docs/it/powerautomate/assets/howtoget_dayofweek_04.png %}" width="80%" alt="曜日を取得">>
- **OK** をクリックする。  
変数の「値」欄に関数の値が入力される。  
<img src="{% link docs/it/powerautomate/assets/howtoget_dayofweek_05.png %}" width="80%" alt="曜日を取得">>

以上の方法により、曜日に対応した0～6の整数を取得することができる。

|日|月|火|水|木|金|土|
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|0|1|2|3|4|5|6|

### utcNow()関数を使用する方法

**式** の **utcNow()** を使用すると、フローが実行された日時を取得することができる。
![utcNow]({% link docs/it/powerautomate/assets/howtoget_dayofweek_01.png %})

**utcNow()** で取得できるのはUTC（協定世界時）のため、日本時間に変換する必要がある。
UTCからの変換には **convertFromUtc()** 関数を使用する。
第1引数に **utcNow()** の値を格納した変数を、第2引数に `'Tokyo Standard Time'` を指定する。
![utcNow]({% link docs/it/powerautomate/assets/howtoget_dayofweek_06.png %})

その後、**dayOfWeek()** 関数を使用して曜日(整数値)を取得する。

## 曜日(整数値)を日～月に変換する

ここでは2つの方法を紹介する。
- スイッチを使用する方法
- アレイを使用する方法

### スイッチを使用する方法

日本語表現の曜日を入れるための変数を用意し、そのあと **スイッチ** ステップを追加する。

![曜日(日本語表現)変数]({% link docs/it/powerautomate/assets/howtoget_dayofweek_07.png %})

スイッチで判定する値として「曜日(整数値)」を選択し、曜日ごとに **ケース** を作成する。
**ケース** と **既定** の間にある`+`ボタンをクリックすることで別の **ケース** を追加することができる。
ここでは 日曜日 の例を示す。

日曜日は整数値で`0`で表されるため **次の値と等しい** 欄には `0` を入力する。
このケースの中に **変数の設定** アクションを追加し、日本語表現の曜日を入れるための変数 に `日` を設定する。
他の曜日についても同様に設定していく。

![曜日(日本語表現)スイッチ]({% link docs/it/powerautomate/assets/howtoget_dayofweek_08.png %})

### アレイを使用する方法

アレイを使って曜日(日本語表現)を取得する。

始めに日～土の曜日を格納したアレイを作成する。
アレイは`[]`記号で定義する。
アレイの各要素は`,`記号で区切る。
今回は日～土の文字が要素となるので、日～土の各文字を`""`で括り、 `["日", "月", "火", "水", "木", "金", "土"]` となる。  
![曜日アレイ]({% link docs/it/powerautomate/assets/howtoget_dayofweek_09.png %})

アレイに定義した各要素は `アレイ変数値[インデックス値]` として参照する。
インデックス値は0から始まる整数で、例えば、今回の例で`日`を参照したいときは `曜日アレイ変数値[0]` 、`水`を参照したいとき `曜日アレイ変数値[3]` となる。

先の手順で作成した「曜日(整数値)」を使用すると曜日(日本語表現)は以下のように参照できる。
```
variables('曜日アレイ')[variables('曜日(整数値)')]
```
`variables('曜日(整数値)')`には0～6のいずれかが入っているため、`[]`記号と合わせることでアレイ変数の要素を参照している。

![曜日_日本語表現]({% link docs/it/powerautomate/assets/howtoget_dayofweek_10.png %})


