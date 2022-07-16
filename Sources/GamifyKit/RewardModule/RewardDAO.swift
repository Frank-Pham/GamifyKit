//
//  File.swift
//  
//
//  Created by Frank Pham on 15.07.22.
//

import Foundation
import CoreData

class RewardDAO: PersistenceDAO {
    typealias gamifyKitType = Reward
    
    var manager: PersistenceManager = PersistenceManagerImpl.shared
    var request: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: "Reward")
    
}
