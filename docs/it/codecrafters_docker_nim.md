---
layout: default
title: CodeCraftersでNimを使ってDockerを作ってみた
nav_order: 2
parent: IT
---


[CodeCrafters](https://codecrafters.io/)というプログラミング学習サービスの「Build your own Docker」というコースを Nim 言語でやってみた。

単にNimの書き方を学習するだけではなく、Dockerイメージや、chroot・PID名前空間について学ぶことができたので、とても勉強になった。

## きっかけ

こちらのツイートを見て CodeCrafters を知った。

**ツイートの引用**

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">教育オタクなのでプログラミング学習サービスは大体知ってるんだけど、最近で一番いいなと思った。<a href="https://t.co/ioFOAjoUIM">https://t.co/ioFOAjoUIM</a><br>- Redis, Git, Dockerの再実装など少し複雑なソフトウェアを自作する課題<br>- 名だたる企業のエンジニアが作ったカリキュラムでベストプラクティスも学べる<br>- C/Rust/Goも使える <a href="https://t.co/cIXem7KJkp">pic.twitter.com/cIXem7KJkp</a></p>&mdash; Yu Fukuyama (@yuskefukuyama) <a href="https://twitter.com/yuskefukuyama/status/1610591440404643845?ref_src=twsrc%5Etfw">January 4, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Build your own Docker コース

**注記**  
・2023年1月時点でNim言語で始められるのはこのコースだけ（かつβ版）。  
・Nim v1.0.6 を想定したコースとなっている。


「Build your own Docker」コースの概要は以下の通り。

![「Build your own Docker」コース概要]({% link docs/it/assets/codecrafters_docker_about.png %})


```
（拙訳）
Dockerイメージとは何なのか、Dockerレジストリにどのように保存されているかを学習します。
Nimでのシステムプログラミングに触れ、chrootやカーネル名前空間について学習します。
```

このコースは6のステージで構成されていて、各ステージで与えられた課題に沿ってプログラムを作成するというもの。
作ったプログラムを `git push` すると自動でテストが実行され、テストを通過すると次のステージに進める。

今回作成したプログラムはこちら。
[TakumiHANAUE/codecrafters-docker-nim](https://github.com/TakumiHANAUE/codecrafters-docker-nim/tree/master)


### ステージ1 : Execute a program

`docker run` コマンドみたいに、引数で受け取ったコマンドを実行するプログラムを作るという課題。  
作成するプログラム名を `myprogram` としたとき、`myprogram echo Hello` と実行すると、`echo Hello` を実行するプログラムを作成する。

引数の取得には [commandLineParams()](https://nim-lang.org/1.0.6/os.html#commandLineParams) を使用した。
引数のコマンド実行に使えそうな関数を [osproc](https://nim-lang.org/1.0.6/osproc.html) ライブラリから探し、最終的に [execProcess()](https://nim-lang.org/1.0.6/osproc.html#execProcess%2Cstring%2Cstring%2CopenArray%5Bstring%5D%2CStringTableRef%2Cset%5BProcessOption%5D) を使うことにした。

### ステージ2 : Wireup stdout & stderr

実行したコマンドの標準出力／標準エラー出力を、コマンドを実行した元プロセスで表示するように変更する課題。

標準出力／標準エラー出力ってそういえば何だっけ？状態だったのでそのあたりを調べるところから取り組んだ。

コマンド実行には [execCmd()](https://nim-lang.org/1.0.6/osproc.html#execCmd%2Cstring) を使用した。
[execCmd()](https://nim-lang.org/1.0.6/osproc.html#execCmd%2Cstring) は標準入力／標準出力／標準エラー出力を呼び出し元プロセスから継承する関数となっていて、この課題にぴったりだった。

### ステージ3 : Handle exit codes

実行したコマンドの終了コードをコマンドを実行した元プロセスに渡す課題。
`myprogram echo Hello` を実行したとき、`echo Hello` の終了コードが、`myprogram echo Hello` の終了コードとなるようにする。

ステージ2で使用した [execCmd()](https://nim-lang.org/1.0.6/osproc.html#execCmd%2Cstring) は実行したコマンドの終了コードを返却するので、その返却値を利用することができた。

### ステージ4 : Filesystem isolation

実行するコマンドが他のファイルにアクセスできないように、コマンドを実行するディレクトリをrootディレクトリに変更する課題。
`chroot`コマンドを使用することで、任意のディレクトリを新たなrootディレクトリとして隔離することができる。
コマンドを実行する環境を他のファイル／ディレクトリから隔離することで、周囲のファイルに影響を及ぼすことなく安全にコマンドを実行できる。

rootって一つじゃないの？変えるってどういうこと？という状態だったので、「chrootとは何か」から調べる必要があり大変だった。

やるべき処理の概要は以下の通り。
1. コマンド実行用ディレクトリを作る
1. コマンド実行に必要なファイルをコマンド実行用ディレクトリにコピーする
1. コマンド実行用ディレクトリを root に変更する
1. コマンドを実行する

特に「コマンド実行に必要なファイルをコマンド実行用ディレクトリにコピーする」を、はじめは考えることができていなかった。
chrootしたあとにコマンドを実行しようとしたら、そのコマンド自体を参照することができずに失敗した。
chrootしたのだから、新たなrootから外のディレクトリを参照できないのは当たり前（そのための chroot）で、「なるほど、隔離するってこういうことか」と身をもって理解することができた。

chrootに対応する関数はNimには標準で用意されていないので [chdir](https://nim-lang.org/1.0.6/posix.html#chdir%2Ccstring) のように `importc`プラグマを使用してchroot関数を定義する必要がある。

### ステージ5 : Process isolation

実行するコマンドを新たなプロセスツリーで実行する課題。
呼出し元とは異なるPID名前空間でコマンドを実行するというもの。
プロセスツリーを隔離しないと、呼び出し元などにシグナルを送ることで悪さをすることができてしまう。

PID名前空間？何それ？状態だったので、まずはそのあたりの勉強から始めたのでとても時間がかかった。
以下のページを参考にした。

- [Linux の PID Namespace について](https://blog.amedama.jp/entry/linux-pid-namespace_1)
- [NAMESPACES : Linux Programmer's Manual (7)](https://linuxjm.osdn.jp/html/LDP_man-pages/man7/namespaces.7.html)

新しい名前空間でコマンドを実行するために [unshare()](https://linuxjm.osdn.jp/html/LDP_man-pages/man2/unshare.2.html) を使用した。


### ステージ6 : Fetch an image from the Docker Registry

実際にDockerイメージをpullしてきて、コマンドを実行するという課題。
Docker registry API を使って公式イメージをpullし、そのイメージを使ってコマンドを実行する。

やることは以下の3ステップ。

1. 認証のためのTokenを取得する
1. イメージマニフェストを取得する
1. イメージを取得して展開する

この課題では HTTPリクエスト として Docker registry API を実行するが、例によってHTTPリクエスト何それ？状態だったので、まずはその勉強から。
さらに [Tokenの取得の仕方](https://docs.docker.com/registry/spec/auth/token/)、[Docker Registry HTTP API](https://docs.docker.com/registry/spec/api/) の使い方など、Docker の公式ドキュメントを読む必要があった。  
HTTPリクエスト何それ？状態 ＋ 英語のドキュメントだったので、概要をつかむまでにかなり時間がかかった。

[練習用に作った別リポジトリ](https://github.com/TakumiHANAUE/practiceNim/tree/main/getDockerImage)で、Docker registry API を使い方を確認してからこのステージに取り組んだ。


## やってみた感想

自分が普段使っている Docker を実際に作ってみるというのは楽しかった。  
作ったのはプログラムは、イメージをpullしてコマンドを実行する というだけのものだが、それでも実際に動いたときは嬉しかった。
「Dockerってすごいな、作ってくれてありがとう！」という気持ちにもなった。

関連技術・概念についても学ぶことができた点が良かった。  
課題を解くには、chroot や PID名前空間、 Docker Registry HTTP API など言語の書き方以外の知識も同時に必要だった。
これらを学んでいる間は課題が進まず、もどかしい部分もあったが、学んだことをすぐに課題に生かすことができるのでとても良かった。

他言語での解法を参考にできる点も良かった。  
CodeCraftersは他の言語で解いた人のプログラムを見ることができるので、どうやってプログラムを書いたら良いか分からず手が止まった時は、他の言語での解法を参考にさせてもらった。
あえてあまり触れたことのない言語の解法をみて、やるべき処理をなんとなく理解したあと、じゃあNimでどう書こうかということを考えた。
同じ言語の解法を見てしまうと、どうしても自分で解いた感が薄れてしまうが、その辺を防ぎつつ課題を進めることができる点が自分に合っていた。
