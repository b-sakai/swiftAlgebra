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