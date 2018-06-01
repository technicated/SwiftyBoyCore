struct Registers {

    var a: UInt8 = 0x00
    var f: Flags = 0x00

    var b: UInt8 = 0x00
    var c: UInt8 = 0x00

    var d: UInt8 = 0x00
    var e: UInt8 = 0x00

    var h: UInt8 = 0x00
    var l: UInt8 = 0x00

    var pc: UInt16 = 0x0000
    var sp: UInt16 = 0x0000

}

extension Registers {

    var af: UInt16 {
        get { return UInt16(hi: a, lo: f.rawValue) }
        set { (a, f) = (newValue.hi, Flags(rawValue: newValue.lo)) }
    }
    
    var bc: UInt16 {
        get { return UInt16(hi: b, lo: c) }
        set { (b, c) = (newValue.hi, newValue.lo) }
    }
    
    var de: UInt16 {
        get { return UInt16(hi: d, lo: e) }
        set { (d, e) = (newValue.hi, newValue.lo) }
    }
    
    var hl: UInt16 {
        get { return UInt16(hi: h, lo: l) }
        set { (h, l) = (newValue.hi, newValue.lo) }
    }

}
