struct Q : Field {
    let p, q: Z

    init(_ p: Z, _ q: Z) {
        if q == 0 {
            fatalError("donom: 0")
        }
        self.p = p
        self.q = q
    }
    init(_ n: Z) {
        self.init(n, 1)
    }

    var inverse: Q {
        return Q(q, p)
    }
}

func ==(a: Q, b: Q) -> Bool {
    return a.p * b.q == a.q * b.p
}

func +(a: Q, b: Q) -> Q {
    return Q(a.p * b.q + a.q * b.p,
             a.q * b.q)
}

prefix func -(a: Q) -> Q {
    return Q(-a.p, a.q)
}

func *(a: Q, b: Q) -> Q {
    return Q(a.p * b.p, a.q * b.q)
}

// Int型のリテラルからQ型を作成するための型拡張
extension Q : ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}

// printされたときの見た目を整えるための型拡張
extension Q : CustomStringConvertible {
    var description: String {
        switch q {
            case 1: return "\(p)"
            case -1: return "\(-p)"
            default: return "\(p)/\(q)"
        }
    }
}

func testRational() {
    print("--- testRational ---")
    let a = Q(1, 2)
    let b = Q(2, 4)
    let c = Q(1, 3)
    print("a = \(a)")
    print("b = \(b)")
    print("a == b = \(a == b)")
    print("a == c = \(a == c)")
    print("-a = \(-a)")
    print("a * c = \(a * c)")
    print("a.inverse = \(a.inverse)")
    print("--- testRational end ---")
}