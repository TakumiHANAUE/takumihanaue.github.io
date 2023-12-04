---
layout: default
title: Forms の回答を SharePoint List に追加する
nav_order: 1
parent: Microsoft Power Automate
grand_parent: IT
---

Forms の回答内容を SharePont List に追加する PowerAutomate フローを作成する。

## 準備

### SharePoint List を作る

任意の SharePoint List を作成する。
このリストに Forms の回答内容を追加する。
作成したリストは以下の通り。
以下のフィールドから構成される。

- タイトル
- カテゴリ
- キーワード１
- 内容
- リンク

![TIPS Q&A List]({% link docs/it/powerautomate/assets/forms_to_sharepoint_list_02.png %})

### Forms を作る

任意のフォームを予め作成しておく。
今回は「TIPS Q&A」というフォームを作成した。  
内容は下記の通り。

![TIPS Q&A Forms]({% link docs/it/powerautomate/assets/forms_to_sharepoint_list_01.png %})

## 完成したフロー

![フローの全体像]({% link docs/it/powerautomate/assets/forms_to_sharepoint_list_03.png %})

## フロー詳細

### トリガー : 新しい応答が送信されるとき

- **フォームID** は先に作成したフォーム **TIPS Q&A** を選択する。

![新しい応答が送信されるとき]({% link docs/it/powerautomate/assets/forms_to_sharepoint_list_04.png %})

### アクション : 応答の詳細を取得する

フォームの回答内容を取得する。

- **フォームID** に先に作成した **TIPS Q&A** を選択する。
- **応答ID** に動的なコンテンツから **応答ID** を指定する。  
    （動的なコンテンツは入力欄をクリックすると現れる）

![新しい応答が送信されるとき]({% link docs/it/powerautomate/assets/forms_to_sharepoint_list_05.png %})

### アクション : 項目を作成する

追加するリストを作成する。

- **サイトのアドレス** に追加先のリストを持っている SharePoint サイトを選択する。
- **リスト名** に追加先のリストを選択する。
- その他項目は追加先のリストのフィールドが表示される。
動的なコンテンツから適当な項目を指定する。

![新しい応答が送信されるとき]({% link docs/it/powerautomate/assets/forms_to_sharepoint_list_06.png %})
