---
layout: default
title: Formsの回答内容をTeamsに投稿する
nav_order: 1
parent: Microsoft Power Automate
grand_parent: IT
---

## 準備

### Forms を作る

任意のフォームを予め作成しておく。
今回は「回答内容をTeamsに投稿する」というフォームを作成した。  
内容は下記の通り。

![新しい回答が送信されたときにチームに通知する]({% link docs/it/powerautomate/assets/forms_submission_05.png %})


## 完成したフロー

![フローの全体像]({% link docs/it/powerautomate/assets/forms_submission_06.png %})

### 投稿されるメッセージ

![投稿されるメッセージ]({% link docs/it/powerautomate/assets/forms_submission_08.png %})

## フロー詳細

### 使用するテンプレート

今回は「新しい回答が送信されたときにチームに通知する」テンプレートを使う。  
（テンプレートを使わずに同じ内容のフローを自作することもできる）

![新しい回答が送信されたときにチームに通知する]({% link docs/it/powerautomate/assets/forms_submission_01.png %})

### トリガー : When a new response is submitted

- **フォームID** は先に作成したフォームを選択する。

![When a new response is submitted]({% link docs/it/powerautomate/assets/forms_submission_02.png %})

### アクション : Reply to each

- **以前の手順から出力を選択** は **応答通知の一覧** を選択する（テンプレートを使った場合、予め入力されている）

![Reply to each]({% link docs/it/powerautomate/assets/forms_submission_07.png %})

### アクション : Get response details

- **フォームID** は先に作成したフォームを選択する。
- **応答ID** は **応答通知の一覧 応答 ID** を選択する（テンプレートを使った場合、予め入力されている）

![Get response details]({% link docs/it/powerautomate/assets/forms_submission_03.png %})

### アクション : Post message in a chat or channel

- **投稿者** は **フローボット** を選択する（テンプレートを使った場合、予め入力されている）
- **投稿先** は **Channel** を選択する（テンプレートを使った場合、予め入力されている）
- **Team** は投稿先のチームを選択する
- **Channel** は投稿先のチャンネルを選択する
- **Message** は投稿するメッセージ記載する  
フォームの回答内容は **動的なコンテンツ** から選択することができる。
入力欄をクリックすると **動的なコンテンツ** の選択ウィンドウが表示されるため、そこから任意の要素を選択する。  
今回は、回答者のメールアドレスおよび、フォームの回答内容をメッセージで通知するようにした。

![Post message in a chat or channel]({% link docs/it/powerautomate/assets/forms_submission_04.png %})


