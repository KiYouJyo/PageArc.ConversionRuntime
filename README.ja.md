# PageArc.ConversionRuntime

PageArc.ConversionRuntime は、PageArc のオプション電子書籍変換ランタイムを本体とは別に配布するためのリポジトリです。

## 目的

PageArc の基本リーダーを軽量に保つため、容量の大きい calibre ランタイムを MSIX に同梱しません。変換機能などで `ebook-convert` が必要になった時だけダウンロードします。

## 現在のランタイム

- calibre 9.13.0
- パッケージリビジョン: 9.13.0-pagearc.1
- Windows x64
- アーカイブ: `PageArc.ConversionRuntime-win-x64.zip`
