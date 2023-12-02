protocol TPInt {
    static var value: Int { get }
}

// simple diffinition
// struct TPInt_5 : TPInt {
//    static let value = 5
// }

// peano style diffinition
struct TPInt_0 : TPInt {
    static let value = 0
}
struct TPInt_Succ<n: TPInt> : TPInt {
    static var value: Int {
        return n.value + 1
    }
}
typealias TPInt_1 = TPInt_Succ<TPInt_0>
typealias TPInt_2 = TPInt_Succ<TPInt_1>
typealias TPInt_3 = TPInt_Succ<TPInt_2>
typealias TPInt_4 = TPInt_Succ<TPInt_3>
typealias TPInt_5 = TPInt_Succ<TPInt_4>
typealias TPInt_6 = TPInt_Succ<TPInt_5>

// 整数剰余類環
struct Z_<n: TPInt> : Ring, MathSet {
    var mod: Int {
        return n.value
    }

    let value: Z

    init(_ value: Int) {
        self.value = value
    }
}

extension Z_ : ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}

extension Z_ : CustomStringConvertible {
    var description: String {
        return "\(value % mod)"
    }
}

func ==<n: TPInt>(a: Z_<n>, b: Z_<n>) -> Bool {
    return (a.value - b.value) % n.value == 0
}

func +<n: TPInt>(a: Z_<n>, b: Z_<n>) -> Z_<n> {
    return Z_<n>(a.value + b.value)
}
prefix func -<n: TPInt>(a: Z_<n>) -> Z_<n> {
    return Z_<n>(-a.value)
}
func *<n: TPInt>(a: Z_<n>, b: Z_<n>) -> Z_<n> {
    return Z_<n>(a.value * b.value)
}

typealias Z_5 = Z_<TPInt_5>
typealias Z_6 = Z_<TPInt_6>

func testIntegerQuotient() {
    print("--- testIntegerQuotient ---")
    let a: Z_5 = 2
    let b: Z_5 = 37 
    print("a = \(a)")
    print("b = \(b)")
    print("a == b \(a == b)")    
    let values: [Z_5] = [0, 1, 2, 3, 4]
    print("Z_5 add table")
    Z_5.printAddTable(values: values)
    print("Z_5 mul table")
    Z_5.printMulTable(values: values)
    let values6: [Z_6] = [0, 1, 2, 3, 4, 5]
    print("Z_6 add table")
    Z_6.printAddTable(values: values6)
    print("Z_6 mul table")
    Z_6.printMulTable(values: values6)    
    print("--- testIntegerQuotient end ---")    
}

