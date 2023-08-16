---
layout: default
title: Blazor 環境を構築する
nav_order: 2
parent: IT
---

# Windows + Visual Studio Code

[Windows に .NET をインストールする - Visual Studio Code と共にインストールする](https://learn.microsoft.com/ja-jp/dotnet/core/install/windows?tabs=net70#install-alongside-visual-studio-code)

### Visual Studio Code をインストールする

[Visual Studio Code をダウンロードしてインストールする](https://code.visualstudio.com/Download)

### .NET SDK をインストールする

[.NET のダウンロード](https://dotnet.microsoft.com/ja-jp/download/dotnet)

![.NET のダウンロードページ]({% link docs/it/assets/blazor_preparation_00.png %})

今回は .NET 7.0.10 をインストールする。

![.NET のダウンロードページ]({% link docs/it/assets/blazor_preparation_01.png %})

64bitのIntel製CPUなので x64 用インストーラをダウンロードする。

ダウンロードした `dotnet-sdk-7.0.400-win-x64.exe` をダブルクリックしてインストールをする。
インストールが終わると以下のウィンドウが表示される。
（インストールはオフライン環境でも可能）

![.NET のダウンロードページ]({% link docs/it/assets/blazor_preparation_02.png %})

### Visual Studio Code C# 拡張機能をインストール

[Visual Studio Code マーケットプレースから C# 拡張機能をインストールする](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)
