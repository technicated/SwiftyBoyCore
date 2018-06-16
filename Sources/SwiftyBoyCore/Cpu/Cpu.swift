//
//  Cpu.swift
//  SwiftyBoyCore
//
//  Created by technicated
//

// MARK: - Cpu Implementation -

struct Cpu {
    
    var bus: AddressBus = AddressBus()
    
    var registers: Registers = Registers()
    
}

extension Cpu {

    mutating func nextImm8() -> UInt8 {
        defer { registers.pc = registers.pc &+ 1 }
        return bus[registers.pc]
    }

    mutating func nextImm16() -> UInt16 {
        defer { registers.pc = registers.pc &+ 2 }
        return UInt16(hi: bus[registers.pc &+ 1], lo: bus[registers.pc])
    }

}

extension Cpu {
    
    mutating func execute() {
        let opcode = nextImm8()
        
        switch opcode {
            
        case 0x02: ld(Memory.bc, Register8.a)
        case 0x06: ld(Register8.b, d8)
        case 0x0A: ld(Register8.a, Memory.bc)
        case 0x0E: ld(Register8.c, d8)

        case 0x12: ld(Memory.de, Register8.a)
        case 0x16: ld(Register8.d, d8)
        case 0x1A: ld(Register8.a, Memory.de)
        case 0x1E: ld(Register8.e, d8)
            
        case 0x22: ld(Memory.hli, Register8.a)
        case 0x26: ld(Register8.h, d8)
        case 0x2A: ld(Register8.a, Memory.hli)
        case 0x2E: ld(Register8.l, d8)
            
        case 0x32: ld(Memory.hld, Register8.a)
        case 0x36: ld(Memory.hl, d8)
        case 0x3A: ld(Register8.a, Memory.hld)
        case 0x3E: ld(Register8.a, d8)
            
        case 0x40: ld(Register8.b, Register8.b)
        case 0x41: ld(Register8.b, Register8.c)
        case 0x42: ld(Register8.b, Register8.d)
        case 0x43: ld(Register8.b, Register8.e)
        case 0x44: ld(Register8.b, Register8.h)
        case 0x45: ld(Register8.b, Register8.l)
        case 0x46: ld(Register8.b, Memory.hl)
        case 0x47: ld(Register8.b, Register8.a)
        case 0x48: ld(Register8.c, Register8.b)
        case 0x49: ld(Register8.c, Register8.c)
        case 0x4A: ld(Register8.c, Register8.d)
        case 0x4B: ld(Register8.c, Register8.e)
        case 0x4C: ld(Register8.c, Register8.h)
        case 0x4D: ld(Register8.c, Register8.l)
        case 0x4E: ld(Register8.c, Memory.hl)
        case 0x4F: ld(Register8.c, Register8.a)
            
        case 0x50: ld(Register8.d, Register8.b)
        case 0x51: ld(Register8.d, Register8.c)
        case 0x52: ld(Register8.d, Register8.d)
        case 0x53: ld(Register8.d, Register8.e)
        case 0x54: ld(Register8.d, Register8.h)
        case 0x55: ld(Register8.d, Register8.l)
        case 0x56: ld(Register8.d, Memory.hl)
        case 0x57: ld(Register8.d, Register8.a)
        case 0x58: ld(Register8.e, Register8.b)
        case 0x59: ld(Register8.e, Register8.c)
        case 0x5A: ld(Register8.e, Register8.d)
        case 0x5B: ld(Register8.e, Register8.e)
        case 0x5C: ld(Register8.e, Register8.h)
        case 0x5D: ld(Register8.e, Register8.l)
        case 0x5E: ld(Register8.e, Memory.hl)
        case 0x5F: ld(Register8.e, Register8.a)

        case 0x60: ld(Register8.h, Register8.b)
        case 0x61: ld(Register8.h, Register8.c)
        case 0x62: ld(Register8.h, Register8.d)
        case 0x63: ld(Register8.h, Register8.e)
        case 0x64: ld(Register8.h, Register8.h)
        case 0x65: ld(Register8.h, Register8.l)
        case 0x66: ld(Register8.h, Memory.hl)
        case 0x67: ld(Register8.h, Register8.a)
        case 0x68: ld(Register8.l, Register8.b)
        case 0x69: ld(Register8.l, Register8.c)
        case 0x6A: ld(Register8.l, Register8.d)
        case 0x6B: ld(Register8.l, Register8.e)
        case 0x6C: ld(Register8.l, Register8.h)
        case 0x6D: ld(Register8.l, Register8.l)
        case 0x6E: ld(Register8.l, Memory.hl)
        case 0x6F: ld(Register8.l, Register8.a)

        case 0x70: ld(Memory.hl, Register8.b)
        case 0x71: ld(Memory.hl, Register8.c)
        case 0x72: ld(Memory.hl, Register8.d)
        case 0x73: ld(Memory.hl, Register8.e)
        case 0x74: ld(Memory.hl, Register8.h)
        case 0x75: ld(Memory.hl, Register8.l)
        case 0x77: ld(Memory.hl, Register8.a)
        case 0x78: ld(Register8.a, Register8.b)
        case 0x79: ld(Register8.a, Register8.c)
        case 0x7A: ld(Register8.a, Register8.d)
        case 0x7B: ld(Register8.a, Register8.e)
        case 0x7C: ld(Register8.a, Register8.h)
        case 0x7D: ld(Register8.a, Register8.l)
        case 0x7E: ld(Register8.a, Memory.hl)
        case 0x7F: ld(Register8.a, Register8.a)

        case 0xE0: ld(Memory.a8, Register8.a)
        case 0xE2: ld(Memory.c, Register8.a)
        case 0xEA: ld(Memory.a16, Register8.a)
            
        case 0xF0: ld(Register8.a, Memory.a8)
        case 0xF2: ld(Register8.a, Memory.c)
        case 0xFA: ld(Register8.a, Memory.a16)
            
        default: fatalError("Unknown opcode \(hex(opcode))")
            
        }
    }
    
}

// MARK: - Operations: 8-bit loads / stores -

private extension Cpu {
    
    mutating func ld<R, W>(_ dst: W, _ src: R) where R: Readable8, W: Writable8 {
        let value = src.read(using: &self)
        dst.write(value, using: &self)
    }
    
}
