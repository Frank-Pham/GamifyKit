//
//  SwiftUIView.swift
//  
//
//  Created by Frank Pham on 22.05.22.
//

import SwiftUI
import Shared
import Core

public struct Scoreboard<Content: View, BaseViewModel: TwoWayPointViewModelProtocol>: View {
    let content: Content
    
    @ObservedObject public var viewModel: BaseViewModel
    @State private var defaultPoints = 0
    var backgroundGradient: LinearGradient
    var foregroundColor: Color
    
    public init(backgroundGradient: LinearGradient = LinearGradient([.gamifyPrimary, .gamifySecondary]), foregroundColor: Color = .white,viewModel: BaseViewModel, @ViewBuilder content: () -> Content) {
        self.backgroundGradient = backgroundGradient
        self.foregroundColor = foregroundColor
        self.viewModel = viewModel
        self.content = content()
    }
    
    public init(backgroundGradient: LinearGradient = LinearGradient([.gamifyPrimary, .gamifySecondary]), foregroundColor: Color = .white, viewModel: BaseViewModel) where Content == EmptyView {
        self.init(backgroundGradient: backgroundGradient, foregroundColor: foregroundColor, viewModel: viewModel) {
            EmptyView()
        }
    }
    
    public var body: some View {
        VStack {
            if let points = viewModel.playerPoint {
                HStack {
                    ZStack {
                        Text("\(points.value)")
                        ForEach(0..<points.value, id: \.self) { _ in
                            Text("+1")
                                .risingPoint()
                        }
                    }
                    
                    content
                }
                .baseStyle(backgroundColor: backgroundGradient)
            } else {
                HStack {
                    ZStack {
                        Text("\(defaultPoints)")
                        ForEach(0..<defaultPoints, id: \.self) { _ in
                            Text("+1")
                                .risingPoint()
                        }
                    }
                    
                    content
                }
                .baseStyle(backgroundColor: backgroundGradient)
            }
            
#if !ENABLE_PREVIEWS
            Button {
                viewModel.addPoint()
            } label: {
                Text("Add")
            }
            
            Button {
                viewModel.subtractPoint()
            } label: {
                Text("Subtract")
            }
            
            Button {
                viewModel.reset()
            } label: {
                Text("Reset")
            }
            
            Button {
//                viewModel.deleteAll()
            } label: {
                Text("Delete all")
                    .foregroundColor(.red)
            }
#endif
        }
    }
}

struct Scoreboard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Scoreboard(viewModel: PointViewModel())
            Divider()
            Scoreboard(viewModel: PointViewModel()) {
                HStack {
                    Image(systemName: "bitcoinsign.circle.fill")
                    Text("BitPoints")
                }
            }
        }
    }
}
