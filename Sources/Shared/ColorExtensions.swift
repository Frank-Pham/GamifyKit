//
//  File.swift
//  
//
//  Created by Frank Pham on 08.07.22.
//

import Foundation
import SwiftUI

extension Color {
    public static var gamifyPrimary: Color {
        Color(red: 247/255, green: 112/255, blue: 98/255)
    }
    
    public static var gamifySecondary: Color {
        Color(red: 254/255, green: 81/255, blue: 150/255)
    }
}

extension LinearGradient {
    public init(_ colors: [Color], startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing) {
        self.init(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
    }
}
