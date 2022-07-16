//
//  File.swift
//  
//
//  Created by Frank Pham on 12.07.22.
//

import Foundation
import CoreData

public protocol PersistenceManager: NSPersistentContainer {
    static var shared: PersistenceManager { get }
    
    func load(request: NSFetchRequest<NSManagedObject>, completion: (Result<[NSManagedObject], Error>) -> Void)
    func save()
    func delete(object: NSManagedObject)
}

public class PersistenceManagerImpl: NSPersistentContainer, PersistenceManager {
    public static let shared: PersistenceManager = PersistenceManagerImpl()
    
    private init() {
        guard let modelURL = Bundle.module.url(forResource: "GamifyKitModels", withExtension: "momd"),
              let objectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error retrieving model")
        }
        
        super.init(name: "GamifyKitModels", managedObjectModel: objectModel)
        setup()
    }
    
    public func load(request: NSFetchRequest<NSManagedObject>, completion: (Result<[NSManagedObject], Error>) -> Void) {
        do {
            let result = try self.viewContext.fetch(request)
            
            completion(.success(result))
        } catch let error {
            print("Error: \(error)")
            completion(.failure(error))
        }
    }
    
    func setup() {
        self.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    public func save() {
        do {
            try self.viewContext.save()
        } catch let error {
            print("Error saving \(error)")
        }
    }
    
    public func delete(object: NSManagedObject) {
        
        print("Delete all")
        self.viewContext.delete(object)
        save()
        
    }
}
