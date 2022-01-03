---
layout: default
title: Jekyllサイト作成
nav_order: 1
parent: IT
---

**環境**

- OS : Windows 10 (Ver.20H2)
- 使用するソフトなど
  - Docker Desktop
  - Visual Studio Code
    - 拡張機能
      - Remote - Container

# 新規 Jekyll サイト生成 (Docker)

- `./mypage`に Jekyll サイトを作る  
  以下コマンドを実行すると、サンプルの Jekyll サイトが生成される。
  ```
  PS > docker run --rm --volume="${PWD}:/srv/jekyll" -it -p 4000:4000 jekyll/jekyll jekyll new mypage
  ```

# テーマを変更する

今回は、[just-the-docs](https://pmarsceill.github.io/just-the-docs/#local-installation-use-the-gem-based-theme) テーマを使用する。
手順は以下の通り。

- [just-the-docs](https://github.com/pmarsceill/just-the-docs/blob/master/_config.yml) の `_config.yml` をコピーし、既にある`_config.yml`と置き換える。
- [Local installation: Use the gem-based theme
  ](https://pmarsceill.github.io/just-the-docs/#local-installation-use-the-gem-based-theme)にしたがって

  - `_config.yml`に以下を記載

    ```diff
      url: "" # the base hostname & protocol for your site, e.g. http://example.com
    + theme: "just-the-docs"
      permalink: pretty
    ```

  - `Gemfile`を以下の通り変更  
    デフォルトの`minima`から`just-the-docs`に変更。

    ```diff
      # This is the default theme for new Jekyll sites. You may change this to anything you like.
    - gem "minima", "~> 2.5"
    + gem "just-the-docs"
    ```

# テーマが変更されたか確認する

以下コマンドを実行し、テーマ変更ができているか確認する。

```
PS > cd ./mypage
PS > docker run -e "JEKYLL_ENV=docker" --name mypage --volume="${PWD}:/srv/jekyll" -it -p 4000:4000 jekyll/jekyll jekyll serve --watch
```

ここで、`-e "JEKYLL_ENV=docker"`を指定したのは、サイト内リンクのアドレスを`localhost`にするため。

### ※ `-e "JEKYLL_ENV=docker"` について補足

参考にした記事は[こちら](https://qiita.com/hydrangeas/items/0e48870c2eb63e807632#6-%E3%82%B5%E3%82%A4%E3%83%88%E5%86%85%E3%83%AA%E3%83%B3%E3%82%AF%E3%81%AEurl%E3%82%920000%E3%81%A7%E3%81%AF%E3%81%AA%E3%81%8Flocalhost%E3%81%AB%E3%81%99%E3%82%8B%E8%A8%AD%E5%AE%9A%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B)

- `JEKYLL_ENV=development`（規定値）のとき、`host`や`port`の値でサイトを生成する。
  - このとき、Jekyll の変数 `site.url`も上書きされるため、Docker でサイト生成するときは、`0.0.0.0:4000`で上書きされることになる。
  - しかし、Windows は`0.0.0.0`へのアクセスは禁止しているため、サイト内リンクを開くことができなくなってしまう。
  - docker run 時に 4000 番ポートを繋いでいるため、トップページにはアクセスできるが、トップページ以下の階層のページにはアクセスできなくなってしまう。（トップページ以下の階層のアドレスが、`0.0.0.0:4000/XXXX` となってしまう。）
- `JEKYLL_ENV=development`以外のときは、この上書きが効かず、トップページの URL を継承したままリンクの URL が生成されるため、トップページ以下の階層のページにアクセスできる。（例：`localhost:4000/XXXX`）  
  この仕様の目的については[こちら](https://jekyllrb.com/news/2016/10/06/jekyll-3-3-is-here/#3-siteurl-is-set-by-the-development-server)を参照のこと。

以降は、Docker Desktop から mypage コンテナを起動すればよい。

# Remote Container 開発の設定をする

Visual Studio Code の [Remote - Container](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) 拡張機能を使って mypage コンテナを起動できるようにする。
（参考にした記事は[こちら](https://qiita.com/hydrangeas/items/0e48870c2eb63e807632)）

### devcontainer.json を作成する

- mypage/.devcontainer/devcontainer.json
  ```json
  {
    "image": "jekyll/jekyll",
    "name": "mypage",
    "forwardPorts": [4000],
    "containerEnv": {
      "JEKYLL_ENV": "docker"
    },
    "workspaceMount": "src=${localWorkspaceFolder},dst=/srv/jekyll,type=bind",
    "workspaceFolder": "/srv/jekyll",
    "postStartCommand": "jekyll serve --force_polling",
    "runArgs": ["--name=mypage"],
    "shutdownAction": "stopContainer"
  }
  ```

### コンテナを起動する

左下の緑の`><`アイコンを押し、`Reopen in Container` を選択する。
ブラウザで`localhost:4000`にアクセスし、サイトが表示されれば OK。

# 数式を表示できるようにする(MathJax)

Jekyll のデフォルトの記法 kramdown では、MathJax をつかって TeX と同様の書き方で数式を表示することができる。
（kramdown の数式表示エンジン設定`math_enjine`のデフォルトが MathJax になっている（[参考](https://kramdown.gettalong.org/options.html)））

MathJax は HTML に以下の script を埋め込めばよい（[参考](https://www.mathjax.org/#gettingstarted)）。

```html
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script
  id="MathJax-script"
  async
  src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"
></script>
```

Jekyll では、各記事に上記 script を記述しても良いが、上記 script が埋め込まれた layout ファイルを用意するのが良い。

例えば、以下のような`default_with_math.html`ファイルを用意して、数式を使いたい記事で`layout: default_with_math`を指定すれば良い。

- default_with_math.html

  ```html
  ---
  layout: default
  ---

  <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
  <script
    id="MathJax-script"
    async
    src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"
  ></script>

  <div class="math-contents">
    <!-- content 変数をここに置く（"content" を 二重の中括弧で囲む） -->
    <!-- ※このコードブロックに変数を書くと展開されてしまう。。。ので、ここではコメントにとどめる。 -->
  </div>
  ```

`default_with_math.html`の内容は、default レイアウトの`content`変数部分に埋め込まれる。
以下ような階層イメージ

```
default.html
`-- default_with_math.html
      `-- XXXX.md（数式を記述した記事）
```

以上の設定で、`$$..$$`で数式を表示できるようになった。

# 数式を表示できるようにする(KaTeX)

MathJax の代わりに KaTeX を使用してみる。どうやら KaTeX の方がレンダリングが早いらしい。  
（ただし、Github Pages ではサポートしていないため注意。Github Pages では MathJax が使用可能）

[数式を表示できるようにする(MathJax)]()で記載した MathJax の script 部分の代わりに以下を記述する（[参考](https://katex.org/docs/autorender.html)）

```html
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/katex@0.13.11/dist/katex.min.css"
  integrity="sha384-Um5gpz1odJg5Z4HAmzPtgZKdTBHZdw8S29IecapCSB31ligYPhHQZMIlWLYQGVoc"
  crossorigin="anonymous"
/>
<script
  defer
  src="https://cdn.jsdelivr.net/npm/katex@0.13.11/dist/katex.min.js"
  integrity="sha384-YNHdsYkH6gMx9y3mRkmcJ2mFUjTd0qNQQvY9VYZgQd7DcN7env35GzlmFaZ23JGp"
  crossorigin="anonymous"
></script>
<script
  defer
  src="https://cdn.jsdelivr.net/npm/katex@0.13.11/dist/contrib/auto-render.min.js"
  integrity="sha384-vZTG03m+2yp6N6BNi5iM4rW4oIwk5DfcNdFfxkk9ZWpDriOkXX8voJBFrAO7MpVl"
  crossorigin="anonymous"
></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    renderMathInElement(document.body, {
      delimiters: [
        { left: "$$", right: "$$", display: true },
        { left: "$", right: "$", display: false },
        { left: "\\[", right: "\\]", display: true },
      ],
      throwOnError: false,
    });
  });
</script>
```

これにより、ブロック表示は`$$..$$`、インライン表示は`$..$`で数式を表示できるようになる。
