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
    Pico用のArduinoコアをインストールしよう。
  ]
]

今回はRaspberry Pi Pico用のArduinoコアとしてEarle F. Philhower, III氏の「Arduino-Pico」を用います。こちらは公式ではなくコミュニティで開発されているものですが、非常に有用で事実上の標準環境となっています。

- Arduino-Picoのリポジトリ https://github.com/earlephilhower/arduino-pico

それでは画面左上の「File > Preferences」からPreferencesを開きましょう。

#figure(
  caption: "File > Preferences",
)[
  #image("img/preferences.png")
]

#figure(
  caption: "Additional boards manager URLs",
)[
  #image("img/preferences2.png")
]

次に、その中にある「Additional boards manager URLs」を探し、その右側のボタンを押してください。
そこにURLを入力することで、対応したボードの情報をIDEに追加することができます。
今回は以下のURLを追加して「OK」を押してください。

```
https://github.com/earlephilhower/arduino-pico/releases/download/global/package_rp2040_index.json
```

#figure(
  caption: "ボードを追加",
)[
  #image("img/add_board.png")
]

追加できたら、左側のタブの2番目の「BOARD MANAGER」を押し、検索窓に「Raspberry Pi Pico/RP2040」と入力しましょう。
正しく追加できていたら、「Raspberry Pi Pico/RP2040 by Earle F. Philhower, III」というものが表示されるはずです。
出てきたら「Install」を押してインストールします。
「Arduino Mbed OS RP2040 Boards」は別のものなので注意しましょう。

#talk[
  #パチケモ[
    そこそこ時間がかかるので、気長に待とうね。\
    途中で要求されるドライバも忘れずインストールしてね
  ]
  #パチ言[うお～！ワクワクしてきた～！]
]

インストールが無事完了したら「Install」だった場所が「Remove」になっているはずです。

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
