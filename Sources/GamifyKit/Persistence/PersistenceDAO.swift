//
//  File.swift
//  
//
//  Created by Frank Pham on 13.07.22.
//

import Foundation
import CoreData

public protocol PersistenceDAO {
    associatedtype gamifyKitType: NSManagedObject
    var manager: PersistenceManager { get }
    var request: NSFetchRequest<NSManagedObject> { get }
    
    func load(request: NSFetchRequest<NSManagedObject>, completion: @escaping (Result<[gamifyKitType], Error>) -> Void)
    func update(completion: () -> Void)
}

extension PersistenceDAO {
    public func load(request: NSFetchRequest<NSManagedObject>, completion: @escaping (Result<[gamifyKitType], Error>) -> Void) {
        manager.load(request: request) { result in
            switch result {
            case .success(let data):
                guard let data = data as? [gamifyKitType] else {
                    return
                }
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func loadId(id: NSManagedObjectID, completion: @escaping (Result<gamifyKitType, Error>) -> Void) {
        manager.loadId(id: id) { result in
            switch result {
            case .success(let data):
                guard let data = data as? gamifyKitType else {
                    return
                }
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func update(completion: () -> Void) {
        manager.save()
        completion()
    }
    
    public func delete(object: NSManagedObject, completion: () -> Void) {
        manager.delete(object: object)
        completion()
    }
}



