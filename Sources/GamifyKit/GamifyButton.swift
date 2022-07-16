//
//  SwiftUIView 2.swift
//  
//
//  Created by Frank Pham on 27.05.22.
//

import SwiftUI

public struct GamifyButton: View {
    private var title: String
    private var symbol: String?
    @Binding private var isOn: Bool
    private var execute: () -> ()
    
    var onColors = [Color.blue, Color.purple]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    public var body: some View {
        Button(action: {
            execute()
            isOn.toggle()
        }, label: {
            VStack {
                Text(title)
                Image(systemName: symbol ?? "")
            }
        })
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .cornerRadius(20)
        .shadow(radius: isOn ? 0 : 5)
    }
    
    public init(title: String, symbol: String?, isOn: Binding<Bool>, execute: @escaping () -> ()) {
        self.title = title
        self.symbol = symbol
        self._isOn = isOn
        self.execute = execute
    }
}

struct GamifyButton_Previews: PreviewProvider {
    static var previews: some View {
        GamifyButton(title: "Remember me", symbol: "star", isOn: .constant(true)) {
            print("Test")
        }
    }
}
