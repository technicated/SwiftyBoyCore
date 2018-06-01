struct Flags: OptionSet {
 
    static let empty: Flags = Flags(rawValue: 0x00)
    static let mask: UInt8  = 0xF0
    
    static let zero: Flags      = Flags(rawValue: 0x80)
    static let negative: Flags  = Flags(rawValue: 0x40)
    static let halfCarry: Flags = Flags(rawValue: 0x20)
    static let carry: Flags     = Flags(rawValue: 0x10)
    
    let rawValue: UInt8
    
    init(rawValue: UInt8) {
        self.rawValue = rawValue & Flags.mask
    }
    
}

extension Flags: ExpressibleByIntegerLiteral {
    
    init(integerLiteral: UInt8) {
        self.rawValue = integerLiteral & Flags.mask
    }
    
}
