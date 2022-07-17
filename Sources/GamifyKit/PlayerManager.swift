//
//  File.swift
//  
//
//  Created by Frank Pham on 16.07.22.
//

import Foundation
import CoreData
import Combine

public class PlayerManager: ObservableObject {
    public static let shared = PlayerManager()
    let dao: PlayerDAO
    @Published var player: Player?
    
    private init(dao: PlayerDAO = PlayerDAO()) {
        self.dao = dao

    }
    
    public func loadDummyData() {
        dao.loadDummyData()
    }
    
    public func loadId(id: NSManagedObjectID) {
        dao.loadId(id: id) { result in
            switch result {
            case .success(let data):
                self.player = data
                self.dao.update {
                    self.objectWillChange.send()
                }
                break
            case .failure(let error):
                print("Error load player by id: \(error)")
                break
            }
        }
    }
}
