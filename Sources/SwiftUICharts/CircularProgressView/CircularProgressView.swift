//
//  SwiftUIView.swift
//  
//
//  Created by Nick Romano on 5/19/21.
//

import SwiftUI
@available(iOS 13.0, macOS 10.15, *)
public struct CircularProgressView: View {
    
    
    @State private var progress: CGFloat = 0.0
    
    var height: CGFloat = 200.0
    var accentColor = Color.red
    
    public init(height: CGFloat? = nil, accentColor: Color? = nil) {
        self.height = height ?? 200.0
        self.accentColor = accentColor ?? .red
    }
    
    public var body: some View {
        let multiple = height/200
        return
        VStack(spacing: 20){
            ZStack {
                // 3.
                Circle()
                    .stroke(Color.gray, lineWidth: 20*multiple)
                    .opacity(0.1)
                // 4.
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineCap: .round))
                    .stroke(accentColor, lineWidth: 20*multiple)
                    .rotationEffect(.degrees(-90))
                // 5.
                .overlay(
                    Text("\(Int(progress * 100.0))%"))
                    .font(.system(size: 35*multiple))
                     
            }.padding(20)
            .frame(height: height)
            
            Spacer()
        }
    }
}

@available(iOS 13.0, macOS 10.15, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(height: 300)
    }
}
