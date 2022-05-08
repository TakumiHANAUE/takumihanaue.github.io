---
layout: default
title: GitHub Pages 作成
nav_order: 2
parent: IT
---

作成したJekyllサイトを GitHub Pages(user site) としてパブリッシュする。

- サイト用のリポジトリを作成する  
    Repository name を `<アカウント名(小文字)>.github.io` として新規リポジトリを作成する。
- テーマ指定を`remote_theme`に変更する(本サイトでは Just the Docs テーマを使用)
    - "jekyll-remote-theme" gem を追加
    - `_config.yml` の theme を remote_theme に変更 ( [修正差分例](https://github.com/TakumiHANAUE/takumihanaue.github.io/commit/7ade15e88ba04125f7aec7c54c36cb26b3ff4de2) )
- Just the Docs テーマの Configuration を設定する  
    [こちらのページ](https://pmarsceill.github.io/just-the-docs/docs/configuration/) にしたがって、必要な設定をする。
- Google Analytics のトラッキングを設定する  
    Just the Docs テーマでは `_config.yml` で `ga_tracking` に `測定ID` を記載するだけで良い。
    `ga_tracking_anonymize_ip` はデフォルト値 `true` にした。

### 参考ページ

- [Setting up a GitHub Pages site with Jekyll](https://docs.github.com/ja/pages/setting-up-a-github-pages-site-with-jekyll)
- [Jekyll のテーマを GitHub Pages に適用する](https://chirimenmonster.github.io/2021/06/29/jekyll-remote-theme.html)
- [Quick start: Use as a GitHub Pages remote theme](https://pmarsceill.github.io/just-the-docs/#quick-start-use-as-a-github-pages-remote-theme)
- [Adding a theme to your GitHub Pages site using Jekyll](https://docs.github.com/ja/pages/setting-up-a-github-pages-site-with-jekyll/adding-a-theme-to-your-github-pages-site-using-jekyll)
- [Just the Docs : Configuration](https://pmarsceill.github.io/just-the-docs/docs/configuration/)
    - [Just the Docs : Configuration/Google Analytics](https://just-the-docs.github.io/just-the-docs/docs/configuration/#google-analytics)