---
layout: default
title: SharePoint List から空のページを作成する
nav_order: 1
parent: Microsoft Power Automate
grand_parent: IT
---

SharePoint List の項目から SharePoint ページを作成する。

## 準備

### テンプレートの SharePoint ページを作る

サイトの任意の場所にコピー元のページを作成する。
今回は `サイトのページ/テンプレート/TIPSテンプレート.aspx` を作成した。

![テンプレートページ]({% link docs/it/powerautomate/assets/sharepoint_list_to_page_01.png %})

### SharePoint List を作る

任意の SharePoint List を作成する。
選択したリスト項目から SharePoint ページを作成する。
今回は "TIPS" というリスト作成した。
以下のフィールドから構成される。

- タイトル
- カテゴリ
- キーワード１
- 内容
- リンク

![TIPS List]({% link docs/it/powerautomate/assets/sharepoint_list_to_page_02.png %})

## 完成したフロー

![フローの全体像]({% link docs/it/powerautomate/assets/sharepoint_list_to_page_03.png %})

## フロー詳細

### トリガー : 選択したアイテムの場合

- **サイトのアドレス** 対象のサイトを選択する。
- **リスト名** は対象のリストを選択する。

![選択したアイテムの場合]({% link docs/it/powerautomate/assets/sharepoint_list_to_page_04.png %})

### アクション : 項目の取得

- **サイトのアドレス** 対象のサイトを選択する。
- **リスト名** は対象のリストを選択する。
- **ID** は動的なコンテンツから **ID** を指定する。

![項目の取得]({% link docs/it/powerautomate/assets/sharepoint_list_to_page_05.png %})

### アクション : ファイルのコピー

先に作成したテンプレートの SharePoint ページをコピーして新しいページを作成する。

- **現在のサイト アドレス** 対象のサイトを選択する。
- **コピーするファイル** はテンプレートのファイルを指定する。
- **送信先サイト アドレス** はコピー先のサイトを選択する。
- **インストール先フォルダ** はコピー先のフォルダを指定する。
- **別のファイルが既に存在する場合** は **Copy with a new name** を選択する。

![ファイルのコピー]({% link docs/it/powerautomate/assets/sharepoint_list_to_page_06.png %})


### アクション : ファイル名の変更

コピーしたファイルの名前を変更する。
ここでは、元となったリスト項目がわかるファイル名に変更する。

HTTPリクエストを使うので少し難しい。
（HTTPリクエスについて不勉強のため、仕組みはいまいちわかっていない。。）

- **サイトのアドレス** 対象のサイトを選択する。
- **方法** は **POST** を選択する。
- **URI** は以下の通り入力。
    ```
    _api/web/lists/getbytitle('サイトのページ')/items(@{outputs('ファイルのコピー')?['body/ItemId']})/validateUpdateListItem
    ```
    **ItemId** は「アクション : ファイルのコピー」の出力項目。
    動的なコンテンツから選択する。
- **ヘッダー** は入力なし
- **ボディ** は以下の通り入力
    ```json
    {
    "formValues": [
    {
    "FieldName": "FileLeafRef",
    "FieldValue": "@{outputs('項目の取得')?['body/OData__x30ab__x30c6__x30b4__x30ea_']}_@{utcNow('yyyy-MM-dd')}_@{outputs('項目の取得')?['body/Title']}.aspx"
    }
    ]
    }
    ```
    **カテゴリ**、**タイトル** は「アクション : 項目の取得」の出力項目。
    動的なコンテンツから選択する。  
    [utcNow 関数](https://learn.microsoft.com/ja-jp/azure/logic-apps/workflow-definition-language-functions-reference#utcNow)のフォーマットは `yyyy-MM-dd` を指定した。

![ファイル名の変更]({% link docs/it/powerautomate/assets/sharepoint_list_to_page_07.png %})

## 実行方法／結果

### 実行方法

リスト項目の「・・・」からその他の項目を展開すると「自動化」に作成したフローが表示されるので、実行する。

![実行方法]({% link docs/it/powerautomate/assets/sharepoint_list_to_page_08.png %})

### 実行結果

サイトのページに新しい SharePoint ページが作成されている。

![実行方法]({% link docs/it/powerautomate/assets/sharepoint_list_to_page_09.png %})

## 参考

- [【SharePoint】リストからページを作成する自動化（Power Automate）テンプレート](https://echigoya-blog.net/sharepoint-create-page-list/)
- [SharePoint REST サービスの概要](https://learn.microsoft.com/ja-jp/sharepoint/dev/sp-add-ins/get-to-know-the-sharepoint-rest-service?tabs=csom#bk_learnmore)
- [ListItem.ValidateUpdateListItem Method](https://learn.microsoft.com/ja-jp/dotnet/api/microsoft.sharepoint.client.listitem.validateupdatelistitem?view=sharepoint-csom)
- [Azure Logic Apps および Power Automate のワークフロー式関数のリファレンス ガイド](https://learn.microsoft.com/ja-jp/azure/logic-apps/workflow-definition-language-functions-reference)
