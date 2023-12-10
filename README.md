# Swiftで代数学入門

https://qiita.com/taketo1024/items/bd356c59dc0559ee9a0b
の記事の個人的練習記録

main.swiftで基本的なそれぞれの代数構造（Z, R, Qなど）のテストコードを呼ぶようにしているので、
```
swift run
```
でテスト実行可能

記事の著者のリポジトリは以下なのでこちらも参考にした
protocols -> https://github.com/taketo1024/swm-core/tree/main/Sources/SwmCore/Abstract
structs -> https://github.com/taketo1024/swm-core/tree/main/Sources/SwmCore/Numbers

### 記事との違い

* それぞれのstructファイルにおけるテスト関数は適当に自分で考えて定義した
* IntegerLiteralConvertibleは最新のコンパイラだと使えなかったので、代替プロトコルである ExpressibleByIntegerLiteralを利用した
* Qitaの記事にはすべての定義は乗っておらず、自前で実装している
* 著者のリポジトリの過去のコミットも探してみたが、記事のテストコードが動くようなコミットは結局探し当てられなかった
* 「体としての剰余環」、C（と行ってもこれもテストコードの中で定義しただけでだが）以外の拡大体は未実装