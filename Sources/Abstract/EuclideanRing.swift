protocol EuclideanRing: Ring {
    static func eucDiv(_ a: Self, _ b: Self) -> (q: Self, r: Self)
}
func %<R: EuclideanRing>(a: R, b: R) -> R {
    return R.eucDiv(a, b).r
}
func /<R: EuclideanRing>(a: R, b: R) -> R {
    return R.eucDiv(a, b).q
}
extension Z: EuclideanRing {
    static func eucDiv(_ a: Z, _ b: Z) -> (q: Z, r: Z) {
        return (q: a/b, r: a%b)
    }
}
func gcd<R: EuclideanRing>(_ a: R, _ b: R) -> R {
    switch b {
    case R.zero:
        return a
    default:
        return gcd(b, a % b)
    }
}
func bezout<R: EuclideanRing>(_ a: R, _ b: R) -> (x: R, y: R, d: R) {
    typealias M = Matrix

    func euclid(_ a: R, _ b: R, _ qs: [R]) -> (qs: [R], d: R) {
        switch b {
        case R.zero:
            return (qs, a)
        default:
            let (q, r) = (a / b, a % b)
            return euclid(b, r, [q] + qs)
        }
    }

    let (qs, d) = euclid(a, b, [])

    let m = qs.reduce(M<R>.identity) { (m: M, q: R) -> M in
        m * M(R(0), R(1), R(1), -q)
    }

    return (x: m.a, y: m.b, d: d)
}

func testEuclideanRing() {
    print("--- testEuclideanRing ---")
    let f = Polynomial<Q>(coeffs: [0, 2, -3, 1])  // x^3 - 3x^2 + 2x
    let g = Polynomial<Q>(coeffs: [6, -5, 1])     // x^2 - 5x + 6
    print(gcd(f, g))  // 6x - 12
    let (p, q, r) = bezout(f, g)
    print(p)  // 1
    print(q)  // -x - 2
    print(r)  // 6x - 12
    print(f * p + g * q == r)  // true

    print("--- testEuclideanRing end---")
}