//
//  File.swift
//  
//
//  Created by Frank Pham on 16.07.22.
//

import Foundation
import Core

class GKServiceManager {
    static let shared = GKServiceManager()
    private let container = [GKService]()
    private let serviceIdentifier = GKServiceManager.self
    
    private init() {
        print(serviceIdentifier)
        registerServices()
    }
    
    func registerServices() {
        
    }
}
