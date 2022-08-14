---
layout: default
title: Excel Power Query で移動合計を算出する
nav_order: 2
parent: IT
---

日ごとの勤務時間データから時間外業務時間の N 日間移動合計を算出する。

## 元データ

| 日付              | 勤務時間 |
| :---------------- | :------- |
| 2022 年 1 月 1 日 | 8.00     |
| 2022 年 1 月 2 日 | 9.00     |
| 2022 年 1 月 3 日 | 10.00    |
| 2022 年 1 月 4 日 | 8.00     |
| 2022 年 1 月 5 日 | 7.70     |
| 2022 年 1 月 6 日 | 8.20     |
| 2022 年 1 月 7 日 | 5.50     |

## データ加工

| 適用したステップ | 内容                                          |
| :--------------- | :-------------------------------------------- |
| 型の変更         | 元データの各列の型を変更する                  |
| 時間外業務時間   | `勤務時間-8.0` を時間外業務時間として追加する |
| 移動合計         | 時間外業務時間の 3 日間移動合計を追加する     |

### 型の変更

**数式**

```
= Table.TransformColumnTypes(テーブル1_Table, { { "日付", type date }, { "勤務時間", type number } })
```

**結果**

- `日付` を`date`型に変更する
- `勤務時間` を`number`型に変更する
- 本ステップ適用後のテーブルを `型の変更` として生成する

**数式詳細**

