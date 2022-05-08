---
layout: default
title: ドロップダウンリスト
nav_order: 6
parent: Microsoft Power Apps
grand_parent: IT
---

[こちら]({% link docs/it/powerapps/buildfirstpowerapp.md %}) の記事でExcelデータからキャンバスアプリを作った。
このとき、不満点として

> 入力値をドロップダウンで入力したい

というのを挙げた。

編集画面での入力をドロップダウンに変更してみる。
選択肢は、`T`, `O`, `TO`, `OT` の4つ。
[こちら]({% link docs/it/powerapps/buildfirstpowerapp.md %}) の記事で作ったキャンバスアプリに対して変更を加える。

## 方法１ : AllowedValue に 値リストを定義する

1. **EditForm1** の中にある 2022年1月1日 の DataCard を選択する  
1. 画面右の **プロパティ** の **フィールド** から **編集** を押す  
1. 2022年1月1日のDataCardの詳細が表示されるので、 **コントロールの種類** を **許可値** に変更する  
    ![許可値に変更]({% link docs/it/powerapps/assets/settingallowedvalues.png %})
1. 画面右の **詳細設定** の **プロパティを変更するためにロックを解除します。** を押す  
    ![ロックを解除]({% link docs/it/powerapps/assets/unlockdetailsetting.png %})
1. **データ** の **AllowedValues** に `["T", "O", "TO", "OT"]` を入力する  
    ![許可値を入力]({% link docs/it/powerapps/assets/inputallowedvalues.png %})

以上で、2022年1月1日を値をドロップダウンリストで選択できるようになった。

が、この操作を各日付のDataCardに対して行うのは面倒くさい。

<!-- ## 方法２ : 選択肢をExcelのテーブルとして用意する -->
