protocol TPPolynomial {
    associatedtype K: Field
    static var value: Polynomial<K> { get }
}

struct PolynomialQuotient<g: TPPolynomial> : Equatable {
    typealias K = g.K

    let f: Polynomial<K>

    init(_ f: Polynomial<K>) {
        self.f = f
    }

    static var zero: PolynomialQuotient<g> {
        Self.init(Polynomial<K>.zero)
    }


    static func +<g: TPPolynomial>(lhs: PolynomialQuotient<g>, rhs: PolynomialQuotient<g>) -> PolynomialQuotient<g> {
        return PolynomialQuotient<g>(lhs.f + rhs.f)
    }

    static func -<g: TPPolynomial>(lhs: PolynomialQuotient<g>, rhs: PolynomialQuotient<g>) -> PolynomialQuotient<g> {
        return PolynomialQuotient<g>(lhs.f - rhs.f)
    }

    static func *<g: TPPolynomial>(lhs: PolynomialQuotient<g>, rhs: PolynomialQuotient<g>) -> PolynomialQuotient<g> {
        return PolynomialQuotient<g>(lhs.f + rhs.f)        
    }
    static func ==<g: TPPolynomial>(x: PolynomialQuotient<g>, y: PolynomialQuotient<g>) -> Bool {
        let (q, r) = Polynomial<g.K>.eucDiv((x.f - y.f), g.value)
        return r == Polynomial<g.K>.zero
    }
}

func testPolynomialQuotient() {
    print("--- testPolynomialQuotient ---")
    struct g: TPPolynomial { // g(x) = x^2 + 1を保持する型
        typealias K = Q
        static let value: Polynomial<Q> = Polynomial<Q>(coeffs: [1, 0, 1])
    }
    typealias L = PolynomialQuotient<g>
    let f = Polynomial<Q>(coeffs: [2, -3, 1, 2]) // 2x^3 + x^2 - 3x + 2
    let fmod = L(f)
    let r = L(Polynomial<Q>(coeffs: [1, -5]))
    print(g.value)
    print(fmod)
    print(r)
    print(fmod == r)

    let f1 = Polynomial<Q>(coeffs: [0, 2, -3, 1])  // x^3 - 3x^2 + 2x
    let g1 = Polynomial<Q>(coeffs: [6, -5, 1])     // x^2 - 5x + 6
    print(gcd(f1, g1))  // 6x - 12
    let (p1, q1, r1) = bezout(f1, g1)
    print(p1)  // 1
    print(q1)  // -x - 2
    print(r1)  // 6x - 12
    print(f1 * p1 + g1 * q1 == r1)  // true


    let f2 = Polynomial<Q>(coeffs: [1, 1])  // x + 1
    let g2: Polynomial<Q> = Polynomial<Q>(coeffs: [-2, 0, 1]) // x^2 - 2

    let (p2, q2, r2) = bezout(f2, g2)
    print(p2) // -x + 1
    print(q2) // -x - 2
    print(r2) // -1

    print(f2 * (-p2)) // x^2 - 1
    print(f2 * (-p2) % g2 == -r2) // true

    print("--- testPolynomialQuotient end---")
}