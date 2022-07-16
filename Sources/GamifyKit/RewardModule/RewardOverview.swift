//
//  SwiftUIView.swift
//  
//
//  Created by Frank Pham on 15.07.22.
//

import SwiftUI

@available(iOS 14.0, *)
public struct RewardOverview: View {
    @StateObject var viewModel: RewardViewModel = RewardViewModel()
    
    public init() {
    }
    
    public var body: some View {
        VStack {
            ProgressBar(totalProgress: 100, viewModel: viewModel.progressVM) {
                
            }
            
            ProgressBar(objectID: viewModel.reward?.toProgress?.objectID, totalProgress: 100, viewModel: viewModel.progressVM) {
                
            }
            
            Button("Delete") {
                viewModel.progressVM.delete()
            }
            
            Badge {
                Text(viewModel.reward?.name ?? "Badge")
                
                if let reward = viewModel.reward,
                    reward.isUnlocked {
                    Text("Unlocked!")
                } else {
                    Text("\(viewModel.reward!.toProgress!.percent, specifier: "%.2f")%")
                    Text("\(viewModel.reward?.toProgress?.goal ?? 10)%")
                }
            }
            
//            ForEach(viewModel.rewards, id: \.self) { reward in
//                BadgeView {
//                    Text(reward)
//                }
//            }
        }
        .onAppear {
            GKServiceManager.shared
        }
    }
}

@available(iOS 14.0, *)
struct RewardOverview_Previews: PreviewProvider {
    static var previews: some View {
        RewardOverview()
    }
}
