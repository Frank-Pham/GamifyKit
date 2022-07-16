//
//  File.swift
//  
//
//  Created by Frank Pham on 26.06.22.
//

import Foundation
import Core
import CoreData

public protocol OneWayServiceProtocol {
    func addPoint(points: Point, completion: () -> Void)
    func addPoint(by value: Int, points: Point, completion: () -> Void)
}

public protocol TwoWayPointProtocol {
    func subtractPoint(points: Point, completion: () -> Void)
}

public protocol PointService: OneWayServiceProtocol, TwoWayPointProtocol {
//    associatedtype PointType: NSManagedObject
    
    func load(completion: @escaping ([Point]) -> Void)
    func reset(points: Point, completion: () -> Void)
}

public class PointServiceImpl: PointService {
//    public typealias PointType = Point
    
//    public static var serviceIdentifier: String = "PointService"
    let dao: PointDAO
    
    public init(dao: PointDAO = PointDAO()) {
        self.dao = dao
    }
    
    public func load(completion: @escaping ([Point]) -> Void) {
        dao.load(request: dao.request) { result in
            switch result {
            case .success(var data):
                if data.isEmpty {
                    let newEntry = Point(context: self.dao.manager.viewContext)
                    newEntry.value = 1
                    data.append(newEntry)
                }
                print("Point load() \(data)")
                
                completion(data)
            case .failure(let error):
                print("Service Error load() \(error)")
                fatalError(error.localizedDescription)
            }
        }
    }
    
    public func unload() { }
    
    public func addPoint(points: Point, completion: () -> Void) {
        points.value += 1
        dao.update {
            completion()
        }
    }
    
    public func addPoint(by value: Int, points: Point, completion: () -> Void) {
        points.value += Int16(value)
        dao.update {
            completion()
        }
        completion()
    }
    
    public func subtractPoint(points: Point, completion: () -> Void) {
        points.value -= 1
        dao.update {
            completion()
        }
    }
    
    public func reset(points: Point, completion: () -> Void) {
        points.value = 0
        dao.update {
            completion()
        }
    }
}
