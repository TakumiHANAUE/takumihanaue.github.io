---
layout: default
title: Plannerタスクが作成されたとき、Teamsにメッセージを送信する
nav_order: 1
parent: Microsoft Power Automate
grand_parent: IT
---

Plannerタスクが作成されたときに、Teamsにメッセージを送信するフローを作成する。

## 完成したフロー

![フローの全体像]({% link docs/it/powerautomate/assets/plannertask_created_01.png %})

### 投稿されるメッセージ

![投稿されるメッセージ]({% link docs/it/powerautomate/assets/plannertask_created_05.png %})

## フロー詳細

### トリガー : 新しいタスクが作成される場合

![新しいタスクが作成される場合]({% link docs/it/powerautomate/assets/plannertask_created_02.png %})

- **グループID** は対象のチーム名を選択する  
- **タスクID** の入力欄をクリックすると、先に選択したチームが持つタスクのプランが表示されるため、対象のプランを選択する

### アクション : チャットまたはチャネルでメッセージを投稿する

![チャットまたはチャネルでメッセージを投稿する]({% link docs/it/powerautomate/assets/plannertask_created_03.png %})

- **投稿者** はフローボットを選択する  
（ユーザーを選択することもできるが、「Power Automateが投稿したメッセージである」ということを示すためにフローボットを選択することをお勧めする。）
- **投稿先** はチャネルを選択する  
チャネルを選択すると、**チーム** ・ **チャネル** ・ **メッセージ** の入力欄が現れる。
- **チーム** は投稿先のチームを選択する
- **チャネル** は投稿先のチャネルを選択する
- **メッセージ** には投稿するメッセージの文面を入力する

### メッセージ文面にタスクの情報を含める

上記の例では、メッセージ文面にタスクのタイトルを含めている。  
メッセージ入力時に **動的なコンテンツ** 選択肢が表示されるので、そこから **タイトル** を選択すればよい。

![メッセージ文面にタスクのタイトルを含める]({% link docs/it/powerautomate/assets/plannertask_created_04.png %})