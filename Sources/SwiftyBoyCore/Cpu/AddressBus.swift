//
//  AddressBus.swift
//  SwiftyBoyCore
//
//  Created by technicated
//

struct AddressBus {
 
    private var vram: [UInt8] = .init(repeating: 0, count: 0x2000)
    private var wram: [UInt8] = .init(repeating: 0, count: 0x2000)
    private var oam: [UInt8] = .init(repeating: 0, count: 0xA0)
    private var hram: [UInt8] = .init(repeating: 0, count: 0x7F)

}

extension AddressBus {

    subscript(index: UInt16) -> UInt8 {
        get {
            switch index {
            
            case 0x0000 ... 0x3FFF: return 0xFF
            case 0x3000 ... 0x7FFF: return 0xFF
            case 0x8000 ... 0x9FFF: return vram[Int(index - 0x8000)]
            case 0xA000 ... 0xBFFF: return 0xFF
            case 0xC000 ... 0xCFFF: return wram[Int(index - 0xC000)]
            case 0xD000 ... 0xDFFF: return wram[Int(index - 0xC000)]
            case 0xE000 ... 0xFDFF: return wram[Int(index - 0xE000)]
            case 0xFE00 ... 0xFE9F: return oam[Int(index - 0xFE00)]
            case 0xFEA0 ... 0xFEFF: return 0x00
            case 0xFF00 ... 0xFF7F: fatalError("Not implemented")
            case 0xFF80 ... 0xFFFE: return hram[Int(index - 0xFF80)]
            case 0xFFFF: fatalError("Not implemented")
            default: preconditionFailure()
    
            }
        }
        set {
            switch index {
                
            case 0x0000 ... 0x3FFF: break
            case 0x3000 ... 0x7FFF: break
            case 0x8000 ... 0x9FFF: vram[Int(index - 0x8000)] = newValue
            case 0xA000 ... 0xBFFF: break
            case 0xC000 ... 0xCFFF: wram[Int(index - 0xC000)] = newValue
            case 0xD000 ... 0xDFFF: wram[Int(index - 0xC000)] = newValue
            case 0xE000 ... 0xFDFF: wram[Int(index - 0xE000)] = newValue
            case 0xFE00 ... 0xFE9F: oam[Int(index - 0xFE00)] = newValue
            case 0xFEA0 ... 0xFEFF: break
            case 0xFF00 ... 0xFF7F: fatalError("Not implemented")
            case 0xFF80 ... 0xFFFE: hram[Int(index - 0xFF80)] = newValue
            case 0xFFFF: fatalError("Not implemented")
            default: preconditionFailure()
                
            }
        }
    }
    
}
