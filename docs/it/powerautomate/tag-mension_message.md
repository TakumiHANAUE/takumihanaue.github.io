---
layout: default
title: タグメンションしたメッセージをTeamsに投稿する
nav_order: 1
parent: Microsoft Power Automate
grand_parent: IT
---

## 準備

### タグを作る

- Teamsの各チームの三点マーク `・・・` を開き、 **タグを管理** を開く。  
  <img src="{% link docs/it/powerautomate/assets/tag-mension_message_01.png %}" width="50%" alt="タグを作る">
- タグの管理画面の **タグを作成** からタグを作成することができる。  
  ![タグを作る]({% link docs/it/powerautomate/assets/tag-mension_message_02.png %})

ここでは **TeamA** というタグを作成した。

## 完成したフロー

![フローの全体像]({% link docs/it/powerautomate/assets/tag-mension_message_03.png %})

### 投稿されるメッセージ

![投稿されるメッセージ]({% link docs/it/powerautomate/assets/tag-mension_message_04.png %})

## フロー詳細

### トリガー : 手動でフローをトリガーします

![手動でフローをトリガーします]({% link docs/it/powerautomate/assets/tag-mension_message_05.png %})

使用者の操作によってフローを実行するトリガー。
Power Automate の画面等からボタン押下によって実行する。

### アクション : タグの @mension トークンを取得する

![タグの @mension トークンを取得する]({% link docs/it/powerautomate/assets/tag-mension_message_06.png %})

- **チーム** は タグを作ったチームを選択する
- **タグID** は 使用するタグを選択する

### アクション : チャットまたはチャネルでメッセージを投稿する

![チャットまたはチャネルでメッセージを投稿する]({% link docs/it/powerautomate/assets/tag-mension_message_07.png %})

- **投稿者** は **ユーザー** を選択する（タグメンション使用時にフローボットを使用するとエラーになる）
- **投稿先** は **Channel** を選択する
- **Team** は投稿先のチームを選択する
- **Channel** は投稿先のチャンネルを選択する
- **Message** は投稿するメッセージ記載する
  - **動的なコンテンツ** から **@mention タグ** を選択する

