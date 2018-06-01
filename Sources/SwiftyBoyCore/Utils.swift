// https://johnnylee-sde.github.io/Fast-unsigned-integer-to-hex-string/
//
private func hex<I: FixedWidthInteger>(_ value: I, output buffer: UnsafeMutablePointer<UInt8>) {
    var x = UInt64(value)
    
    x = ((x & 0xFFFF) << 32) | ((x & 0xFFFF0000) >> 16)
    x = ((x & 0x0000FF000000FF00) >> 8) | (x & 0x000000FF000000FF) << 16
    x = ((x & 0x00F000F000F000F0) >> 4) | (x & 0x000F000F000F000F) << 8
    
    let mask = ((x + 0x0606060606060606) >> 4) & 0x0101010101010101
    
    x |= 0x3030303030303030
    x += 0x07 * mask
    
    withUnsafeBytes(of: &x) { $0.enumerated().forEach({ buffer[$0] = $1 }) }
}

func hex(_ value: UInt8) -> String {
    var buffer: [UInt8] = Array(repeating: 0, count: 9)
    
    hex(value, output: &buffer)
    
    return "0x\(String(cString: buffer).suffix(2))"
}

func hex(_ value: UInt16) -> String {
    var buffer: [UInt8] = Array(repeating: 0, count: 9)
    
    hex(value, output: &buffer)
    
    return "0x\(String(cString: buffer).suffix(4))"
}

extension UInt16 {
    
    var hi: UInt8 { return UInt8(self >> 8) }
    
    var lo: UInt8 { return UInt8(self & 0x00FF) }

    init(hi: UInt8, lo: UInt8) {
        self = UInt16(hi) << 8 | UInt16(lo)
    }
    
}
