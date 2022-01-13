//
//  MemoryTest.swift
//  Indicator&Message
//
//  Created by Mikhailo Dovhyi on 13.01.2022.
//

import UIKit

var memoryObjects = 0
class MemoryTest {
    
    let string: String
    var memory:Memoryy?
    
    init(s:String) {
        self.string = s
        print(memoryObjects, "MemoryTest init:", string)
       // DispatchQueue.main.async { //затестить на краш когда сразу вызывается
            memoryObjects += 1
        //}
    }
    deinit {
        print(memoryObjects, "MemoryTest deinit:", string)
        //DispatchQueue.main.async {
            memoryObjects -= 1
       // }
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
