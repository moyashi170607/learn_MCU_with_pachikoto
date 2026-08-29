#import "../chara.typ": *
#import "@preview/simple-todo:0.1.0": list-todos, todo
#import "@preview/showybox:2.0.4": showybox

== Arduino IDEのセットアップ

#talk[
  #パチケモ[
    じゃぁ今度こそ、PCにArduino IDEを導入して、PCでファームウェアを作る環境を整えよう。
  ]
  #パチ言[よっ！待ってました！]
  #パチケモ[じゃぁ早速Arduino公式サイトに行ってダウンロードしよう。]
]

Arduino IDE 公式ダウンロードサイト https://www.arduino.cc/en/software/

#talk[
  #パチケモ[このサイトを開いて、Arduino IDEをダウンロードしよう。\
    そうするとインストーラーが手に入るから、それを起動して、指示に従ってインストールを進めよう
  ]
  #パチ言[ぽちぽちぽちっと]
  #パチケモ[基本的にはデフォルトのままで良いと思うよ]
]

インストーラーによってインストールが完了すると以下のような画面が表示されると思います。

#figure(
  caption: "Arduino IDE 起動画面",
)[
  #image("img/ide_setup.png")
]

#talk[
  #パチ言[おーなんか凄そう。]
  #パチケモ[
    次はさっきも話したボードマネージャーだね。\
    Pico用のプログラムをインストールしよう。
  ]
]

画面の左側のタブ2番目にあるボタンから「BOARD MANAGER」を開き、検索窓に「RP2040」と入力してみましょう。検索結果を見て「Arduino Mbed OS R2040 Boards」をインストールします。

#figure(
  caption: "RP2040で検索",
)[
  #image("img/board_manager.png")
]

#talk[
  #パチケモ[
    そこそこ時間がかかるから、気長に待とうね。\
    途中でドライバ等のインストールをするか訊かれた場合はそれもインストールしよう。\
    Arduino Mbed OS R2040 BoardsのINSTALLだった部分がREMOVEになってたらインストール完了だよ。
  ]
]

#figure(
  caption: "インストール完了",
)[
  #image("img/installed.png")
]

#talk[
  #パチケモ[これで環境構築は終了だよ。]
  #パチ言[結構簡単だったね。]
  #パチ言[この手軽さはやっぱりArduino IDEの良さだね]
]

#showybox()[
  *コラム：Pico SDKの環境構築*

  「Arduino IDEの環境構築は手軽である一方、Pico SDKの環境構築は難しい」と言われることがあります。

  これはPico SDKがビルドツール（プログラムを機械が実行可能な形式にするビルドをサポートをするツール）を自分で整える必要があるからです。
  特に「CMake」の設定ファイルの文法は難解です。
  独自のライブラリを導入したり、柔軟に様々なタスクの自動化が行える一方で、Arduino IDEならワンクリックで済むようなこともCMakeでは自分でCmakeのコードを書く必要があります。

  しかしながら、現在ではRaspberry Pi公式のVS Code(プログラムを書くためのエディタ)向け拡張機能が出ています。マウス操作で直接CMakeを書くことなく、初期設定を行えるようになっており、Pico SDKでの開発の敷居が大きく下がりました。いい時代になりましたね。
]
