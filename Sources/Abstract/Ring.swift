protocol Monoid: Equatable {
    static func *(a: Self, b: Self) -> Self
    static var identity: Self {get}
}

protocol Ring: AdditiveGroup, Monoid {
    init(_ initValut: Int)
}

// default implementation
extension Ring {
    static var zero: Self {
        return Self.init(0)
    }

    static var identity: Self {
        return Self.init(1)
    }
}

extension Z: Ring { }