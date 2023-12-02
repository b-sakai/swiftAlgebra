protocol Field: Group, Ring {}

extension Field {
    static func / (a: Self, b: Self) -> Self {
        a * b.inverse
    }
}

typealias R = Double
extension R: Field {
    static var zero: R {
        0
    }
    var inverse: R {
        1 / self
    }
}

func testField() {
    print("--- testField ---");
    let a : R = 1;
    let b : R = 2;
    print("a = \(a)");
    print("b = \(b)");
    print("a + b = \(a + b)");
    print("-a = \(-a)");    
    print("-b = \(-b)");    
    print("a.inverse = \(a.inverse)");    
    print("b.inverse = \(b.inverse)");
    print("--- testField end ---");
}