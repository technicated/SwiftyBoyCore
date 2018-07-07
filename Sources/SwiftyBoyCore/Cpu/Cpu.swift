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
    
    mutating func execute() {
        let opcode = nextImm8()
        
        switch opcode {
            
        case 0x01: ld(Register16.bc, d16)
        case 0x02: ld(Memory.bc, Register8.a)
        case 0x04: inc(Register8.b)
        case 0x05: dec(Register8.b)
        case 0x06: ld(Register8.b, d8)
        case 0x08: ld(a16, Register16.sp)
        case 0x0A: ld(Register8.a, Memory.bc)
        case 0x0C: inc(Register8.c)
        case 0x0D: dec(Register8.c)
        case 0x0E: ld(Register8.c, d8)
            
        case 0x11: ld(Register16.de, d16)
        case 0x12: ld(Memory.de, Register8.a)
        case 0x14: inc(Register8.d)
        case 0x15: dec(Register8.d)
        case 0x16: ld(Register8.d, d8)
        case 0x18: jr()
        case 0x1A: ld(Register8.a, Memory.de)
        case 0x1C: inc(Register8.e)
        case 0x1D: dec(Register8.e)
        case 0x1E: ld(Register8.e, d8)
            
        case 0x20: jr(.nz)
        case 0x21: ld(Register16.hl, d16)
        case 0x22: ld(Memory.hli, Register8.a)
        case 0x24: inc(Register8.h)
        case 0x25: dec(Register8.h)
        case 0x26: ld(Register8.h, d8)
        case 0x27: daa()
        case 0x28: jr(.z)
        case 0x2A: ld(Register8.a, Memory.hli)
        case 0x2C: inc(Register8.l)
        case 0x2D: dec(Register8.l)
        case 0x2E: ld(Register8.l, d8)
        case 0x2F: cpl()
            
        case 0x30: jr(.nc)
        case 0x31: ld(Register16.sp, d16)
        case 0x32: ld(Memory.hld, Register8.a)
        case 0x34: inc(Memory.hl)
        case 0x35: dec(Memory.hl)
        case 0x36: ld(Memory.hl, d8)
        case 0x37: scf()
        case 0x38: jr(.c)
        case 0x3A: ld(Register8.a, Memory.hld)
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
        case 0xE9: jphl()
        case 0xEA: ld(Memory.a16, Register8.a)
        case 0xEE: xor(d8)
        case 0xEF: rst(0x28)
            
        case 0xF0: ld(Register8.a, Memory.a8)
        case 0xF1: pop(Register16.af)
        case 0xF2: ld(Register8.a, Memory.c)
        case 0xF5: push(Register16.af)
        case 0xF6: or(d8)
        case 0xF7: rst(0x30)
        case 0xF8: ldhl()
        case 0xF9: ldsp()
        case 0xFA: ld(Register8.a, Memory.a16)
        case 0xFE: cp(d8)
        case 0xFF: rst(0x38)
            
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

// MARK: - Operations: 16-bit loads / stores -

private extension Cpu {
    
    mutating func ld<R, W>(_ dst: W, _ src: R) where R: Readable16, W: Writable16 {
        let value = src.read(using: &self)
        dst.write(value, using: &self)
    }
    
    mutating func push<R>(_ src: R) where R: Readable16 {
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
    }
    
    mutating func ldsp() {
        registers.sp = registers.hl
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

// MARK: - Operations: Jumps -

private extension Cpu {
    
    mutating func jr() {
        let r8 = UInt16(bitPattern: Int16(Int8(bitPattern: nextImm8())))
        registers.pc = registers.pc &+ r8
    }
    
    mutating func jr(_ condition: Condition) {
        guard condition.isTrue(using: registers.f) else { return }
        
        jr()
    }
    
    mutating func jp() {
        registers.pc = nextImm16()
    }
    
    mutating func jp(_ condition: Condition) {
        guard condition.isTrue(using: registers.f) else { return }
        
        jp()
    }
    
    mutating func jphl() {
        registers.pc = registers.hl
    }
    
}

// MARKs: - Calls & Returns -

private extension Cpu {
    
    mutating func call() {
        bus[registers.sp &- 1] = registers.pc.hi
        bus[registers.sp &- 2] = registers.pc.lo
        registers.pc = nextImm16()
        registers.sp = registers.sp &- 2
    }
    
    mutating func call(_ condition: Condition) {
        guard condition.isTrue(using: registers.f) else { return }
        
        call()
    }
    
    mutating func ret() {
        let lo = bus[registers.sp &+ 0]
        let hi = bus[registers.sp &+ 1]
        registers.pc = UInt16(hi: hi, lo: lo)
        registers.sp = registers.sp &+ 2
    }
    
    mutating func ret(_ condition: Condition) {
        guard condition.isTrue(using: registers.f) else { return }
        
        ret()
    }
    
    func reti() {
        fatalError("RETI")
    }
    
    mutating func rst(_ location: UInt8) {
        bus[registers.sp &- 1] = registers.pc.hi
        bus[registers.sp &- 2] = registers.pc.lo
        registers.pc = UInt16(hi: 0x00, lo: location)
        registers.sp = registers.sp &- 2
    }
    
}
