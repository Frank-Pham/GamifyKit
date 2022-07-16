//
//  SwiftUIView.swift
//  
//
//  Created by Frank Pham on 16.06.22.
//

import SwiftUI
import Core
import Shared

public struct CircleBar: GamifyKitView {
    //    var viewModel: GamifyKitBaseVM
    @State private var progress = 0.0
    @State private var progressPercentage: Double = 0.00
    @State var counter = 0
    
    public init() {}
    
    public var body: some View {
        VStack {
            ZStack {
                Circle()
                    .inset(by: 5)
                    .stroke(LinearGradient([.gamifyPrimary, .gamifySecondary]), style: StrokeStyle(
                        lineWidth: 25,
                        lineCap: .round,
                        lineJoin: .round)
                    )
                    .foregroundColor(.gray)
                    .opacity(0.05)
                    .frame(width: 220, height: 220)
                
                Circle()
                    .inset(by: 5)
                    .trim(from: 0, to: min(progress, 1))
                    .stroke(LinearGradient([.gamifyPrimary, .gamifySecondary]), style: StrokeStyle(
                        lineWidth: 25,
                        lineCap: .round,
                        lineJoin: .round)
                    )
                    .frame(width: 220, height: 220)
                    .rotationEffect(.degrees(270))
                    .animation(.linear(duration: 0.5), value: progress)
                
                Text("\(progressPercentage, specifier: "%.2f")%")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .opacity(0.8)
            }
            
            HStack(spacing: 30) {
                Button {
                    addProgress()
                } label: {
                    Text("Add")
                }
                
                Button {
                    reduceProgress()
                } label: {
                    Text("Subtract")
                }
            }
            .padding()
        }
    }
    
    func addProgress() {
        guard progress != 1,
              counter != 10 else { return }
        
        progress += 0.1
        progressPercentage = progress / 1.0 * 100
        self.counter += 1
        print("\(progress) \(counter)")
    }
    
    func reduceProgress() {
        guard progress != 0.0,
              counter != 0 else { return }
        
        progress -= 0.1
        progressPercentage = progress / 1.0 * 100
        self.counter -= 1
    }
}

struct CircleBar_Previews: PreviewProvider {
    static var previews: some View {
        //        var viewModel = GamifyKitBaseVM()
        CircleBar()
    }
}
