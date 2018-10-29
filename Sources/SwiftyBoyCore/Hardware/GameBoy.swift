//
//  GameBoy.swift
//  SwiftyBoyCore
//
//  Created by Andrea Tomarelli on 10/10/2018.
//

#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif

private extension timeval {
    
    func diff(_ other: timeval) -> timeval {
        var result = self
        
        result.tv_sec -= other.tv_sec
        result.tv_usec -= other.tv_usec
        
        if result.tv_usec < 0 {
            result.tv_sec -= 1
            result.tv_usec += 1_000_000
        }
        
        return result
    }
    
}

struct GameBoy {
    
    // 0.016742706298828125 sec / frame
    // 16742 usec / frame
    //
    static let secPerFrame: Double = Double(Clock.cyclesPerFrame) / Double(Clock.speed)
    static let usecPerFrame: UInt32 = UInt32(GameBoy.secPerFrame * 1_000_000)

    private var clock: Clock = Clock()
    private var cpu: Cpu = Cpu()
    
}

extension GameBoy {

    mutating func run() -> Never {
        var start: timeval = timeval()
        var end: timeval = timeval()
        
        while true {
            gettimeofday(&start, nil)

            clock.resetTarget()
            
            while !clock.targetMachineCyclesElapsed() {
                let instructionLength = cpu.run()
                clock.add(machineCycles: instructionLength)
            }
            
            gettimeofday(&end, nil)

            let d = end.diff(start)
            if d.tv_sec == 0 && d.tv_usec < GameBoy.usecPerFrame {
                usleep(GameBoy.usecPerFrame - UInt32(d.tv_usec))
            }
        }
    }
    
}
