protocol Group : Equatable {
    static func *(a: Self, b: Self) -> Self
    static var identity:  Self {get}
    var inverse: Self {get}
}

extension Group {
    static func testAssociativity(a: Self, _ b: Self, _ c: Self) -> Bool {
        return (a * b) * c == a * (b * c)
    }
    static func testIdentity(a: Self) -> Bool {
        return (a * Self.identity == a) && (Self.identity * a == a)
    }
    static func testInverse(a: Self) -> Bool {
        return (a * a.inverse == Self.identity) && (a.inverse * a == Self.identity)
    }
}

protocol AdditiveGroup : Equatable {
    static func +(a: Self, b: Self) -> Self
    prefix static func -(a: Self) -> Self
    static var zero: Self { get }
}
extension AdditiveGroup {
     var isZero: Bool {
        self == .zero
    }
}

typealias Z = Int

extension Z: AdditiveGroup {
    static var zero: Z {return 0 }
}

func testGroup() {
    print("--- testGroup ---");
    let a : Z = 1;
    let b : Z = 2;
    print("a = \(a)");
    print("b = \(b)");
    print("a + b = \(a + b)");
    print("-a = \(-a)");    
    print("-b = \(-b)");
    print("--- testGroup end---");
}