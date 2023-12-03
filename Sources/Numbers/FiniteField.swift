struct F_<p: TPInt>: Field {
    var value: Z
    var zero: Self {
        Self(0)
    }
    var inverse: F_<p> {
        if value == 0 {
            fatalError("0-inverse")
        }

        // find: a * x + p * y = 1
        // then: a^-1 = x (mod p)
        let (x, _, r) = bezout(value, p.value)

        if r != 1 {
            fatalError("\(p.value) is non-prime.")
        }

        return Self(x)
    }
    init(_ a: Z) {
        self.value = a
    }
}
extension F_ : ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}
extension F_ : CustomStringConvertible {
    var description: String {
        return "\(value % p.value)"
    }
}
func ==<p: TPInt>(a: F_<p>, b: F_<p>) -> Bool {
    return (a.value - b.value) % p.value == 0
}
func +<n: TPInt>(a: F_<n>, b: F_<n>) -> F_<n> {
    return F_<n>(a.value + b.value)
}
prefix func -<n: TPInt>(a: F_<n>) -> F_<n> {
    return F_<n>(-a.value)
}
func *<n: TPInt>(a: F_<n>, b: F_<n>) -> F_<n> {
    return F_<n>(a.value * b.value)
}
typealias F_2 = F_<TPInt_2>
typealias F_3 = F_<TPInt_3>
typealias F_5 = F_<TPInt_5>

func testFiniteField() {
    let values2: [F_2] = [0, 1]
    print("F_2 pow table")
    F_2.printExpTable(values: values2, upTo: 1)

    let values3: [F_3] = [0, 1, 2]
    print("F_3 pow table")
    F_3.printExpTable(values: values3, upTo: 2)    

    let values5: [F_5] = [0, 1, 2, 3, 4]
    print("F_5 pow table")
    F_5.printExpTable(values: values5, upTo: 4)
}