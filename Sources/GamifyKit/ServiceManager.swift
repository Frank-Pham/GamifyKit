//
//  File.swift
//  
//
//  Created by Frank Pham on 16.07.22.
//

import Foundation
import Core
import Combine

class GKServiceManager {
    static let shared = GKServiceManager()
    private var container = [String:Publishable]()
    private let serviceIdentifier = GKServiceManager.self
    
    let pointService: PointService
    let progressService: ProgressService
    
    
    private init(pointService: PointService = PointServiceImpl(), progressService: ProgressService = ProgressService()) {
        self.pointService = pointService
        self.progressService = progressService
        self.container["\(ProgressService.self)"] = progressService
    }
    
    func requestService(type: Publishable.Type) -> Publishable? {
        return container["\(type)"]
    }
    
    func requestPublisher(type: Publishable.Type) -> PassthroughSubject<Float, Error>? {
        return container["\(type)"]?.publisher
    }
}
