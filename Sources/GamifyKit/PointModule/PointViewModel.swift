//
//  File.swift
//  
//
//  Created by Frank Pham on 26.06.22.
//

import Foundation
import Core
import CoreData

public protocol PointViewModelProtocol: GamifyKitBaseVM {
    var playerPoints: [Point] { get }
    var playerPoint: Point? { get set }
    
    func addPoint()
    func addPoint(by value: Int)
    func load()
    func reset()
}

public protocol TwoWayPointViewModelProtocol: PointViewModelProtocol {
    func subtractPoint()
}

public class PointViewModel: TwoWayPointViewModelProtocol {
    @Published public var playerPoints: [Point] = []
    @Published public var playerPoint: Point?
    var service: PointService
    
    public init(service: PointService = PointServiceImpl()) {
        self.service = service
        load()
    }
    
    public func load() {
        service.load { result in
            guard let result = result.first else { return }
            self.playerPoint = result
        }
    }
    
    public func addPoint() {
        guard let playerPoint = playerPoint else {
            return
        }

        service.addPoint(points: playerPoint) {
            objectWillChange.send()
        }
    }
    
    public func addPoint(by value: Int) {
        guard let playerPoint = playerPoint else {
            return
        }

        service.addPoint(by: value, points: playerPoint) {
            objectWillChange.send()
        }
    }
    
    public func subtractPoint() {
        guard let playerPoint = playerPoint,
            playerPoint.value != 0 else {
            return
        }
        
        service.subtractPoint(points: playerPoint) {
            objectWillChange.send()
        }
    }
    
//    public func addPoints(value: Int) {
//        let newEntry = Point(context: container!.viewContext)
//        newEntry.value = Int16(value)
//        load()
//    }
//
    public func reset() {
        service.reset(points: playerPoints[0]) {
            objectWillChange.send()
        }
    }
    
//    public func deleteAll() {
//        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Point")
//        let delete = NSBatchDeleteRequest(fetchRequest: request)
//
//        do {
//            print("Delete all")
//            try container!.viewContext.execute(delete)
//            try container!.viewContext.save()
//            load()
//            print(playerPoints)
//        } catch let error {
//            print("Error \(error)")
//        }
//    }
    
    @resultBuilder
    struct PointBuilder {
        static func buildBlock(_ components: Int...) -> Int {
            var sum = 0
            
            components.forEach {
                sum += $0
            }
            
            return sum
        }
    }
    
    public func build(@PointBuilder _ content: () -> Int) -> Int {
        content()
    }
}
