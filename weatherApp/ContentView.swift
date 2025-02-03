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
            Text("")
                .containerRelativeFrame([.horizontal, .vertical])
                .background(Gradient(colors: [.purple, .blue]))
            
            VStack{
                BoxView1()
                sevenDayBoxView2()
                BoxView3()
            }
        }
    }
}



struct BoxView1: View {
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .opacity(0.3)
                .padding(10)
            
            
            VStack{
                Text("(Weather). Highest (TEMP)C, Lowest(TEMP)C")
                    .foregroundStyle(.white)
                    .font(.system(size: 12, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(30)
            .padding(.bottom,250)
            
            VStack{
                Text("TEMP")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            .padding(30)
            .padding(.bottom, 100)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 5) { // Adjust spacing as needed
                Text("CITY")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                Text("Day/Night")
                Text("DAY, TIME")
            }
            .padding(30)
            .padding(.top, 100)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
            
            ZStack{
                Text("SYMBOL")
            }
            .padding(30)
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundColor(.white)
        }
    }
}

//hourly forecast
struct sevenDayBoxView2: View {
    var body: some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .opacity(0.3)
                .padding(10)
            
            HStack{
                ForEach(1...7, id: \.self) { i in
                    Text("\(i)")
                }
                .foregroundColor(.white)
                
                
            }
            
        }
    }
}

//Will display the 7 day forecast
struct BoxView3: View {
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .opacity(0.3)
                .padding(10)
            
            VStack{
                ForEach(1...7, id: \.self){ i in
                    Text("\(i)")
                }
            }
        }
    }
}




//
#Preview {
    ContentView()
}
