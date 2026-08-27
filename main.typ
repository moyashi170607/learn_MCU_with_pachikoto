#import "typst-oreilly-template/book.typ": *

#show: layout.with(
  title: [パチ言と学ぶマイコン入門],
  author: [こつ子],
  publisher: [岡山大学電子計算機研究会],
  // フォントの設定
  fonts: (
    sans-serif: "Hiragino Kaku Gothic ProN",
    serif: "Hiragino Mincho ProN",
    mono: "UDEV Gothic 35NFLG",
  ),
)

#show: document

...
#include "intro/intro.typ"

#include "overview/overview.typ"
