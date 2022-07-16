//
//  File.swift
//  
//
//  Created by Frank Pham on 04.07.22.
//

import Foundation

public struct PointModel: Decodable {
    public var value: Int
    
    public init(value: Int) {
        self.value = value
    }
}

extension PointModel {
    public static let dummyData: [PointModel] = [
        PointModel(value: 1),
        PointModel(value: 2),
        PointModel(value: 3),
    ]
}
