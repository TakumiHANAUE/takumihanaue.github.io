---
layout: default
title: Formsの回答要求メッセージをTeamsに投稿する
nav_order: 1
parent: Microsoft Power Automate
grand_parent: IT
---

## 準備

### Forms を作る

任意のフォームを予め作成しておく。
今回は「回答してほしいForms」というフォームを作成した。  
内容は下記の通り。

![回答してほしいForms]({% link docs/it/powerautomate/assets/request_to_answer_forms_01.png %})

## 完成したフロー

![フローの全体像]({% link docs/it/powerautomate/assets/request_to_answer_forms_02.png %})

### 投稿されるメッセージ

![投稿されるメッセージ]({% link docs/it/powerautomate/assets/request_to_answer_forms_03.png %})

"こちら"の部分はFormsへのリンクになっている。

## フロー詳細

### トリガー : 手動でフローをトリガーします

![手動でフローをトリガーします]({% link docs/it/powerautomate/assets/request_to_answer_forms_04.png %})

使用者の操作によってフローを実行するトリガー。Power Automate の画面等からボタン押下によって実行する。

### アクション : チャットまたはチャネルでメッセージを投稿する

![チャットまたはチャネルでメッセージを投稿する]({% link docs/it/powerautomate/assets/request_to_answer_forms_05.png %})

- **投稿者** は **フローボット** を選択する（明示的にフロー実行者からの投稿としたい場合は **ユーザー** を選択する）
- **投稿先** は **Channel** を選択する
- **Team** は投稿先のチームを選択する
- **Channel** は投稿先のチャンネルを選択する
- **Message** は投稿するメッセージ記載する
  - **動的なコンテンツ** から **日付** を選択する  
  フォームの回答内容は **動的なコンテンツ** から選択することができる。
  入力欄をクリックすると **動的なコンテンツ** の選択ウィンドウが表示されるため、そこから **日付** を選択する。  
  　
  ![動的なコンテンツ]({% link docs/it/powerautomate/assets/request_to_answer_forms_06.png %})

  - 「回答してほしいForms」へのリンクをメッセージに入れる  
  Messege入力欄の **Link** アイコンを選択し、
    - "Link Title" に「こちら」、"Link Target" にFormsへのURLを入力し、"Add"をクリックする。  
    　
    ![Formsへリンク]({% link docs/it/powerautomate/assets/request_to_answer_forms_07.png %})
    Formsへのリンクは、Formsの **回答の収集** からコピーしてくる。
    　
    ![FormsのURL]({% link docs/it/powerautomate/assets/request_to_answer_forms_08.png %})

    - "こちら"の文字を目立たせるため、フォントサイズを変更し太字にする  
    "こちら"部分を選択し、Fontサイズを 18 に、太字設定のボタン("B"のボタン)を有効にする。