- Table.TransformColumnTypes() : [仕様](https://docs.microsoft.com/ja-jp/powerquery-m/table-transformcolumntypes)

    ```
    - 返り値
        - as table
    - 引数
        - table as table
        - typeTransformations as list
        - optional culture as nullable text
    ```

    | 引数                | 代入値                                            |
    | :------------------ | :----------------------------------------------- |
    | table               | テーブル 1_Table                                 |
    | typeTransformations | { {"日付", type date }, { "勤務時間", type number } } |
    | culture             | -                                                |

### 時間外業務時間

**数式**

```
= Table.AddColumn(型の変更, "時間外業務時間", each [勤務時間] - 8.0, type number)
```

**結果**

- `型の変更`ステップで生成されたテーブルに対し、`時間外業務時間`列を追加する
- `時間外業務時間` は `勤務時間` から 8.0 を引いた値として追加する
- 本ステップ適用後のテーブルを `時間外業務時間` として生成する

| 日付     | 勤務時間 | 時間外業務時間 |
| :------- | :------- | :------------- |
| 2022/1/1 | 8        | 0              |
| 2022/1/2 | 9        | 1              |
| 2022/1/3 | 10       | 2              |
| 2022/1/4 | 8        | 0              |
| 2022/1/5 | 7.7      | -0.3           |
| 2022/1/6 | 8.2      | 0.2            |
| 2022/1/7 | 5.5      | -2.5           |

**数式詳細**

- Table.AddColumn() : [仕様](https://docs.microsoft.com/ja-jp/powerquery-m/table-addcolumn)

    ```
    - 返り値
        - as table
    - 引数
        - table as table
        - newColumnName as text
        - columnGenerator as function
        - optional columnType as nullable type
    ```

    | 引数            |  代入値                |
    | :-------------- | :-------------------- |
    | table           | 型の変更              |
    | newColumnName   | "時間外業務時間"      |
    | columnGenerator | each [勤務時間] - 8.0 |
    | columnType      | type number           |

### 移動合計

**数式**

```
= Table.AddColumn(
    時間外業務時間,
    "移動合計",
    (g)=>List.Sum(
        Table.SelectRows(
            時間外業務時間,
            each([日付]<=g[日付] and [日付] >= Date.AddDays(g[日付], -2))
        )[時間外業務時間]
    ),
    type number
)
```

**結果**

- `時間外業務時間`ステップで生成されたテーブルに対し、`移動合計`列を追加する
- `移動合計` は `時間外業務時間`列の値の 3 日間移動合計とする

| 日付     | 勤務時間 | 時間外業務時間 | 3 日間移動合計 |
| :------- | :------- | :------------- | :------------- |
| 2022/1/1 | 8        | 0              | 0              |
| 2022/1/2 | 9        | 1              | 1              |
| 2022/1/3 | 10       | 2              | 3              |
| 2022/1/4 | 8        | 0              | 3              |
| 2022/1/5 | 7.7      | -0.3           | 1.7            |
| 2022/1/6 | 8.2      | 0.2            | -0.1           |
| 2022/1/7 | 5.5      | -2.5           | -2.6           |

**数式詳細**

- Table.AddColumn() : [仕様](https://docs.microsoft.com/ja-jp/powerquery-m/table-addcolumn)

    ```
    - 返り値
        - as table
    - 引数
        - table as table
        - newColumnName as text
        - columnGenerator as function
        - optional columnType as nullable type
    ```

    | 引数            | 代入値                   |
    | :-------------- | :---------------------- |
    | table           | 時間外業務時間          |
    | newColumnName   | "移動合計"              |
    | columnGenerator | (g)=>List.Sum( 記載略 ) |
    | columnType      | type number             |

    - `時間外業務時間`ステップで生成したテーブルに`移動合計`列を追加する
    - 列の生成式は `(g)=>List.Sum( 記載略 )`  
        （引数`g`には対象行のデータが渡される（という理解で良いはず））
    - 値は`number`型とする

- List.Sum() : [仕様](https://docs.microsoft.com/ja-jp/powerquery-m/list-sum)

    ```
    - 返り値
        - as any
    - 引数
        - list as list
        - optional precision as nullable number
    ```

    | 引数      | 代入値                                      |
    | :-------- | :----------------------------------------- |
    | list      | Table.SelectRows( 記載略 )[時間外業務時間] |
    | precision | -                                          |

    - SelectRows()で抽出した行の`時間外業務時間`要素の合計を算出する

- Table.SelectRows() : [仕様](https://docs.microsoft.com/ja-jp/powerquery-m/table-selectrows)

    ```
    - 返り値
        - as table
    - 引数
        - table as table
        - condition as function
    ```

    | 引数      | 代入値                                                          |
    | :-------- | :-------------------------------------------------------------- |
    | table     | 時間外業務時間                                                  |
    | condition | each( [日付]<=g[日付] and [日付] >= Date.AddDays(g[日付], -2) ) |

    - 以下条件を満たす行を抽出する
        - 引数で渡した`日付`値（`g[日付]`）より小さい`日付`を持つ行
        - 引数で渡した`日付`値の 2 日前（`Date.AddDays(g[日付], -2)`）より大きい`日付`を持つ行

- Date.AddDays() : [仕様](https://docs.microsoft.com/ja-jp/powerquery-m/date-adddays)

    ```
    - 返り値
        - as any
    - 引数
        - dateTime as any
        - numberOfDays as number
    ```

    | 引数         | 代入値     |
    | :----------- | :------ |
    | dateTime     | g[日付] |
    | numberOfDays | -2      |

    - 引数で渡した`日付`値（`g[日付]`）の 2 日前の値を算出する

## 参考

- [Creating a Rolling Average & Rolling Total using Power Query.](https://www.mavaanalytics.com/post/creating-a-rolling-average-sum)
- [【Power Query M 式言語】関数について解説](https://www.tekizai.net/entry/2021/09/23/063000)
- [M 言語に慣れる\_8 回目～ EACH を使いこなして M 関数作成～](https://analytic-vba.com/power-query/m-code/begin-each/#4)
- M 関数仕様
    - [Table.TransformColumnTypes()](https://docs.microsoft.com/ja-jp/powerquery-m/table-transformcolumntypes)
    - [Table.AddColumn()](https://docs.microsoft.com/ja-jp/powerquery-m/table-addcolumn)
    - [List.Sum()](https://docs.microsoft.com/ja-jp/powerquery-m/list-sum)
    - [Table.SelectRows()](https://docs.microsoft.com/ja-jp/powerquery-m/table-selectrows)
    - [Date.AddDays()](https://docs.microsoft.com/ja-jp/powerquery-m/date-adddays)
