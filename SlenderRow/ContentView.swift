//
//  ContentView.swift
//  SlenderRow
//
//  Created by Николай Игнатов on 16.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var changeLayout = true
    let squaresCount: Int
    
    var body: some View {
        let layout = changeLayout ? AnyLayout(HStackLayout(spacing: 10)) : AnyLayout(VStackLayout(spacing: 0))

        GeometryReader(content: { proxy in
            layout {
                let verticalSquareSize = proxy.size.height / CGFloat(squaresCount)

                let squaresArray = changeLayout ? Array(0..<squaresCount) : Array(0..<squaresCount).reversed()

                ForEach(squaresArray, id: \.self) { index in
                    Button {
                        withAnimation {
                            changeLayout.toggle()
                        }
                    } label: {
                        Rectangle()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .aspectRatio(1.0, contentMode: .fit)
                    }
                    .offset(
                        x: changeLayout ? 0.0 : CGFloat(index) * (proxy.size.width - verticalSquareSize) / CGFloat(squaresCount - 1),
                        y: changeLayout ? proxy.size.height / 2.0 : 0.0
                    )
                }
            }
        })
    }
}

#Preview {
    ContentView(squaresCount: 7)
}
