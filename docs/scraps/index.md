---
layout: default
title: Scraps
nav_order: 80
has_children: true
---

ちょっとした作業記録やメモ

<details open markdown="block">
  <summary>
    目次
  </summary>
  {: .text-delta }
- TOC
{:toc}
</details>

# Jekyll : テーマの Override

参照 : [Overriding theme defaults](https://jekyllrb.com/docs/themes/#overriding-theme-defaults)

テーマの `_layouts` や `_include` のデフォルトファイルは `bundle info --path [theme name]` で表示されるパスに格納されている。

Jekyll は初めにプロジェクト直下の `/assets`, `/_layouts`, `/_include`, `/_sass` を参照し、そのあとテーマのデフォルトを参照する。

# プライベートな閉じた LAN を構築してみる

家に余っていた BUFFALO の古いルーターを使って自分用の閉じたネットワークを作ってみる。
古いルーターで脆弱性とか心配なので、インターネットには接続しない。

ルーターの設定で、デフォルトゲートウェイを設定しないことが重要。

**構成**

PC2 台をルーターに有線接続する。
また、インターネット接続はしない。

```
[Router] : Internet接続なし
 |
 |-- [Raspberry pi] : 192.168.XX.Y
 |
 `-- [ノートPC] : 192.168.XX.Z
```

## ルーター設定
{: .no_toc }

### ルーターのモード切り替え
{: .no_toc }

[こちらのページ](https://www.buffalo.jp/support/faq/detail/15920.html)に従い、ルーターのスイッチを切り替え、「ルーターモード固定」にする。

### IP アドレス等の設定
{: .no_toc }

ルーターの設定ページを開く(設定ページの開き方は機器に依る)。
私の使用したルーターの場合、[こちらのページ](https://www.buffalo.jp/support/faq/detail/15920.html) の「設定画面 2」の画面が開いた。

設定内容は以下の通り。

- Internet/LAN > Internet
  - IP アドレス取得方法
    ```
    手動設定
    IPアドレス : 1.1.1.1
    サブネットマスク : 255.255.255.0
    ```
- Internet/LAN > LAN
  - DHCP サーバー設定 [拡張設定]
    ```
    デフォルトゲートウェイの通知 : 通知しない
    DNSサーバーの通知 : 通知しない
    WNSサーバーの通知 : 通知しない
    ```
- 無線設定 > 基本(11n/g/b)
  ```
  無線機能 : 使用しない（"使用する"のチェック外す）
  ```

## 参考
{: .no_toc }

- [Windows で複数の LAN(NIC)を使う](https://jyn.jp/windows-multiple-nic/)
- [Wi-Fi ルーターをインターネットに接続せずにネットワークを構築したい](https://www.buffalo.jp/support/faq/detail/15920.html)

# PC 同士を LAN ケーブルで接続してみる

ノート PC と Raspberry pi を直接 LAN ケーブルで繋いで、Raspberry pi へ SSH できるようにしてみる。
LAN ケーブルは必ずクロスケーブルを使うこと。

```
 --- [ノートPC] : 192.168.XX.Y
 |
 | (LANクロスケーブル)
 |
 `-- [Raspberry pi] : 192.168.XX.Z
```

## 設定
{: .no_toc }

### ノート PC 側設定
{: .no_toc }

- ネットワークと共有センター > イーサネット > プロパティ を開く
- インターネット プロトコル バージョン 4 を選択し、プロパティを開き以下を設定する
  - 「次の IP アドレスを使う」を選択し、以下を入力
    ```
    IP アドレス : 192.168.XX.Y
    サブネット マスク : 255.255.255.0
    デフォルト ゲートウェイ : 空欄
    ```
  - 「次の DNS サーバーのアドレスを使う」を選択し、以下を入力
    ```
    有線 DNS サーバー : 空欄
    代替 DNS サーバー : 空欄
    ```

### Raspberry pi 側設定
{: .no_toc }

- デスクトップ上部のネットワークアイコンを右クリックし、Wireless & Wired Network Settings を開く
- Configure を interface eth0 にし、以下を設定する
  ```
  Automatically configure empty options : チェックを外す
  IPv4 Address : 192.168.XX.Z/24
  IPv6 Address : 空欄
  Router : 空欄
  DNS Servers : 空欄
  DNS Search : 空欄
  ```

## 参考
{: .no_toc }

- [Windows で複数の LAN(NIC)を使う](https://jyn.jp/windows-multiple-nic/)
- [ピアツーピアで RaspberryPi と PC を有線接続](https://db.danman.jp/access-p2p-raspberrypi/)

# C 言語 : 静的ライブラリと共有ライブラリ

## 静的ライブラリ(static library)
{: .no_toc }

リンク時に実行ファイルに同梱され、リンクされるライブラリ。

- 作り方  
  ar コマンドを使って静的ライブラリを作成する。

  ```
  $ ar rsv libXXXX.a AAA.o BBB.o
  ```

- 使い方  
  `-L`オプションでライブラリの場所を、`-l`オプションでライブラリ名を指定する。
  `libXXXX.a`が`./myllib`に置いてあるとすると
  ```
  $ gcc CCC.c -L./mylib -lXXXX
  ```
  ld コマンドでリンクだけするときも同じ
  ```
  $ ld DDD.o EEE.o -L./mylib -lXXXX
  ```

また、gcc, ld コマンド両方とも`-static`というオプションを使うと、共有ライブラリより静的ライブラリを優先する。
（同名の共有ライブラリがあったときに明示的に静的ライブラリを使うように指定するため？）

## 共有ライブラリ(shared library)
{: .no_toc }

リンクに必要な情報のみ実行ファイルに同梱され、実行時にリンクされるライブラリ。

- 作り方  
  `-shared`オプションを指定する。
  併せて`-fPIC`オプションを付けることが推奨されている。PIC は Position-Independent Code の略。

  ```
  $ gcc -shared -fPIC -o libXXXX.so AAA.c BBB.c
  ```

- 使い方
  `-L`オプションでライブラリの場所を、`-l`オプションでライブラリ名を指定する。
  `libXXXX.so`が`./myllib`に置いてあるとすると
  ```
  $ gcc CCC.c -L./mylib -lXXXX
  ```

【参考】

- [C: 静的ライブラリと共有ライブラリについて](https://blog.amedama.jp/entry/2016/05/29/222739)

# C 言語 : 可変長引数を持つ関数のラッピング

```c
#include <stdio.h>
#include <stdarg.h>

int mysprintf(char *s, const char *format, ...)
{
    va_list args;   // va_list型変数
    va_start(args, format); // va_list型変数をformatで初期化
    int ret = vsprintf(s, format, args);
    va_end(args);   // 可変長引数の処理を終える時に呼ぶ決まり
    return ret;
}
```

【参考】

- [標準ライブラリのリファレンス（ヘッダ別） stdargs.h](https://programming-place.net/ppp/contents/c/appendix/reference_header.html#stdarg)

# Docker コンテナの中で Docker を使用する

参考

- [コンテナからコンテナを操作する](https://blog.nijohando.jp/post/docker-in-docker-docker-outside-of-docker/)
- [Docker コンテナ内から Docker を使うことについて](https://esakat.github.io/esakat-blog/posts/docker-in-docker/)

![dind, dood イメージ](https://user-images.githubusercontent.com/19891114/56958913-b51ee000-6b86-11e9-91e0-7a0b6f6cb3b1.jpeg)  
画像引用元：[Docker コンテナ内から Docker を使うことについて](https://esakat.github.io/esakat-blog/posts/docker-in-docker/)

## dind : Docker in Docker
{: .no_toc }

_Docker インストール済みのコンテナを使用しコンテナ内でホストとは別に Docker デーモンを動かす方法。_

## dood : Docker out of docker
{: .no_toc }

_Docker インストール済みのコンテナを使用するのは DinD と同じだが dockerd、containerd は使用しない。
代わりコンテナ側からホストの docker.sock (/var/run/docker.sock)をマウントすることでコンテナ上の Docker コマンドはホスト側の Docker 環境で実行される。_

# GitLab Runner を試す

参考

- [Run GitLab Runner in a container](https://docs.gitlab.com/runner/install/docker.html)

## gitlab-runner config 用 volume の準備
{: .no_toc }

```
PS> docker volume create gitlab-runner-config
```

## gitlab-runner の起動
{: .no_toc }

```
PS> docker run -d --name gitlab-runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner:alpine
```

## gitlab-runner の登録
{: .no_toc }

- トークンの確認  
  GitLab の各プロジェクトの Settings > CI/CD > Runners を開くと
  Registration token が表示されている。

- register コマンドの実行

```
PS> docker run --rm -it -v gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner:alpine register
```

```
Runtime platform                                    arch=amd64 os=linux pid=7 revision=e0218c92 version=14.3.2
Running in system-mode.

Enter the GitLab instance URL (for example, https://gitlab.com/):
https://gitlab.com/ ※入力
Enter the registration token:
XXXXXXXXXXXXXXX ※入力
Enter a description for the runner:
[6f992fab11b9]: ※デフォルトでEnter
Enter tags for the runner (comma-separated):
※入力なしでEnter
Registering runner... succeeded                     runner=7NYg9Wgp
Enter an executor: virtualbox, docker+machine, docker-ssh, ssh, parallels, shell, docker-ssh+machine, kubernetes, custom, docker:
shell ※入力
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
```

# GitLab Pages を試す (ユーザーのプロジェクトページ)

Pages の URL はプロジェクトの Settings > Pages に表示されている。

## Jekyll

1. サンプルプロジェクトを fork する  
   [Jekyll Sample - GitLab](https://gitlab.com/pages/jekyll)  
   新規プロジェクト作成時に Jekyll テンプレートを選択することができるが、
   サンプルプロジェクトと内容が微妙に異なる（テンプレートの方が少し古いと思われる）。
1. fork 元との関連を削除する  
   Settings > General > Advanced > Remove fork relationship
1. Runner を登録する。
1. `_config.yml`の baseurl をプロジェクト名となるように修正する。

## Hugo

1. サンプルプロジェクトを fork する  
   [Hugo Sample - GitLab](https://gitlab.com/pages/hugo)  
   新規プロジェクト作成時に Jekyll テンプレートを選択することができるが、
   サンプルプロジェクトと内容が微妙に異なる。  
   （テンプレートの方が少し古いと思われる）
1. fork 元との関連を削除する  
   Settings > General > Advanced > Remove fork relationship
1. Runner を登録する。
1. `config.toml`の baseurl を Pages の URL となるように修正する。

# GitLab CI/CD : artifact と cache

- [GitLab CI/CD での依存関係のキャッシュ](https://gitlab-docs.creationline.com/ee/ci/caching/)
- [GitLab (CI/CD パイプライン編)](https://www.ospn.jp/osc2019-fall/pdf/OSC2019_TokyoFall_Yano.pdf)

# ffmpegで静止画からgifを作る

インプットとなるファイルを用意する。
ファイル名は連番になるようにする。

```
input_00.png
input_01.png
input_02.png
input_03.png
```

これらインプットからgifファイル(output.gif)を生成する。
```
$ ffmpeg -r 1 -i input_%02d.png -f gif output.gif
```

## カラーパレットを使ってより画質の良いgifを作る
{: .no_toc }

上記のコマンドだと画質が悪いので、カラーパレットを使ってより画質の良いgifを作る。

- カラーパレットを生成する
  ```
  $ ffmpeg -i input_%02d.png -vf palettegen palette.png
  ```
- gifを生成する
  ```
  $ ffmpeg -r 1 -i input_%02d.png -i palette.png -filter_complex paletteuse -f gif output.gif
  ```

# git : tag/commit が乗っている branch を表示する

```
$ git branch --contains <tag or commit>
```

[Git: How to find out on which branch a tag is?](https://stackoverflow.com/questions/15806448/git-how-to-find-out-on-which-branch-a-tag-is)
