//
//  SwiftUIView.swift
//  
//
//  Created by Frank Pham on 05.07.22.
//

import SwiftUI

struct BaseStyleModifier: ViewModifier {
    let backgroundColor: LinearGradient
    let foregroundColor: Color
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.subheadline)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(cornerRadius)
    }
}

extension View {
    public func baseStyle(
        backgroundColor: LinearGradient = LinearGradient(
            colors: [.gamifyPrimary, .gamifySecondary],
            startPoint: .leading,
            endPoint: .trailing
        ),
        foregroundColor: Color = .white,
        cornerRadius: CGFloat = 20
    ) -> some View {
        modifier(BaseStyleModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, cornerRadius: cornerRadius))
    }
}

struct BaseViewModifierView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .baseStyle(foregroundColor: .black)
    }
}

struct BaseViewModifierView_Previews: PreviewProvider {
    static var previews: some View {
        BaseViewModifierView()
    }
}

@available(iOS 14.0, *)
struct GamifyKitViewModifiers: LibraryContentProvider {
    @LibraryContentBuilder
    func modifiers<BaseView: View>(base: BaseView) -> [LibraryItem] {
        LibraryItem(
            base
                .baseStyle(
                    backgroundColor: LinearGradient(
                        colors: [.gamifyPrimary, .gamifySecondary],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        )
    }
}
