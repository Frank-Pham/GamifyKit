//
//  SwiftUIView.swift
//  
//
//  Created by Frank Pham on 11.07.22.
//

import SwiftUI
import CoreData
public struct Badge <Content: View>: View {
    let content: Content
    @State private var isUnlock: Bool = false
    
    var imageName: String = "star.fill"
    var objectID: NSManagedObjectID?
    @StateObject var viewModel = RewardViewModel()
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public init(id: NSManagedObjectID?, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.objectID = id
    }
    
    public var body: some View {
        
        HStack {
            if let reward = viewModel.reward {
                Image(systemName: imageName)
                VStack {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Text("\(reward.name ?? "Empty Badge Name")")
                    Text(reward.isUnlocked ? "Locked" : "Unlocked")
                    content
                }
            } else {
                Text("Badge model empty")
            }
        }
        .baseStyle()
        .onAppear {
            guard let id = objectID else {
                viewModel.load()
                return
            }
            viewModel.loadId(id: id)
        }
        
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        Badge {
            Text("Sternensammler")
        }
    }
}
