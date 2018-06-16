//
//  Readable+Writable.swift
//  SwiftyBoyCore
//
//  Created by technicated
//

// MARK: - Protocols -

protocol Readable8 {
    
    func read(using cpu: inout Cpu) -> UInt8

}

protocol Writable8 {
    
    func write(_ value: UInt8, using cpu: inout Cpu)
    
}

protocol Readable16 {
    
    func read(using cpu: inout Cpu) -> UInt16

}

protocol Writable16 {
    
    func write(_ value: UInt16, using cpu: inout Cpu)
    
}

// MARK: - Immediates -

struct D8 {
    
    fileprivate init() { }
    
}

let d8: D8 = D8()

extension D8: Readable8 {
    
    func read(using cpu: inout Cpu) -> UInt8 {
        return cpu.nextImm8()
    }
    
}

// MARK: -

struct D16 {
    
    fileprivate init() { }
    
}

let d16: D16 = D16()

extension D16: Readable16 {
    
    func read(using cpu: inout Cpu) -> UInt16 {
        return cpu.nextImm16()
    }
    
}

// MARK: -

struct A16 {
    
    fileprivate init() { }
    
}

let a16: A16 = A16()

extension A16: Writable16 {
    
    func write(_ value: UInt16, using cpu: inout Cpu) {
        let address = cpu.nextImm16()
        cpu.bus[address &+ 0] = value.lo
        cpu.bus[address &+ 1] = value.hi
    }
    
}

// MARK: - Registers -

enum Register8 {
    
    case a, b, c, d, e, h, l
    
}

extension Register8: Readable8, Writable8 {
    
    func read(using cpu: inout Cpu) -> UInt8 {
        switch self {
            
        case .a: return cpu.registers.a
        case .b: return cpu.registers.b
        case .c: return cpu.registers.c
        case .d: return cpu.registers.d
        case .e: return cpu.registers.e
        case .h: return cpu.registers.h
        case .l: return cpu.registers.l
            
        }
    }
    
    func write(_ value: UInt8, using cpu: inout Cpu) {
        switch self {
            
        case .a: cpu.registers.a = value
        case .b: cpu.registers.b = value
        case .c: cpu.registers.c = value
        case .d: cpu.registers.d = value
        case .e: cpu.registers.e = value
        case .h: cpu.registers.h = value
        case .l: cpu.registers.l = value
            
        }
    }
    
}

// MARK: -

enum Register16 {
    
    case af, bc, de, hl, sp
    
}

extension Register16: Readable16, Writable16 {
    
    func read(using cpu: inout Cpu) -> UInt16 {
        switch self {
            
        case .af: return cpu.registers.af
        case .bc: return cpu.registers.bc
        case .de: return cpu.registers.de
        case .hl: return cpu.registers.hl
        case .sp: return cpu.registers.sp
            
        }
    }
    
    func write(_ value: UInt16, using cpu: inout Cpu) {
        switch self {
            
        case .af: cpu.registers.af = value
        case .bc: cpu.registers.bc = value
        case .de: cpu.registers.de = value
        case .hl: cpu.registers.hl = value
        case .sp: cpu.registers.sp = value
            
        }
    }
    
}

// MARK: - Memory -

enum Memory {
    
    case bc, de, hl
    
    case hli, hld
    
    case a8, c
    
    case a16
    
}

extension Memory: Readable8, Writable8 {
    
    func read(using cpu: inout Cpu) -> UInt8 {
        switch self {

        case .bc: return cpu.bus[cpu.registers.bc]
        case .de: return cpu.bus[cpu.registers.de]
        case .hl: return cpu.bus[cpu.registers.hl]
            
        case .hli: return cpu.bus[cpu.registers.hl++]
        case .hld: return cpu.bus[cpu.registers.hl--]

        case .a8: return cpu.bus[UInt16(hi: 0xFF, lo: cpu.nextImm8())]
        case .c: return cpu.bus[UInt16(hi: 0xFF, lo: cpu.registers.c)]

        case .a16: return cpu.bus[cpu.nextImm16()]

        }
    }
    
    func write(_ value: UInt8, using cpu: inout Cpu) {
        switch self {
            
        case .bc: cpu.bus[cpu.registers.bc] = value
        case .de: cpu.bus[cpu.registers.de] = value
        case .hl: cpu.bus[cpu.registers.hl] = value
            
        case .hli: cpu.bus[cpu.registers.hl++] = value
        case .hld: cpu.bus[cpu.registers.hl--] = value
            
        case .a8: cpu.bus[UInt16(hi: 0xFF, lo: cpu.nextImm8())] = value
        case .c: cpu.bus[UInt16(hi: 0xFF, lo: cpu.registers.c)] = value
            
        case .a16: cpu.bus[cpu.nextImm16()] = value

        }
    }
    
}
