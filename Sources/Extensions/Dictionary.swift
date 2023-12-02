public extension Dictionary {
     @inlinable
    init<S: Sequence>(_ pairs: S) where S.Element == (Key, Value) {
        self.init(uniqueKeysWithValues: pairs)
    }
}