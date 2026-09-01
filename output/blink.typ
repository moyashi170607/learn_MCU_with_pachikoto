#import "../chara.typ": *
#import "@preview/simple-todo:0.1.0": list-todos, todo
#import "@preview/showybox:2.0.4": showybox
#import "@preview/codelst:2.0.2": sourcecode

= GPIO出力

== Lチカ

=== 概要

#talk[
  #パチケモ[じゃぁついにマイコン入門の鉄板、「Lチカ」に挑戦しよう！]
  #パチ言[Lチカ is 何？]
  #パチケモ[
    「L」は「LED」のことで、「チカ」は「チカチカと点滅させる」ということだよ。\
    LチカができるようになったらGPIOの出力はできるようになったといっても過言じゃないよ！
  ]
  #パチ言[
    ちょっと待ってよ。\
    LEDが出てきたと思ったら次はGPIOって。
  ]
  #パチケモ[
    まぁまぁ落ち着いて。\
    LEDは電子工作で「光」を取り扱うときによく使うパーツで、特定の方向に電流を流すと光るパーツだよ。\
    GPIOは、「マイコンと外の回路でやり取りをするための出入り口」って感じかな。\
    実際に触ってみた方が分かりやすいと思うから詳しくは、後で説明するよ。
  ]
  #パチ言[そういうことなら早く触らせてくれ。]
  #パチケモ[
    ほとんどのマイコンボードにはテスト用に初めからLEDが一つ付いているんだ。\
    まずはこれを光らせてみよう。
  ]
]

=== 新規Sketchの作成

Arduino IDEではプログラムは「Sketch」というファイルで管理されます。
画面左上の「File > New Sketch」から新しいSketchを書き始めましょう。

新しいウィンドウが開いたら、画面左上の「Select Board」を押し、「Select Other Board and Port」を選びましょう。

開いたら検索窓「Raspberry Pi Pico」と入力し、「Raspberry Pi Pico - Raspberry Pi Pico/RP2040/RP2350」というものを選んでください。

#figure(
  caption: "Select Board",
)[
  #image("img/select_board.png")
]

=== setup関数とloop関数

#talk[
  #パチケモ[これで、ボードを選択できたね。]
  #パチ言[これでArudino IDEでPicoのファームウェアをようやく書くことができるわけだな]
  #パチケモ[
    新しいスケッチに始めから`setup`関数と`loop`関数があるよね。\
    これは特別な役割を持つ関数なんだ。
  ]
]

`setup`関数はマイコンが起動したときなど、プログラムが開始されたときに、まず最初に1度だけ実行される関数です。この関数の中では主に、マイコンやモジュールの初期化、ピンの設定を行います。

一方で`loop`関数は`setup`関数が実行された後に、繰り返し実行される関数です。`loop`関数の処理が終わるとまた`loop`関数の始めに戻り実行されます。ここで、主にマイコンの制御プログラムを書いていくことになります。

=== GPIO

#talk[
  #パチケモ[
    つまり、`setup`関数で今回使うLEDにつながっているGPIOの設定をして、`loop`関数でうまくチカチカするようにすれば良いということだね。\
    GPIOにはそれぞれ固有の番号が振られているんだ。\
    その番号を使ってプログラミングから設定できるよ。
  ]

  #パチ言[
    それで結局GPIOって何なの。
  ]

  #パチケモ[
    GPIOは正式名称は「General Purpose Input/Output」、日本語では「汎用入出力」って言うんだ。\
    マイコンから回路に電圧をかけたり、逆に回路の電圧を読み取ったりすることができるよ。\
    今回みたいにLEDを光らせるのにも使うし、他にもブザーを鳴らしたり、ボタンが押されたことを検知したりするのにも使うんだ。\
    GPIOは一部を除いて原則ユーザーが自由に使い方を決めることができるんだ。\
    つまりGPIOは他の部品や回路とプログラムを結ぶ窓口なんだ。
  ]

  #パチ言[なるほどね。マイコンの主役ってわけだ。]

  #パチケモ[これが純正のRaspberry Pi Picoのピン配置だよ]
]

#figure(
  caption: "Raspberry Pi Picoのピン配置",
)[
  #image("img/rp_pin.png")
  #v(0.4em)
  #text(size: 0.7em)[
    出典: Raspberry Pi Ltd「Raspberry Pi Pico-series Microcontrollers」\
    #link("https://www.raspberrypi.com/documentation/microcontrollers/pico-series.html") \
    #link("https://creativecommons.org/licenses/by-sa/4.0/")[CC BY-SA 4.0]
  ]
]

#talk[
  #パチケモ[色々と書いていある中にの「GP」っていうのがGPIOのこと、その後に続く番号はそのGPIOに割り当てられている番号だね。]

  #パチ言[あの、「LED（GP25）」ってなってるやつが、マイコンにあらかじめついているLEDで今回使うGPIOか？]

  #パチケモ[
    そう！勘がいいね。\
    他にもいろいろピンごとに役割があるけど、それは後で説明するよ。\
    今はLチカが先！
  ]
]

=== ファームウェアの開発

では、GPIO25を使ってLチカをしていきましょう。

