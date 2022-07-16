//
//  File.swift
//  
//
//  Created by Frank Pham on 11.06.22.
//

import Foundation

public protocol GKService {
    static var serviceIdentifier: String { get }
    
    func load()
    
    func unload()
}
