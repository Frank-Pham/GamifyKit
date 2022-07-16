//
//  File.swift
//  
//
//  Created by Frank Pham on 11.07.22.
//

import Foundation
import Core
import Combine
import CoreData

class ProgressService: GamifyKitService, Publishable {
    
    static var serviceIdentifier = ProgressService.self
    public let dao: ProgressDAO
    let publisher = PassthroughSubject<Float, Error>()
    let unlockPublisher = PassthroughSubject<Bool, Error>()
    
    
    init(dao: ProgressDAO = ProgressDAO()) {
        self.dao = dao
    }
    
    func load(completion: @escaping ([Progress]) -> Void) {
        dao.load(request: dao.request) { result in
            switch result {
            case .success(var data):
                print("Progress load() \(data)")
                
                if data.isEmpty {
                    let newEntry = Progress(context: self.dao.manager.viewContext)
                    newEntry.percent = 50
                    newEntry.goal = 100
                    data.append(newEntry)
                }
                
                completion(data)
            case .failure(let error):
                print("Service Error load() \(error)")
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func loadId(id: NSManagedObjectID, completion: @escaping (Progress) -> Void) {
        dao.loadId(id: id) { result in
            switch result {
            case .success(let data):
                print("Progress loadId() \(data)")
                
                completion(data)
            case .failure(let error):
                print("Service Error load() \(error)")
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func unload() {
        
    }
    
    func addProgress(progress: Progress, completion: () -> Void) {
        guard progress.percent < Float(progress.goal) else {
            unlockPublisher.send(true)
            return
            
        }
        progress.percent += 20
        
        dao.update {
            publisher.send(progress.percent)
            completion()
        }
    }
    
    func reset(progress: Progress, completion: () -> Void) {
        progress.percent = 0
        
        dao.update {
            publisher.send(progress.percent)
            completion()
        }
    }
    
    func delete(progress: Progress, completion: () -> Void) {
        dao.delete(object: progress) {
            completion()
        }
    }
}