まずはLEDを光らせる、つまりGPIOの電圧をマイコンが変更できる状態にする必要があります。
そのためにはGPIOをOUTPUTモードします。

Arduino APIではGPIOのモードの設定は`pinMode`関数で行います。


#showybox()[
  ```c
  pinMode( GPIOの番号 , モード);
  ```
]

つまり今回の場合は`setup`関数で次のようにすればよいのです。

#showybox()[
  ```c
  void setup(){
    pinMode(25,OUTPUT);
  }
  ```
]

`pinMode`関数で`OUTPUT`モードにしたGPIOは`digitalWrite`関数で`HIGH`または`LOW`に電圧を設定することができます。
`HIGH`に設定されたGPIOは約3.3Vを、`LOW`に設定されたGPIOは0Vを回路にかけます。
つまり、`HIGH`をGPIO25に設定すればLEDが点灯し、`LOW`を設定すればLEDが消えます。

`digitalWrite`関数の使い方は以下の通りです。

#showybox()[
  ```c
  digitalWrite( GPIOの番号 , HIGH or LOW);
  ```
]

また、`delay`関数は指定した時間、処理を待機させることができます。
指定する時間はミリ秒単位である点に注意しましょう。

#showybox()[
  ```c
  delay(待機する時間ミリ秒);
  ```
]

これらを用いて、「HIGHのする #sym.arrow.r 1000ms待機 #sym.arrow.r LOWにする #sym.arrow.r 1000ms待機する」を繰り返せば、Lチカをすることができますね。

というわけで、`loop`関数の中身は以下のようになります。


#showybox()[
  ```c
  void loop(){
    digitalWrite( 25 , HIGH);
    delay(1000);
    digitalWrite( 25, LOW);
    delay(1000);
  }
  ```
]

Lチカ全体のコードは以下のようになります。

#showybox()[
  ```c
  void setup(){
    pinMode(25,OUTPUT);
  }

  void loop(){
    digitalWrite( 25 , HIGH);
    delay(1000);
    digitalWrite( 25, LOW);
    delay(1000);
  }
  ```
]

=== ファームウェアの書き込み

#talk[
  #パチケモ[
    さぁファームウェアができたら、それをRaspberry Pi Picoに書き込もう。\
    Picoについている「BOOTSELボタン」を押しながらPicoにつないだUSBケーブルをPCにつなぐと、ファームウェアを書きこめるモードにすることができるよ。
  ]
]

#figure(
  caption: "ケーブルを差し込む",
)[
  #image("img/rp_connect.jpg")
]

#talk[

  #パチ言[なんかUSBつないだ時みたいなの出てきたぞ]

  #パチケモ[
    BOOTSELモードでは、PicoがUSBのように振る舞うようになるんだ。\
    この状態でファームウェアを直接放り込むことでも書き込めるけど、
    今回はArduino IDEについている書き込み機能を使おう。\
    Arduino IDE画面左上の右矢印みたいなアイコンのUploadボタンを押すことで、プログラムのコンパイル、書き込みができるよ。
  ]
]

#figure(
  caption: "uploadボタン",
)[
  #image("img/upload.png")
]

#talk[

  #パチ言[
    ところでコンパイルって何？
  ]

  #パチケモ[
    Arduino IDEではC言語を用いてファームウェアの開発をするんだけど、
    C言語はそのままでは機械は理解できないんだ。\
    機械が理解できる形式を機械語と言うよ。\
    C言語から、より機械語に近い形であるアセンブリ言語に変換することをコンパイルというよ。\
    今回みたいに、開発に使っている機械とは異なる機械に向けてコンパイルすることをクロスコンパイルとも言うね。\
    そして、コンパイルしたものを機械が直接理解できる機械語にして、
    実行できる一つのファイルにまとめるまでの一連の流れを「ビルド」と呼ぶんだ。
    環境構築のときに出てきた言葉だね。
  ]

  #パチ言[はぇ～結構裏でIDEが色んなことしてくれてるんだね。]
]

コンパイルおよびファームウェアの書き込みには少し時間がかかります。
書き込みが正常に終われば、画面下の「Output」の場所に赤文字のエラーが出ないはずです。
もしうまく書き込めたなら、ボードのUSBケーブル用コネクタ付近で緑色のLEDが点滅していることを確認しましょう。

#figure(
  caption: "Lチカ",
)[
  #image("img/led.jpg")
]


#talk[
  #パチケモ[さぁ！ここまで少しファームウェアを自分で改造して練習してみよう！]
]

#showybox()[
  *演習問題*

  + 現在は1秒ごとにLEDのON/OFFが切り替わるが、これを0.5秒ごとにするにはどうしたらよいだろう
  + LEDでSOS（・・・ ---・・・）を繰り返し送信してみよう。短点は0.2秒、長点は0.6秒とする。
]

== 外付けのLEDもチカチカさせる

#talk[
  #パチ言[いや～Lチカ楽しかったね]
  #パチケモ[次は、内蔵LEDじゃなくて実際に自分で回路を組んでLチカをしてみよう！]
  #パチ言[(またLチカか...)]
  #パチケモ[そう思うかもしれないけど、自分で回路を組むことが電子工作の醍醐味の一つだからね]
  #パチ言[なんでコイツ、私の脳内を...ッ！]
]
