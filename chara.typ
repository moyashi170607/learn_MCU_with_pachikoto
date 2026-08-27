// 会話パート
#let say(name, body) = block(
  width: 100%,
  grid(
    // 話者名は最大4文字を想定
    columns: (4.5em, 1fr),
    gutter: 0.7em,
    align: (right + top, left + top),
    {
      // strongのshowルールでゴシックになる
      set text(size: 8pt)
      strong(name)
    },
    {
      // セリフの中では字下げしない
      set par(first-line-indent: 0em)
      body
    },
  ),
)

// 話者を固定したsayを作る
#let speaker(name) = say.with(name)

// 続けざまのセリフをひと塊にまとめる
// 中のセリフどうしは詰めて、地の文との間には少し隙間を開ける
#let talk(
  // 地の文との間の空き
  spacing: 1.6em,
  // セリフどうしの間の空き
  inner: 0.45em,
  body,
) = block(
  above: spacing,
  below: spacing,
  width: 100%,
  {
    set block(above: inner, below: inner)
    body
  },
)

// 登場人物
// #include されたファイルからは main.typ の #let が見えないので、キャラクターの定義はここに置いて各章から #import する
#let パチ言 = speaker([パチ言])
#let パチケモ = speaker([パチケモ])

// 打ちやすい短縮名（#p[…] / #k[…]）
#let p = パチ言
#let k = パチケモ
