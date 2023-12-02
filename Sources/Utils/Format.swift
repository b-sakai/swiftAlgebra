public struct Format {
    public static func sup(_ i: Int) -> String {
        sup(String(i))
    }
    
    public static func sup(_ s: String) -> String {
        String( s.map { c in
            switch c {
            case "0": return "⁰"
            case "1": return "¹"
            case "2": return "²"
            case "3": return "³"
            case "4": return "⁴"
            case "5": return "⁵"
            case "6": return "⁶"
            case "7": return "⁷"
            case "8": return "⁸"
            case "9": return "⁹"
            case "+": return "⁺"
            case "-": return "⁻"
            case "(": return "⁽"
            case ")": return "⁾"
            case ",": return " ̓"
            default: return c
            }
        } )
    }
    
    public static func sub(_ i: Int) -> String {
        sub(String(i))
    }
    
    public static func sub(_ s: String) -> String {
        String( s.map { c in
            switch c {
            case "0": return "₀"
            case "1": return "₁"
            case "2": return "₂"
            case "3": return "₃"
            case "4": return "₄"
            case "5": return "₅"
            case "6": return "₆"
            case "7": return "₇"
            case "8": return "₈"
            case "9": return "₉"
            case "+": return "₊"
            case "-": return "₋"
            case "(": return "₍"
            case ")": return "₎"
            case ",": return " ̦"
            case "*": return " ͙"
            default: return c
            }
        } )
    }
    
    public static func symbol(_ x: String, _ i: Int) -> String {
        "\(x)\(sub(i))"
    }
    
    public static func power<X: CustomStringConvertible>(_ x: X, _ n: Int) -> String {
        let xStr = x.description
        return n == 0 ? "1" : n == 1 ? xStr : "\(xStr)\(sup(n))"
    }
    
  
    public static func table<S1, S2, T>(rows: S1, cols: S2, symbol: String = "", separator s: String = "\t", printHeaders: Bool = true, op: (S1.Element, S2.Element) -> T) -> String
    where S1: Sequence, S2: Sequence {
        let head = printHeaders ? [[symbol] + cols.map{ y in "\(y)" }] : []
        let body = rows.enumerated().map { (i, x) -> [String] in
            let head = printHeaders ? ["\(x)"] : []
            let line = cols.enumerated().map { (j, y) in
                "\(op(x, y))"
            }
            return head + line
        }
        return (head + body).map{ $0.joined(separator: s) }.joined(separator: "\n")
    }
    
    public static func table<S, T>(elements: S, default d: String = "", symbol: String = "j\\i", separator s: String = "\t", printHeaders: Bool = true) -> String
    where S: Sequence, S.Element == (Int, Int, T) {
        let dict = Dictionary(elements.map{ (i, j, t) in ([i, j], t) } )
        if dict.isEmpty {
            return "empty"
        }
        
        let I = dict.keys.map{ $0[0] }.uniqued().sorted()
        let J = dict.keys.map{ $0[1] }.uniqued().sorted()
        
        return Format.table(rows: J.reversed(),
                            cols: I,
                            symbol: symbol,
                            separator: s,
                            printHeaders: printHeaders)
        { (j, i) -> String in
            dict[ [i, j] ].map{ "\($0)" } ?? d
        }
    }
    
    public static func table<S, T>(elements: S, default d: String = "", symbol: String = "i", separator s: String = "\t", printHeaders: Bool = true) -> String
    where S: Sequence, S.Element == (Int, T) {
        let dict = Dictionary(elements)
        if dict.isEmpty {
            return "empty"
        }
        
        return Format.table(rows: [""],
                            cols: dict.keys.sorted(),
                            symbol: symbol,
                            separator: s,
                            printHeaders: printHeaders)
        { (_, i) -> String in
            dict[i].map{ "\($0)" } ?? d
        }
    }
}

extension AdditiveGroup {
    static func printAddTable(values: [Self]) {
        print( Format.table(rows: values, cols: values, symbol: "+") { $0 + $1 } )
    }
}

extension AdditiveGroup where Self: FiniteSet {
    static func printAddTable() {
        printAddTable(values: allElements)
    }
}

extension Monoid {
    static func printMulTable(values: [Self]) {
        print( Format.table(rows: values, cols: values, symbol: "*") { $0 * $1 } )
    }

}

extension Monoid where Self: FiniteSet {
    static func printMulTable() {
        printMulTable(values: allElements)
    }
}