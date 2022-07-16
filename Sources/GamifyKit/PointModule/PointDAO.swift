//
//  File.swift
//  
//
//  Created by Frank Pham on 13.07.22.
//

import Foundation
import Core
import CoreData

public struct PointDAO: PersistenceDAO {
    public typealias gamifyKitType = Point
    
    public var manager: PersistenceManager = PersistenceManagerImpl.shared
    public var request = NSFetchRequest<NSManagedObject>(entityName: "Point")
    
    public init() {}
}
