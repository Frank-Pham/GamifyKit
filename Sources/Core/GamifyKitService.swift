//
//  File.swift
//  
//
//  Created by Frank Pham on 08.06.22.
//

import Foundation
import SwiftUI
import CoreData

public protocol GamifyKitService {
    associatedtype gamifyKitType
    
    func load(completion: @escaping ([gamifyKitType]) -> Void)
}

//public struct Points {
//    var value: Double = 0
//
//    public init(value: Double) {
//        self.value = value
//    }
//    public func precedes(other: Point) -> Bool {
//        self.value < other.value
//    }
//}

public class GamifyKitServiceImpl {
    public func load(completion: () -> Void) {
        
    }
    
    public static var serviceIdentifier: String = "GamifyKitService"
    
    @Binding var playerPoints: Int
    
    public init(playerPoints: Binding<Int>) {
        self._playerPoints = playerPoints
    }
    
    public func executePointCalc(message: String) -> String {
        playerPoints += 1
        print("Message: \(message) - Points: \(playerPoints)")
        return "Message: \(message) - Points: \(playerPoints)"
    }
    
    public func load() {
        
    }
    
    public func unload() {
        
    }
    
}
