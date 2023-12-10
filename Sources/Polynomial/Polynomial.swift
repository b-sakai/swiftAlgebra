struct Polynomial<K: Field> : Equatable {
    private let coeffs: [K] // K型の係数リスト

    init(coeffs: [K]) {
        self.coeffs = coeffs
    }
    init(degree: Int, gen: ((Int) -> K)) {
        let coeffs = (0 ... degree).map(gen)
        self.init(coeffs: coeffs)
    }
    init(degree: Int, coeff: K) {
        let coeffs = (0 ... degree).map({ d in
            (d == degree) ? coeff : K(0)
        })
        self.init(coeffs: coeffs)
    }
    static var zero: Self {
        Self.init(coeffs: [K(0)])
    }

    var degree: Int {
        let n = coeffs.count - 1
        for i in 0 ..< n {
            if coeffs[n-i] != K(0) {
                return n - i
            }
        }
        return 0
    }
    subscript(n: Int) -> K {
        return (n <= degree) ? coeffs[n] : K(0)
    }
    func apply(x: K) -> K {
        return (0 ... degree).reduce(K(0)) { (sum, i) -> K in
            sum + self[i] * x.pow(i)
        }
    }

    public static func == (a: Self, b: Self) -> Bool {
        a.coeffs.exclude{ $0.isZero } == b.coeffs.exclude{ $0.isZero }
    }
}
func +<K: Field>(f: Polynomial<K>, g:Polynomial<K>) -> Polynomial<K> {
    let n = max(f.degree, g.degree)
    return Polynomial<K>(degree: n) { i in f[i] + g[i] }
}
func -<K: Field>(f: Polynomial<K>, g:Polynomial<K>) -> Polynomial<K> {
    let n = max(f.degree, g.degree)
    return Polynomial<K>(degree: n) { i in f[i] + (-g[i]) }
}
prefix func -<K: Field>(f: Polynomial<K>) -> Polynomial<K> {
    return Polynomial<K>(degree: f.degree) { i in -f[i] }
}
func *<K: Field>(f: Polynomial<K>, g: Polynomial<K>) -> Polynomial<K> {
    return Polynomial(degree: f.degree + g.degree) { (i: Int) in
        (0 ... i).reduce(K(0)) {
            (res, j) in res + f[j] * g[i - j]
        }
    }
}
func eucDiv<K: Field>(_ f: Polynomial<K>, _ g: Polynomial<K>) -> (q: Polynomial<K>, r: Polynomial<K>) {
    // 0-div error
    if g == Polynomial<K>.zero {
        fatalError("divide by 0")
    }
    // 単項式で最高次だけ削る補助関数
    func eucDivMonomial(_ f: Polynomial<K>, _ g: Polynomial<K>) -> (q: Polynomial<K>, r: Polynomial<K>) {
        let n = f.degree - g.degree
        // 除数の次数の方が大きい場合は被除数がそのまま余り
        if n < 0 {
            return (Polynomial<K>.zero, f)
        } else {
            let a = f[f.degree] / g[g.degree] // 最高次係数の比
            let q = Polynomial<K>(degree: n, coeff: a) // 次数n係数aの単項式
            let r = f + ( -(q * g)) // 被除数からq*gを引く
            return (q, r)
        }
    }
    return (0 ... max(0, f.degree - g.degree))
    .reversed()
    .reduce((Polynomial<K>.zero, f)) { (result: (Polynomial<K>, Polynomial<K>), degree: Int) in
        let (q, r) = result
        let m = eucDivMonomial(r, g)
        return (q + m.q, m.r)
    }
}

func testPolynomial() {
    print("--- testPolynomial ---")
    let f = Polynomial<Q>(coeffs: [2, -3, 1])
    print(f)
    print(f.degree)
    print(f[2])
    print(f.apply(x: 0))
    print(f.apply(x: 1))
    let g = Polynomial<Q>(degree: 2) { i in Q(i + 1) }  //  3x^2 + 2x + 1
    print(g)

    let f1 = Polynomial<Q>(coeffs: [2, -3, 1, 2])  // 2x^3 + x^2 - 3x + 2
    let g1 = Polynomial<Q>(coeffs: [1, 0, 1])      // x^2 + 1
    let (q, r) = eucDiv(f1, g1)
    print(q)                                    // 2x + 1
    print(r)                                    // -5x + 1
    print(f1 == (g1 * q) + r)                       // true
    print("--- testPolynomial test ---")    
}