//
//  ContentView.swift
//  weatherApp
//
//  Created by Sam Hengami on 2025-01-27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Text("Sammy H. Jr")
                .containerRelativeFrame([.horizontal, .vertical])
                .background(Gradient(colors: [.purple, .blue]))
        
        VStack{
            VStack{
                BoxView()
                BoxView()
                BoxView()
                }
            }
        }
    }
}

struct BoxView: View {
    var body: some View{
        RoundedRectangle(cornerRadius: 25)
            .fill(.white)
            .frame(width: 100, height: 100)
            .opacity(0.5)
        
    }
}

//
#Preview {
    ContentView()
}
