protocol Monoid: Equatable {
    static func *(a: Self, b: Self) -> Self
    static var identity: Self {get}
}
extension Monoid {
    func pow(_ n: Int) -> Self {
        switch n {
        case 0:
            return .identity
        case 1:
            return self
        case _ where n > 0:
            return (0 ..< n - 1).reduce(self){ (res, _) in
                res * self
            }
        default:
            fatalError()
        }
    }
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

func gcd(_ a: Z, _ b: Z) -> Z {
    switch b {
    case 0:
        return a
    default:
        return gcd(b, a % b)
    }
}

struct Matrix {
    var a, b, c, d: Z
    init(_ aa: Z,_ ab: Z, _ ac: Z, _ ad: Z) {
        a = aa
        b = ab
        c = ac
        d = ad
    }
    static var identity: Self {
        Self(1, 0, 0, 1)
    }
}
func tupleDot(_ v1: (Z, Z), _ v2: (Z, Z)) -> Z {
    return v1.0 * v2.0 + v1.1 * v2.1
}
func *(m1: Matrix, m2: Matrix) -> Matrix {
    let m1row0 = (m1.a, m1.b)
    let m1row1: (Z, Z) = (m1.c, m1.d)
    let m2col0: (Z, Z) = (m2.a, m2.c)
    let m2col1: (Z, Z) = (m2.b, m2.d)
    return Matrix(
        tupleDot(m1row0, m2col0),
        tupleDot(m1row0, m2col1),
        tupleDot(m1row1, m2col0),
        tupleDot(m1row1, m2col1)
    )
}

func bezout(_ a: Z, _ b: Z) -> (x: Z, y: Z, d: Z) {
    typealias M = Matrix

    func euclid(_ a: Z, _ b: Z, _ qs: [Z]) -> (qs: [Z], d: Z) {
        switch b {
        case 0:
            return (qs, a)
        default:
            let (q, r) = (a / b, a % b)
            return euclid(b, r, [q] + qs)
        }
    }

    let (qs, d) = euclid(a, b, [])

    let m = qs.reduce(M.identity) { (m: M, q: Z) -> M in
        m * M(0, 1, 1, -q)
    }

    return (x: m.a, y: m.b, d: d)
}

func testBezout() {
    print("--- testBezout ---")
    let (x, y, d) = bezout(1732, 194)
    print("x, y, d = \(x), \(y), \(d)")
    print("Matrix.identity * Matrix.identity = \(Matrix.identity * Matrix.identity)")
    print("1732 * x + 194 * y = \(1732 * x + 194 * y)")
    print("d = \(d)")
    print("--- testBezout end ---")
}