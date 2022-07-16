//
//  SwiftUIView.swift
//  
//
//  Created by Frank Pham on 11.07.22.
//

import SwiftUI
import Shared
import Core

public struct ProgressBar<Content: View>: View {
    let content: Content
    
    @State private var progress = 0.0
    @State private var progressPercent: CGFloat = 0
    @ObservedObject private var viewModel: ProgressViewModel
    @State private var isOn = false
    
    var width: CGFloat = 100
    var height: CGFloat = 10
    var cornerRadius: CGFloat = 20
    var totalProgress: CGFloat
    
    public init(totalProgress: CGFloat, viewModel: ProgressViewModel, @ViewBuilder content: () -> Content) {
        self.totalProgress = totalProgress
        self.viewModel = viewModel
        self.content = content()
    }
    
    public var body: some View {
        let percentDecimal = totalProgress / totalProgress
        
        VStack {
            if let progress = viewModel.progress {
                HStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .foregroundColor(.gray)
                            .frame(width: totalProgress, height: height)
                        
                        RoundedRectangle(cornerRadius: cornerRadius)
                        //                        .trim(from: 0, to: min(progress + 1, 1))
                            .fill(LinearGradient([.gamifyPrimary, .gamifySecondary]))
                            .frame(width: CGFloat(progress.percent) * percentDecimal, height: height)
                            .animation(.spring(), value: progress.percent)
                    }
                    
                    content
                        .foregroundColor(.gamifyPrimary)
                    
                }
            }
            
            
            if #available(iOS 14.0, *) {
                ProgressView("", value: progress + 50, total: 100)
                    .accentColor(.gamifyPrimary)
            } else {
                // Fallback on earlier versions
            }
            
            HStack {
                Button {
                    viewModel.addProgress()
                } label: {
                    Text("Add")
                }
                
                Button {
                    viewModel.reset()
                } label: {
                    Text("Reset")
                }
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(totalProgress: 100, viewModel: ProgressViewModel()) {
            //            Image(systemName: "battery.100.bolt")
        }
    }
}
