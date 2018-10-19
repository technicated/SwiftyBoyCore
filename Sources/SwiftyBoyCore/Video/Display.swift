//
//  Display.swift
//  SwiftyBoyCore
//
//  Created by Andrea Tomarelli on 24/09/18.
//

struct Display {
    
    private var _lcdc: UInt8 = 0x00
    
    var lcdc: UInt8 {
        get { return _lcdc }
        set { _lcdc = newValue }
    }
    
    private var _stat: UInt8 = 0x00
    
    var stat: UInt8 {
        get { return _stat | 0x80 }
        set { _stat = newValue & 0x78 }
    }

    private var _scy: UInt8 = 0x00
    
    var scy: UInt8 {
        get { return _scy }
        set { _scy = newValue }
    }
    
    private var _scx: UInt8 = 0x00
    
    var scx: UInt8 {
        get { return _scx }
        set { _scx = newValue }
    }
    
    private var _ly: UInt8 = 0x00
    
    var ly: UInt8 {
        get { return _ly }
        set { fatalError("Not implemented yet") }
    }
    
    private var _lyc: UInt8 = 0x00
    
    var lyc: UInt8 {
        get { return _lyc }
        set { _lyc = newValue }
    }
    
    private var _dma: UInt8 = 0x00
    
    var dma: UInt8 {
        get { return _dma }
        set { fatalError("Not implemented yet") }
    }
   
    private var _bgp: UInt8 = 0x00
    
    var bgp: UInt8 {
        get { return _bgp }
        set { _bgp = newValue }
    }
    
    private var _obp0: UInt8 = 0x00
    
    var obp0: UInt8 {
        get { return _obp0 }
        set { _obp0 = newValue }
    }
    
    private var _obp1: UInt8 = 0x00
    
    var obp1: UInt8 {
        get { return _obp1 }
        set { _obp1 = newValue }
    }
    
    private var _wy: UInt8 = 0x00
    
    var wy: UInt8 {
        get { return _wy }
        set { _wy = newValue }
    }
    
    private var _wx: UInt8 = 0x00
    
    var wx: UInt8 {
        get { return _wx }
        set { _wx = newValue }
    }
    
}

private extension Display {

    var isLcdEnabled: Bool { return _lcdc & 0x80 != 0 }

}

extension Display {
    
    func update() {
        guard self.isLcdEnabled else { return }
        
        // and now?
    }
    
}
