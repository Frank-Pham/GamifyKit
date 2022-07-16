//
//  SwiftUIView.swift
//  
//
//  Created by Frank Pham on 05.07.22.
//

import SwiftUI

struct RisingPointsModifier: ViewModifier {
    @State var time = 0.0
    let duration = 1.0
    
    struct RisingPointsGeometryEffect : GeometryEffect {
        var time : Double
        var speed = Double.random(in: 100 ... 200)
        var xDirection = Double.random(in:  -0.05 ... 0.05)
        var yDirection = Double.random(in: -Double.pi ...  0)
        
        var animatableData: Double {
            get { time }
            set { time = newValue }
        }
        func effectValue(size: CGSize) -> ProjectionTransform {
            let xTranslation = speed * xDirection
            let yTranslation = speed * sin(yDirection) * time
            let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
            return ProjectionTransform(affineTranslation)
        }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .modifier(RisingPointsGeometryEffect(time: time))
                .opacity(time == 1 ? 0 : 1)
        }
        .onAppear {
            withAnimation(.easeOut(duration: duration)) {
                self.time = duration
            }
        }
    }
}

struct PointPulsatingModifier: ViewModifier {
    @State var isAnimated: Bool = false
    var amount: Double = 2.0
    var color: Color = .green
    
    func body(content: Content) -> some View {
        VStack {
            content
                .overlay(
                    Circle()
                        .stroke(color, lineWidth: 10)
                        .frame(width: 100, height: 100)
                        .opacity(isAnimated ? 1 : 0)
                        .scaleEffect(isAnimated ? 1 : 0)
                        .animation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false)
                        )
            )
                .onAppear() {
                    isAnimated.toggle()
                }
        }
    }
}

extension View {
    public func risingPoint() -> some View {
        modifier(RisingPointsModifier())
    }
    
    public func pulsatingCircle(amount: Double) -> some View {
        modifier(PointPulsatingModifier(amount: amount))
    }
}
struct AnimationModifierView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .pulsatingCircle(amount: 2.0)
    }
}

struct AnimationModifierView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationModifierView()
    }
}

@available(iOS 14.0, *)
public struct GamifyKitAnimationModifiers: LibraryContentProvider {
    @LibraryContentBuilder
    public func modifiers<BaseView: View>(base: BaseView) -> [LibraryItem] {
        LibraryItem(
            base
                .risingPoint()
        )
        
        LibraryItem(
            base
                .pulsatingCircle(amount: 1.0)
        )
    }
}
