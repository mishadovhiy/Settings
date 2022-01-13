//
//  IndeedGlobal.swift
//  Indicator&Message
//
//  Created by Mikhailo Dovhyi on 13.01.2022.
//

import UIKit

class IndeedGlobal {
    /**
     set in MemoryTest
     */
    var memoryLeakCount:Int = 0
    
    func reset() {
        
    }
    
    init() {
        print("IndeedGlobal: init")
    }
    deinit {
        print("IndeedGlobal: deinit")
    }
}
