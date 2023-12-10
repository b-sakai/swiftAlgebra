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
        let (q, r) = eucDiv((x.f - y.f), g.value)
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
    print("--- testPolynomialQuotient end---")
}