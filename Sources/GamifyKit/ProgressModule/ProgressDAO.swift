//
//  File.swift
//  
//
//  Created by Frank Pham on 14.07.22.
//

import Foundation
import CoreData

public struct ProgressDAO: PersistenceDAO {
    public typealias gamifyKitType = Progress
    public var manager = PersistenceManagerImpl.shared
    public var request = NSFetchRequest<NSManagedObject>(entityName: "Progress")
}
