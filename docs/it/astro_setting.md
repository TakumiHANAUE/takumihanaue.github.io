---
layout: default
title: Astro 設定
nav_order: 2
parent: IT
---

# devcontainer環境でホットリロードを有効にする

`astro.config.mjs` に `usePolling: true` を設定する。

```diff
  export default defineConfig({
+     vite: {
+         server: {
+             watch: {
+                 usePolling: true,
+             }
+         }
+     }
  });
```

**参考**
- [WSL2環境でAstroのホットリロードを動かす](https://szk302.dev/posts/WSL2%E7%92%B0%E5%A2%83%E3%81%A7Astro%E3%81%AE%E3%83%9B%E3%83%83%E3%83%88%E3%83%AA%E3%83%AD%E3%83%BC%E3%83%89%E3%82%92%E5%8B%95%E3%81%8B%E3%81%99/)
- [Vite - サーバオプション - server.watch](https://ja.vitejs.dev/config/server-options.html#server-watch) に記載の通り、`usePolling: true` を設定する。
    > Windows Subsystem for Linux (WSL) 2 上での Vite の実行
    > 
    > Vite を WSL2 で実行している際、ファイルシステム監視はファイルが Windows アプリケーション（WSL2 でないプロセス）により編集された場合に動作しません。これは WSL2 の制約 によるものです。これは WSL2 バックエンドの Docker で実行している場合でも該当します。
    > 
    > これを修正するためには、次のいずれかを行えます:
    > 
    > - 推奨: ファイルを編集するのに WSL2 アプリケーションを使用します。  
    >   - プロジェクトフォルダを Windows ファイルシステムの外へ移動させることも推奨されます。WSL2 から Windows ファイルシステムへアクセスするのは遅いです。このオーバーヘッドを取り除くことでパフォーマンスが向上します。  
    > - { usePolling: true } を設定する。  
    >   - usePolling は CPU 使用率が高くなることに注意してください。

# Markdownの文字化け解消

ファイルに以下を追記する。
例えば、ベースのレイアウトを定義したastroファイルに追記すると良い。

```md
<head>
  <meta charset="UTF-8" />
</head>
```

**参考**
- [Astro + zenn-markdown-htmlで始める個人ブログ](https://zenn.dev/jy8752/articles/0b842e7f380fb8#markdown%E3%81%AE%E6%96%87%E5%AD%97%E5%8C%96%E3%81%91%E5%AF%BE%E5%BF%9C)

