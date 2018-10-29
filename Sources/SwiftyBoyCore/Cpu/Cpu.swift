//
//  Cpu.swift
//  SwiftyBoyCore
//
//  Created by technicated
//

// MARK: - Jump / Call / Return conditions -

enum Condition {
    
    case c
    case nc
    case z
    case nz
    
}

extension Condition {
    
    func isTrue(using flags: Flags) -> Bool {
        switch self {
            
        case .c where flags.contains(.carry): return true
        case .nc where !flags.contains(.carry): return true
        case .z where flags.contains(.zero): return true
        case .nz where !flags.contains(.zero): return true
        default: return false
            
        }
    }
    
}

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
    
    mutating func run() -> Int {
        defer { bus.resetInstructionLength() }
        
        switch nextImm8() {
            
        case 0x00: nop()
        case 0x01: ld(Register16.bc, d16)
        case 0x02: ld(Memory.bc, Register8.a)
        case 0x03: inc(Register16.bc)
        case 0x04: inc(Register8.b)
        case 0x05: dec(Register8.b)
        case 0x06: ld(Register8.b, d8)
        case 0x07: rlca()
        case 0x08: ld(a16, Register16.sp)
        case 0x09: add(Register16.bc)
        case 0x0A: ld(Register8.a, Memory.bc)
        case 0x0B: dec(Register16.bc)
        case 0x0C: inc(Register8.c)
        case 0x0D: dec(Register8.c)
        case 0x0E: ld(Register8.c, d8)
        case 0x0F: rrca()
            
        case 0x10: stop()
        case 0x11: ld(Register16.de, d16)
        case 0x12: ld(Memory.de, Register8.a)
        case 0x13: inc(Register16.de)
        case 0x14: inc(Register8.d)
        case 0x15: dec(Register8.d)
        case 0x16: ld(Register8.d, d8)
        case 0x17: rla()
        case 0x18: jr()
        case 0x19: add(Register16.de)
        case 0x1A: ld(Register8.a, Memory.de)
        case 0x1B: dec(Register16.de)
        case 0x1C: inc(Register8.e)
        case 0x1D: dec(Register8.e)
        case 0x1E: ld(Register8.e, d8)
        case 0x1F: rra()
            
        case 0x20: jr(.nz)
        case 0x21: ld(Register16.hl, d16)
        case 0x22: ld(Memory.hli, Register8.a)
        case 0x23: inc(Register16.hl)
        case 0x24: inc(Register8.h)
        case 0x25: dec(Register8.h)
        case 0x26: ld(Register8.h, d8)
        case 0x27: daa()
        case 0x28: jr(.z)
        case 0x29: add(Register16.hl)
        case 0x2A: ld(Register8.a, Memory.hli)
        case 0x2B: dec(Register16.hl)
        case 0x2C: inc(Register8.l)
        case 0x2D: dec(Register8.l)
        case 0x2E: ld(Register8.l, d8)
        case 0x2F: cpl()
            
        case 0x30: jr(.nc)
        case 0x31: ld(Register16.sp, d16)
        case 0x32: ld(Memory.hld, Register8.a)
        case 0x33: inc(Register16.sp)
        case 0x34: inc(Memory.hl)
        case 0x35: dec(Memory.hl)
        case 0x36: ld(Memory.hl, d8)
        case 0x37: scf()
        case 0x38: jr(.c)
        case 0x39: add(Register16.sp)
        case 0x3A: ld(Register8.a, Memory.hld)
        case 0x3B: dec(Register16.sp)
        case 0x3C: inc(Register8.a)
        case 0x3D: dec(Register8.a)
        case 0x3E: ld(Register8.a, d8)
        case 0x3F: ccf()
            
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
        case 0x76: halt()
        case 0x77: ld(Memory.hl, Register8.a)
        case 0x78: ld(Register8.a, Register8.b)
        case 0x79: ld(Register8.a, Register8.c)
        case 0x7A: ld(Register8.a, Register8.d)
        case 0x7B: ld(Register8.a, Register8.e)
        case 0x7C: ld(Register8.a, Register8.h)
        case 0x7D: ld(Register8.a, Register8.l)
        case 0x7E: ld(Register8.a, Memory.hl)
        case 0x7F: ld(Register8.a, Register8.a)
            
        case 0x80: add(Register8.b)
        case 0x81: add(Register8.c)
        case 0x82: add(Register8.d)
        case 0x83: add(Register8.e)
        case 0x84: add(Register8.h)
        case 0x85: add(Register8.l)
        case 0x86: add(Memory.hl)
        case 0x87: add(Register8.a)
        case 0x88: adc(Register8.b)
        case 0x89: adc(Register8.c)
        case 0x8A: adc(Register8.d)
        case 0x8B: adc(Register8.e)
        case 0x8C: adc(Register8.h)
        case 0x8D: adc(Register8.l)
        case 0x8E: adc(Memory.hl)
        case 0x8F: adc(Register8.a)
            
        case 0x90: sub(Register8.b)
        case 0x91: sub(Register8.c)
        case 0x92: sub(Register8.d)
        case 0x93: sub(Register8.e)
        case 0x94: sub(Register8.h)
        case 0x95: sub(Register8.l)
        case 0x96: sub(Memory.hl)
        case 0x97: sub(Register8.a)
        case 0x98: sbc(Register8.b)
        case 0x99: sbc(Register8.c)
        case 0x9A: sbc(Register8.d)
        case 0x9B: sbc(Register8.e)
        case 0x9C: sbc(Register8.h)
        case 0x9D: sbc(Register8.l)
        case 0x9E: sbc(Memory.hl)
        case 0x9F: sbc(Register8.a)
            
        case 0xA0: and(Register8.b)
        case 0xA1: and(Register8.c)
        case 0xA2: and(Register8.d)
        case 0xA3: and(Register8.e)
        case 0xA4: and(Register8.h)
        case 0xA5: and(Register8.l)
        case 0xA6: and(Memory.hl)
        case 0xA7: and(Register8.a)
        case 0xA8: xor(Register8.b)
        case 0xA9: xor(Register8.c)
        case 0xAA: xor(Register8.d)
        case 0xAB: xor(Register8.e)
        case 0xAC: xor(Register8.h)
        case 0xAD: xor(Register8.l)
        case 0xAE: xor(Memory.hl)
        case 0xAF: xor(Register8.a)
            
        case 0xB0: or(Register8.b)
        case 0xB1: or(Register8.c)
        case 0xB2: or(Register8.d)
        case 0xB3: or(Register8.e)
        case 0xB4: or(Register8.h)
        case 0xB5: or(Register8.l)
        case 0xB6: or(Memory.hl)
        case 0xB7: or(Register8.a)
        case 0xB8: cp(Register8.b)
        case 0xB9: cp(Register8.c)
        case 0xBA: cp(Register8.d)
        case 0xBB: cp(Register8.e)
        case 0xBC: cp(Register8.h)
        case 0xBD: cp(Register8.l)
        case 0xBE: cp(Memory.hl)
        case 0xBF: cp(Register8.a)
            
        case 0xC0: ret(.nz)
        case 0xC1: pop(Register16.bc)
        case 0xC2: jp(.nz)
        case 0xC3: jp()
        case 0xC4: call(.nz)
        case 0xC5: push(Register16.bc)
        case 0xC6: add(d8)
        case 0xC7: rst(0x00)
        case 0xC8: ret(.z)
        case 0xC9: ret()
        case 0xCA: jp(.z)
        case 0xCB: executeExtendedOperation()
        case 0xCC: call(.z)
        case 0xCD: call()
        case 0xCE: adc(d8)
        case 0xCF: rst(0x08)
            
        case 0xD0: ret(.nc)
        case 0xD1: pop(Register16.de)
        case 0xD2: jp(.nc)
        case 0xD4: call(.nc)
        case 0xD5: push(Register16.de)
        case 0xD6: sub(d8)
        case 0xD7: rst(0x10)
        case 0xD8: ret(.c)
        case 0xD9: reti()
        case 0xDA: jp(.c)
        case 0xDC: call(.c)
        case 0xDE: sbc(d8)
        case 0xDF: rst(0x18)
            
        case 0xE0: ld(Memory.a8, Register8.a)
        case 0xE1: pop(Register16.hl)
        case 0xE2: ld(Memory.c, Register8.a)
        case 0xE5: push(Register16.hl)
        case 0xE6: and(d8)
        case 0xE7: rst(0x20)
        case 0xE8: addsp()
        case 0xE9: jphl()
        case 0xEA: ld(Memory.a16, Register8.a)
        case 0xEE: xor(d8)
        case 0xEF: rst(0x28)
            
        case 0xF0: ld(Register8.a, Memory.a8)
        case 0xF1: pop(Register16.af)
        case 0xF2: ld(Register8.a, Memory.c)
        case 0xF3: di()
        case 0xF5: push(Register16.af)
        case 0xF6: or(d8)
        case 0xF7: rst(0x30)
        case 0xF8: ldhl()
        case 0xF9: ldsp()
        case 0xFA: ld(Register8.a, Memory.a16)
        case 0xFB: ei()
        case 0xFE: cp(d8)
        case 0xFF: rst(0x38)
            
        case let op: fatalError("Unknown opcode \(hex(op))")
            
        }
        
        return bus.instructionLengthInMachineCycles
    }
    
    private mutating func executeExtendedOperation() {
        switch nextImm8() {
            
        case 0x00: rlc(Register8.b)
        case 0x01: rlc(Register8.c)
        case 0x02: rlc(Register8.d)
        case 0x03: rlc(Register8.e)
        case 0x04: rlc(Register8.h)
        case 0x05: rlc(Register8.l)
        case 0x06: rlc(Memory.hl)
        case 0x07: rlc(Register8.a)
        case 0x08: rrc(Register8.b)
        case 0x09: rrc(Register8.c)
        case 0x0A: rrc(Register8.d)
        case 0x0B: rrc(Register8.e)
        case 0x0C: rrc(Register8.h)
        case 0x0D: rrc(Register8.l)
        case 0x0E: rrc(Memory.hl)
        case 0x0F: rrc(Register8.a)
            
        case 0x10: rl(Register8.b)
        case 0x11: rl(Register8.c)
        case 0x12: rl(Register8.d)
        case 0x13: rl(Register8.e)
        case 0x14: rl(Register8.h)
        case 0x15: rl(Register8.l)
        case 0x16: rl(Memory.hl)
        case 0x17: rl(Register8.a)
        case 0x18: rr(Register8.b)
        case 0x19: rr(Register8.c)
        case 0x1A: rr(Register8.d)
        case 0x1B: rr(Register8.e)
        case 0x1C: rr(Register8.h)
        case 0x1D: rr(Register8.l)
        case 0x1E: rr(Memory.hl)
        case 0x1F: rr(Register8.a)
            
        case 0x20: sla(Register8.b)
        case 0x21: sla(Register8.c)
        case 0x22: sla(Register8.d)
        case 0x23: sla(Register8.e)
        case 0x24: sla(Register8.h)
        case 0x25: sla(Register8.l)
        case 0x26: sla(Memory.hl)
        case 0x27: sla(Register8.a)
        case 0x28: sra(Register8.b)
        case 0x29: sra(Register8.c)
        case 0x2A: sra(Register8.d)
        case 0x2B: sra(Register8.e)
        case 0x2C: sra(Register8.h)
        case 0x2D: sra(Register8.l)
        case 0x2E: sra(Memory.hl)
        case 0x2F: sra(Register8.a)
            
        case 0x30: swap(Register8.b)
        case 0x31: swap(Register8.c)
        case 0x32: swap(Register8.d)
        case 0x33: swap(Register8.e)
        case 0x34: swap(Register8.h)
        case 0x35: swap(Register8.l)
        case 0x36: swap(Memory.hl)
        case 0x37: swap(Register8.a)
        case 0x38: srl(Register8.b)
        case 0x39: srl(Register8.c)
        case 0x3A: srl(Register8.d)
        case 0x3B: srl(Register8.e)
        case 0x3C: srl(Register8.h)
        case 0x3D: srl(Register8.l)
        case 0x3E: srl(Memory.hl)
        case 0x3F: srl(Register8.a)
            
        case 0x40: bit(0, Register8.b)
        case 0x41: bit(0, Register8.c)
        case 0x42: bit(0, Register8.d)
        case 0x43: bit(0, Register8.e)
        case 0x44: bit(0, Register8.h)
        case 0x45: bit(0, Register8.l)
        case 0x46: bit(0, Memory.hl)
        case 0x47: bit(0, Register8.a)
        case 0x48: bit(1, Register8.b)
        case 0x49: bit(1, Register8.c)
        case 0x4A: bit(1, Register8.d)
        case 0x4B: bit(1, Register8.e)
        case 0x4C: bit(1, Register8.h)
        case 0x4D: bit(1, Register8.l)
        case 0x4E: bit(1, Memory.hl)
        case 0x4F: bit(1, Register8.a)
            
        case 0x50: bit(2, Register8.b)
        case 0x51: bit(2, Register8.c)
        case 0x52: bit(2, Register8.d)
        case 0x53: bit(2, Register8.e)
        case 0x54: bit(2, Register8.h)
        case 0x55: bit(2, Register8.l)
        case 0x56: bit(2, Memory.hl)
        case 0x57: bit(2, Register8.a)
        case 0x58: bit(3, Register8.b)
        case 0x59: bit(3, Register8.c)
        case 0x5A: bit(3, Register8.d)
        case 0x5B: bit(3, Register8.e)
        case 0x5C: bit(3, Register8.h)
        case 0x5D: bit(3, Register8.l)
        case 0x5E: bit(3, Memory.hl)
        case 0x5F: bit(3, Register8.a)
            
        case 0x60: bit(4, Register8.b)
        case 0x61: bit(4, Register8.c)
        case 0x62: bit(4, Register8.d)
        case 0x63: bit(4, Register8.e)
        case 0x64: bit(4, Register8.h)
        case 0x65: bit(4, Register8.l)
        case 0x66: bit(4, Memory.hl)
        case 0x67: bit(4, Register8.a)
        case 0x68: bit(5, Register8.b)
        case 0x69: bit(5, Register8.c)
        case 0x6A: bit(5, Register8.d)
        case 0x6B: bit(5, Register8.e)
        case 0x6C: bit(5, Register8.h)
        case 0x6D: bit(5, Register8.l)
        case 0x6E: bit(5, Memory.hl)
        case 0x6F: bit(5, Register8.a)
            
        case 0x70: bit(6, Register8.b)
        case 0x71: bit(6, Register8.c)
        case 0x72: bit(6, Register8.d)
        case 0x73: bit(6, Register8.e)
        case 0x74: bit(6, Register8.h)
        case 0x75: bit(6, Register8.l)
        case 0x76: bit(6, Memory.hl)
        case 0x77: bit(6, Register8.a)
        case 0x78: bit(7, Register8.b)
        case 0x79: bit(7, Register8.c)
        case 0x7A: bit(7, Register8.d)
        case 0x7B: bit(7, Register8.e)
        case 0x7C: bit(7, Register8.h)
        case 0x7D: bit(7, Register8.l)
        case 0x7E: bit(7, Memory.hl)
        case 0x7F: bit(7, Register8.a)
            
        case 0x80: res(0, Register8.b)
        case 0x81: res(0, Register8.c)
        case 0x82: res(0, Register8.d)
        case 0x83: res(0, Register8.e)
        case 0x84: res(0, Register8.h)
        case 0x85: res(0, Register8.l)
        case 0x86: res(0, Memory.hl)
        case 0x87: res(0, Register8.a)
        case 0x88: res(1, Register8.b)
        case 0x89: res(1, Register8.c)
        case 0x8A: res(1, Register8.d)
        case 0x8B: res(1, Register8.e)
        case 0x8C: res(1, Register8.h)
        case 0x8D: res(1, Register8.l)
        case 0x8E: res(1, Memory.hl)
        case 0x8F: res(1, Register8.a)
            
        case 0x90: res(2, Register8.b)
        case 0x91: res(2, Register8.c)
        case 0x92: res(2, Register8.d)
        case 0x93: res(2, Register8.e)
        case 0x94: res(2, Register8.h)
        case 0x95: res(2, Register8.l)
        case 0x96: res(2, Memory.hl)
        case 0x97: res(2, Register8.a)
        case 0x98: res(3, Register8.b)
        case 0x99: res(3, Register8.c)
        case 0x9A: res(3, Register8.d)
        case 0x9B: res(3, Register8.e)
        case 0x9C: res(3, Register8.h)
        case 0x9D: res(3, Register8.l)
        case 0x9E: res(3, Memory.hl)
        case 0x9F: res(3, Register8.a)
            
        case 0xA0: res(4, Register8.b)
        case 0xA1: res(4, Register8.c)
        case 0xA2: res(4, Register8.d)
        case 0xA3: res(4, Register8.e)
        case 0xA4: res(4, Register8.h)
        case 0xA5: res(4, Register8.l)
        case 0xA6: res(4, Memory.hl)
        case 0xA7: res(4, Register8.a)
        case 0xA8: res(5, Register8.b)
        case 0xA9: res(5, Register8.c)
        case 0xAA: res(5, Register8.d)
        case 0xAB: res(5, Register8.e)
        case 0xAC: res(5, Register8.h)
        case 0xAD: res(5, Register8.l)
        case 0xAE: res(5, Memory.hl)
        case 0xAF: res(5, Register8.a)
            
        case 0xB0: res(6, Register8.b)
        case 0xB1: res(6, Register8.c)
        case 0xB2: res(6, Register8.d)
        case 0xB3: res(6, Register8.e)
        case 0xB4: res(6, Register8.h)
        case 0xB5: res(6, Register8.l)
        case 0xB6: res(6, Memory.hl)
        case 0xB7: res(6, Register8.a)
        case 0xB8: res(7, Register8.b)
        case 0xB9: res(7, Register8.c)
        case 0xBA: res(7, Register8.d)
        case 0xBB: res(7, Register8.e)
        case 0xBC: res(7, Register8.h)
        case 0xBD: res(7, Register8.l)
        case 0xBE: res(7, Memory.hl)
        case 0xBF: res(7, Register8.a)
            
        case 0xC0: set(0, Register8.b)
        case 0xC1: set(0, Register8.c)
        case 0xC2: set(0, Register8.d)
        case 0xC3: set(0, Register8.e)
        case 0xC4: set(0, Register8.h)
        case 0xC5: set(0, Register8.l)
        case 0xC6: set(0, Memory.hl)
        case 0xC7: set(0, Register8.a)
        case 0xC8: set(1, Register8.b)
        case 0xC9: set(1, Register8.c)
        case 0xCA: set(1, Register8.d)
        case 0xCB: set(1, Register8.e)
        case 0xCC: set(1, Register8.h)
        case 0xCD: set(1, Register8.l)
        case 0xCE: set(1, Memory.hl)
        case 0xCF: set(1, Register8.a)
            
        case 0xD0: set(2, Register8.b)
        case 0xD1: set(2, Register8.c)
        case 0xD2: set(2, Register8.d)
        case 0xD3: set(2, Register8.e)
        case 0xD4: set(2, Register8.h)
        case 0xD5: set(2, Register8.l)
        case 0xD6: set(2, Memory.hl)
        case 0xD7: set(2, Register8.a)
        case 0xD8: set(3, Register8.b)
        case 0xD9: set(3, Register8.c)
        case 0xDA: set(3, Register8.d)
        case 0xDB: set(3, Register8.e)
        case 0xDC: set(3, Register8.h)
        case 0xDD: set(3, Register8.l)
        case 0xDE: set(3, Memory.hl)
        case 0xDF: set(3, Register8.a)
            
        case 0xE0: set(4, Register8.b)
        case 0xE1: set(4, Register8.c)
        case 0xE2: set(4, Register8.d)
        case 0xE3: set(4, Register8.e)
        case 0xE4: set(4, Register8.h)
        case 0xE5: set(4, Register8.l)
        case 0xE6: set(4, Memory.hl)
        case 0xE7: set(4, Register8.a)
        case 0xE8: set(5, Register8.b)
        case 0xE9: set(5, Register8.c)
        case 0xEA: set(5, Register8.d)
        case 0xEB: set(5, Register8.e)
        case 0xEC: set(5, Register8.h)
        case 0xED: set(5, Register8.l)
        case 0xEE: set(5, Memory.hl)
        case 0xEF: set(5, Register8.a)
            
        case 0xF0: set(6, Register8.b)
        case 0xF1: set(6, Register8.c)
        case 0xF2: set(6, Register8.d)
        case 0xF3: set(6, Register8.e)
        case 0xF4: set(6, Register8.h)
        case 0xF5: set(6, Register8.l)
        case 0xF6: set(6, Memory.hl)
        case 0xF7: set(6, Register8.a)
        case 0xF8: set(7, Register8.b)
        case 0xF9: set(7, Register8.c)
        case 0xFA: set(7, Register8.d)
        case 0xFB: set(7, Register8.e)
        case 0xFC: set(7, Register8.h)
        case 0xFD: set(7, Register8.l)
        case 0xFE: set(7, Memory.hl)
        case 0xFF: set(7, Register8.a)
            
        case let op: fatalError("Unknown extended operation \(hex(op))")
            
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

// MARK: - Operations: 16-bit loads / stores -

private extension Cpu {
    
    mutating func ld<R, W>(_ dst: W, _ src: R) where R: Readable16, W: Writable16 {
        let value = src.read(using: &self)
        dst.write(value, using: &self)
    }
    
    mutating func push<R>(_ src: R) where R: Readable16 {
        bus.machineCycle()
        
        let value = src.read(using: &self)
        bus[registers.sp &- 1] = value.hi
        bus[registers.sp &- 2] = value.lo
        registers.sp = registers.sp &- 2
    }
    
    mutating func pop<W>(_ dst: W) where W: Writable16 {
        let lo = bus[registers.sp &+ 0]
        let hi = bus[registers.sp &+ 1]
        registers.sp = registers.sp &+ 2
        dst.write(UInt16(hi: hi, lo: lo), using: &self)
    }
    
    mutating func ldhl() {
        let e = UInt16(bitPattern: Int16(Int8(bitPattern: nextImm8())))
        
        registers.hl = registers.sp &+ e
        
        registers.f = [
            Flags.halfCarry.if((registers.sp & 0x000F) + (e & 0x000F) > 0x000F),
            Flags.carry.if((registers.sp & 0x00FF) + (e & 0x00FF) > 0x00FF)
        ]

        bus.machineCycle()
    }
    
    mutating func ldsp() {
        registers.sp = registers.hl
        bus.machineCycle()
    }
    
}

// MARK: - Operations: 8-bit ALU -

private extension Cpu {
    
    mutating func inc<V>(_ value: V) where V: Readable8 & Writable8 {
        let v = value.read(using: &self)
        let res = v &+ 1
        
        value.write(res, using: &self)
        
        registers.f = [
            Flags.zero.if(res == 0),
            Flags.halfCarry.if(res & 0x0F == 0),
            Flags.carry.if(registers.f.contains(.carry))
        ]
    }
    
    mutating func dec<V>(_ value: V) where V: Readable8 & Writable8 {
        let v = value.read(using: &self)
        let res = v &- 1
        
        value.write(res, using: &self)
        
        registers.f = [
            Flags.zero.if(res == 0),
            Flags.halfCarry.if(res & 0x0F == 0x0F),
            Flags.carry.if(registers.f.contains(.carry))
        ]
    }
    
    mutating func add<R>(_ src: R) where R: Readable8 {
        let value = src.read(using: &self)
        let (res, co) = registers.a.addingReportingOverflow(value)
        
        registers.f = [
            Flags.zero.if(res == 0),
            Flags.halfCarry.if((registers.a & 0x0F) + (value & 0x0F) > 0x0F),
            Flags.carry.if(co)
        ]
        
        registers.a = res
    }
    
    mutating func adc<R>(_ src: R) where R: Readable8 {
        let value = src.read(using: &self)
        let ci: UInt8 = registers.f.contains(.carry) ? 1 : 0
        let res = registers.a &+ value &+ ci
        
        registers.f = [
            Flags.zero.if(res == 0),
            Flags.halfCarry.if((registers.a & 0x0F) + (value & 0x0F) + ci > 0x0F),
            Flags.carry.if(res < registers.a || (ci == 1 && value == 0xFF))
        ]
        
        registers.a = res
    }
    
    mutating func sub<R>(_ src: R) where R: Readable8 {
        let value = src.read(using: &self)
        let res = registers.a &- value
        
        registers.f = [
            Flags.zero.if(res == 0),
            Flags.negative,
            Flags.halfCarry.if((registers.a & 0x0F) < (value & 0x0F)),
            Flags.carry.if(registers.a < value)
        ]
        
        registers.a = res
    }
    
    mutating func sbc<R>(_ src: R) where R: Readable8 {
        let value = src.read(using: &self)
        let ci: UInt8 = registers.f.contains(.carry) ? 1 : 0
        let res = registers.a &- value &- ci
        
        registers.f = [
            Flags.zero.if(res == 0),
            Flags.negative,
            Flags.halfCarry.if((registers.a & 0x0F) < (value & 0x0F) + ci),
            Flags.carry.if(registers.a < value &+ ci || (ci == 1 && value == 0xFF))
        ]
        
        registers.a = res
    }
    
    mutating func and<R>(_ src: R) where R: Readable8 {
        let value = src.read(using: &self)
        registers.a &= value
        
        registers.f = [
            Flags.zero.if(registers.a == 0),
            Flags.halfCarry
        ]
    }
    
    mutating func or<R>(_ src: R) where R: Readable8 {
        let value = src.read(using: &self)
        registers.a |= value
        
        registers.f = [
            Flags.zero.if(registers.a == 0)
        ]
    }
    
    mutating func xor<R>(_ src: R) where R: Readable8 {
        let value = src.read(using: &self)
        registers.a ^= value
        
        registers.f = [
            Flags.zero.if(registers.a == 0)
        ]
    }
    
    mutating func cp<R>(_ src: R) where R: Readable8 {
        let value = src.read(using: &self)
        let res = registers.a &- value
        
        registers.f = [
            Flags.zero.if(res == 0),
            Flags.negative,
            Flags.halfCarry.if((registers.a & 0x0F) < (value & 0x0F)),
            Flags.carry.if(registers.a < value)
        ]
    }
    
    mutating func ccf() {
        registers.f.remove([.negative, .halfCarry])
        registers.f.formSymmetricDifference(.carry)
    }
    
    mutating func scf() {
        registers.f.remove([.negative, .halfCarry])
        registers.f.update(with: .carry)
    }
    
    mutating func cpl() {
        registers.a = ~registers.a
        registers.f.formUnion([.negative, .halfCarry])
    }
    
    mutating func daa() {
        var a = UInt16(registers.a)
        
        if registers.f.contains(.negative) {
            if registers.f.contains(.halfCarry) { a = (a &- 6) & 0xFF }
            
            if registers.f.contains(.carry) { a = a &- 0x60 }
        } else {
            if registers.f.contains(.halfCarry) { a = a &+ 6 }
            
            if registers.f.contains(.carry) { a = a &+ 0x60 }
        }
        
        registers.a = a.lo
        
        registers.f = [
            Flags.carry.if(registers.f.contains(.carry) || a & 0x0100 == 0x0100),
            Flags.negative.if(registers.f.contains(.negative)),
            Flags.zero.if(registers.a == 0)
        ]
    }
    
}

// MARK: - Operations: 16-bit ALU -

private extension Cpu {
    
    mutating func inc<V>(_ value: V) where V: Readable16 & Writable16 {
        let v = value.read(using: &self)
        let res = v &+ 1
        
        value.write(res, using: &self)

        bus.machineCycle()
    }
    
    mutating func dec<V>(_ value: V) where V: Readable16 & Writable16 {
        let v = value.read(using: &self)
        let res = v &- 1
        
        value.write(res, using: &self)

        bus.machineCycle()
    }
    
    mutating func add<R>(_ src: R) where R: Readable16 {
        let value = src.read(using: &self)
        let (res, co) = registers.hl.addingReportingOverflow(value)
        
        registers.f = [
            Flags.zero.if(registers.f.contains(.zero)),
            Flags.halfCarry.if((registers.hl & 0x0FFF) + (value & 0x0FFF) > 0x0FFF),
            Flags.carry.if(co)
        ]
        
        registers.hl = res

        bus.machineCycle()
    }
    
    mutating func addsp() {
        let e = UInt16(bitPattern: Int16(Int8(bitPattern: nextImm8())))
        let res = registers.sp &+ e
        
        registers.f = [
            Flags.halfCarry.if((registers.sp & 0x000F) + (e & 0x000F) > 0x000F),
            Flags.carry.if((registers.sp & 0x00FF) + (e & 0x00FF) > 0x00FF)
        ]
        
        registers.sp = res
        
        bus.machineCycle()
        bus.machineCycle()
    }
    
}

// MARK: - Operations: Jumps -

private extension Cpu {
    
    mutating func jr(r8: UInt8) {
        registers.pc = registers.pc &+ UInt16(bitPattern: Int16(Int8(bitPattern: r8)))
        bus.machineCycle()
    }
    
    mutating func jp(a16: UInt16) {
        registers.pc = a16
        bus.machineCycle()
    }
    
}

private extension Cpu {
    
    mutating func jr() {
        jr(r8: nextImm8())
    }
    
    mutating func jr(_ condition: Condition) {
        let r8 = nextImm8()
        guard condition.isTrue(using: registers.f) else { return }
        jr(r8: r8)
    }
    
    mutating func jp() {
        jp(a16: nextImm16())
    }
    
    mutating func jp(_ condition: Condition) {
        let a16 = nextImm16()
        guard condition.isTrue(using: registers.f) else { return }
        jp(a16: a16)
    }
    
    mutating func jphl() {
        registers.pc = registers.hl
    }
    
}

// MARKs: - Calls & Returns -

private extension Cpu {
    
    mutating func call(a16: UInt16) {
        bus.machineCycle()
        bus[registers.sp &- 1] = registers.pc.hi
        bus[registers.sp &- 2] = registers.pc.lo
        registers.pc = a16
        registers.sp = registers.sp &- 2
    }
    
}

private extension Cpu {
    
    mutating func call() {
        call(a16: nextImm16())
    }
    
    mutating func call(_ condition: Condition) {
        let a16 = nextImm16()
        guard condition.isTrue(using: registers.f) else { return }
        call(a16: a16)
    }
    
    mutating func ret() {
        let lo = bus[registers.sp &+ 0]
        let hi = bus[registers.sp &+ 1]
        registers.pc = UInt16(hi: hi, lo: lo)
        registers.sp = registers.sp &+ 2
        bus.machineCycle()
    }
    
    mutating func ret(_ condition: Condition) {
        bus.machineCycle()
        guard condition.isTrue(using: registers.f) else { return }
        ret()
    }
    
    func reti() {
        fatalError("RETI")
    }
    
    mutating func rst(_ location: UInt8) {
        bus.machineCycle()
        bus[registers.sp &- 1] = registers.pc.hi
        bus[registers.sp &- 2] = registers.pc.lo
        registers.pc = UInt16(hi: 0x00, lo: location)
        registers.sp = registers.sp &- 2
    }
    
}

// MARK: - Operations: Miscellaneous -

private extension Cpu {
    
    func nop() {
        // NOP
    }
    
    func stop() {
        fatalError("STOP")
    }
    
    func halt() {
        fatalError("HALT")
    }
    
    func di() {
        fatalError("DI")
    }
    
    func ei() {
        fatalError("EI")
    }
    
    mutating func swap<V>(_ value: V) where V: Readable8 & Writable8 {
        let v = value.read(using: &self)
        let swapped = (v >> 4) | (v << 4)
        value.write(swapped, using: &self)
        
        registers.f = [
            Flags.zero.if(swapped == 0)
        ]
    }
    
}

// MARK: - Operations: 8-bit rotations / shifts -

private extension Cpu {
    
    mutating func rl<V>(_ value: V, useCarry: Bool, writeZero: Bool) where V: Readable8 & Writable8 {
        let v = value.read(using: &self)
        let ci = useCarry ? (registers.f.contains(.carry) ? 1 : 0) : (v >> 7)
        let co = v & 0x80
        let res = (v << 1) | ci
        
        value.write(res, using: &self)
        
        registers.f = [
            Flags.zero.if(writeZero && res == 0),
            Flags.carry.if(co != 0)
        ]
    }
    
    mutating func rr<V>(_ value: V, useCarry: Bool, writeZero: Bool) where V: Readable8 & Writable8 {
        let v = value.read(using: &self)
        let ci = useCarry ? (registers.f.contains(.carry) ? 1 : 0) : (v & 0x01)
        let co = v & 0x01
        let res = (v >> 1) | (ci << 7)
        
        value.write(res, using: &self)
        
        registers.f = [
            Flags.zero.if(writeZero && res == 0),
            Flags.carry.if(co != 0)
        ]
    }
    
}

private extension Cpu {
    
    mutating func rlca() {
        rl(Register8.a, useCarry: false, writeZero: false)
    }
    
    mutating func rla() {
        rl(Register8.a, useCarry: true, writeZero: false)
    }
    
    mutating func rrca() {
        rr(Register8.a, useCarry: false, writeZero: false)
    }
    
    mutating func rra() {
        rr(Register8.a, useCarry: true, writeZero: false)
    }
    
    mutating func rlc<V>(_ value: V) where V: Readable8 & Writable8 {
        rl(value, useCarry: false, writeZero: true)
    }
    
    mutating func rl<V>(_ value: V) where V: Readable8 & Writable8 {
        rl(value, useCarry: true, writeZero: true)
    }
    
    mutating func rrc<V>(_ value: V) where V: Readable8 & Writable8 {
        rr(value, useCarry: false, writeZero: true)
    }
    
    mutating func rr<V>(_ value: V) where V: Readable8 & Writable8 {
        rr(value, useCarry: true, writeZero: true)
    }
    
    mutating func sla<V>(_ value: V) where V: Readable8 & Writable8 {
        let v = value.read(using: &self)
        let co = v & 0x80
        let res = v << 1
        
        value.write(res, using: &self)
        
        registers.f = [
            Flags.zero.if(res == 0),
            Flags.carry.if(co != 0)
        ]
    }
    
    mutating func sra<V>(_ value: V) where V: Readable8 & Writable8 {
        let v = value.read(using: &self)
        let co = v & 0x01
        let res = (v & 0x80) | (v >> 1)
        
        value.write(res, using: &self)
        
        registers.f = [
            Flags.zero.if(res == 0),
            Flags.carry.if(co != 0)
        ]
    }
    
    mutating func srl<V>(_ value: V) where V: Readable8 & Writable8 {
        let v = value.read(using: &self)
        let co = v & 0x01
        let res = v >> 1
        
        value.write(res, using: &self)
        
        registers.f = [
            Flags.zero.if(res == 0),
            Flags.carry.if(co != 0)
        ]
    }
    
}

// MARK: - Operations: Bit operations -

private extension Cpu {
    
    mutating func bit<R>(_ index: Int, _ src: R) where R: Readable8 {
        let v = src.read(using: &self)
        let flag = v & (0x01 << index)
        
        registers.f = [
            Flags.zero.if(flag == 0),
            Flags.halfCarry,
            Flags.carry.if(registers.f.contains(.carry))
        ]
    }
    
    mutating func res<V>(_ index: Int, _ value: V) where V: Readable8 & Writable8 {
        let v = value.read(using: &self)
        let res = v & ~(0x01 << index)
        value.write(res, using: &self)
    }
    
    mutating func set<V>(_ index: Int, _ value: V) where V: Readable8 & Writable8 {
        let v = value.read(using: &self)
        let res = v | (0x01 << index)
        value.write(res, using: &self)
    }
    
}
