---
layout: default
title: Formsの回答要求メッセージをTeamsに投稿する（アダプティブカードを使う）
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

![フローの全体像]({% link docs/it/powerautomate/assets/request_to_answer_forms_adaptivecards_01.png %})

### 投稿されるメッセージ

![投稿されるメッセージ]({% link docs/it/powerautomate/assets/request_to_answer_forms_adaptivecards_02.png %})

"Formsを開く"ボタンを押すことでFormsに飛ぶことができる。

## フロー詳細

### トリガー : 手動でフローをトリガーします

![手動でフローをトリガーします]({% link docs/it/powerautomate/assets/request_to_answer_forms_adaptivecards_03.png %})

使用者の操作によってフローを実行するトリガー。Power Automate の画面等からボタン押下によって実行する。

### アクション : チャットまたはチャネルでメッセージを投稿する

![チャットまたはチャネルでメッセージを投稿する]({% link docs/it/powerautomate/assets/request_to_answer_forms_adaptivecards_04.png %})

- **投稿者** は **フローボット** を選択する（明示的にフロー実行者からの投稿としたい場合は **ユーザー** を選択する）
- **投稿先** は **Channel** を選択する
- **Team** は投稿先のチームを選択する
- **Channel** は投稿先のチャンネルを選択する
- **Adaptive Cards** はアダプティブカードを定義するJson定義を記載する  
  <details close markdown="block">
    <summary>Json定義全体はこちら</summary>
    ```json
    {
        "type": "AdaptiveCard",
        "body": [
            {
                "type": "TextBlock",
                "size": "Medium",
                "weight": "Bolder",
                "text": ""
            }
        ],
        "actions": [
            {
                "type": "Action.OpenUrl",
                "title": "",
                "url": ""
            }
        ],
        "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
        "version": "1.2"
    }
    ```
  </details>
  - アダプティブカードに表示する文言を `body` の `text` に記載する。  
  表示文言はダブルクォーテーション`"`で括って記載する。
  "日付"は **動的なコンテンツ** を使用して入力する。
  入力欄をクリックすると **動的なコンテンツ** の選択ウィンドウが表示されるため、そこから **日付** を選択する。  
  　
  ![動的なコンテンツ]({% link docs/it/powerautomate/assets/request_to_answer_forms_adaptivecards_05.png %})

  - ボタン部分の設定を記載する  
    - ボタンに表示する文言を `actions` の `title` に記載する  
    - ボタンに割り当てるURLを `actions` の `url` に記載する  
    Formsへのリンクは、Formsの **回答の収集** からコピーしてくる。
    　
    ![FormsのURL]({% link docs/it/powerautomate/assets/request_to_answer_forms_adaptivecards_06.png %})
