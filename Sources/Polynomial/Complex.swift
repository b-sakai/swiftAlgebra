
func testComplex() {
    print("--- testComplex ---")
    // g(x) = x^2 + 1 を保持する型
    struct g: TPPolynomial {
        typealias K = R
        static let value: Polynomial<R> = Polynomial<R>(coeffs: [1, 0, 1])
    }

    typealias C = PolynomialQuotient<g>  // C = R[x]/(x^2 + 1)

    let i = C(Polynomial<R>(coeffs: [0, 1]))    // i = √-1
    print(i.f * i.f)    
    print(i.f * i.f == Polynomial<R>(coeffs: [-1]))            // true

    let z = C(Polynomial<R>(coeffs: [3, 2]))      // z = 3 + 2i
    print(z.f * z.f)    // 5 + 12i

    print("--- testComplex end ---")
}