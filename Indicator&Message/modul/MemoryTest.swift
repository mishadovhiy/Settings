//
//  MemoryTest.swift
//  Indicator&Message
//
//  Created by Mikhailo Dovhyi on 13.01.2022.
//

import UIKit

class MemoryTest {
    
    let string: String
    var memory:Memoryy?
    lazy var appDelegate:AppDelegate? = {
        return AppDelegate.shared
    }()
    
    init(s:String) {
        self.string = s
        print(appDelegate?.globals?.memoryLeakCount ?? -1, "MemoryTest init:", string)
        appDelegate?.globals?.memoryLeakCount += 1
    }
    deinit {
        print(appDelegate?.globals?.memoryLeakCount, "MemoryTest deinit:", string)
        appDelegate?.globals?.memoryLeakCount -= 1
    }
}

class Memoryy {
    
    let string:String
    var mainMemory:MemoryTest?
    
    init(s:String) {
        self.string = s
        print("Memoryy init:", string)
    }
    deinit {
        print("Memoryy deinit: ", string)
    }
}
