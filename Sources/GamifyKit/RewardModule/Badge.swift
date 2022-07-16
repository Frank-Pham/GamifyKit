//
//  SwiftUIView.swift
//  
//
//  Created by Frank Pham on 11.07.22.
//

import SwiftUI

struct Badge <Content: View>: View {
    let content: Content
    @State private var isUnlock: Bool = false
    
    var imageName: String = "star.fill"
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                content
            }
        }
        .baseStyle()
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        Badge {
            Text("Sternensammler")
        }
    }
}
