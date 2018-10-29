//
//  Clock.swift
//  SwiftyBoyCore
//
//  Created by Andrea Tomarelli on 21/10/2018.
//

struct Clock {
    
    // 4.194.304 ticks / sec
    //
    static let speed: Int = 1 << 22
    
    // 456 (i.e. 80 [OAM] + 172+ [DRAW] + 204- [HBLANK]) * 154 (i.e. 144 [SCREEN] + 10 [VBLANK])
    // 70.224 clock ticks / frame
    // 17.556 cpu ticks / frame
    //
    static let cyclesPerFrame: Int = 70_224
    static let machineCyclesPerFrame: Int = Clock.cyclesPerFrame / 4
    
    
    private var machineCyclesCounter: Int = 0
    private var targetMachineCycles: Int = 0
    
}

extension Clock {
    
    mutating func resetTarget() {
        targetMachineCycles += Clock.machineCyclesPerFrame
    }
    
    mutating func add(machineCycles: Int) {
        machineCyclesCounter += machineCycles
    }
    
    func targetMachineCyclesElapsed() -> Bool {
        return machineCyclesCounter >= targetMachineCycles
    }
    
}
