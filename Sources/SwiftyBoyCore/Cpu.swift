struct Cpu {

    let registers: Registers = Registers()
    
}

extension Cpu {

    func nextImm8() -> UInt8 {
        fatalError("Not implemented yet")
    }

    func nextImm16() -> UInt16 {
        fatalError("Not implemented yet")
    }

}

extension Cpu {
    
    func exec() {
        let opcode = nextImm8()
    
        switch opcode {
            
        default: fatalError("Unknown opcode \(hex(opcode))")
            
        }
    }
    
}
