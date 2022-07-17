//
//  File.swift
//  
//
//  Created by Frank Pham on 17.07.22.
//

import Foundation
import CoreData

public struct PlayerDAO: PersistenceDAO {
    public typealias gamifyKitType = Player
    public var manager = PersistenceManagerImpl.shared
    public var request = NSFetchRequest<NSManagedObject>(entityName: "Player")
    
    func loadDummyData() {
        let player = Player(context: manager.viewContext)
        let badge = Reward(context: manager.viewContext)
        
        player.id = UUID()
        player.name = "Frank"
        badge.isUnlocked = false
        badge.name = "Beginner Badge"
//        player.rewards = [badge]
        player.rewards = badge
        update {}
    }
}
