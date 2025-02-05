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
    @StateObject var weatherService = WeatherService()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .opacity(0.3)
                .padding(10)
            
            VStack(alignment: .leading, spacing: 5) {
                if let temperature = weatherService.weather?.current.temperature_2m {
                    Text(String(format: "%.1f", temperature))
                }
                else {
                    Text("Loading...")
                    
                }
            }
            .onAppear {
                weatherService.fetchWeather()
            }
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
