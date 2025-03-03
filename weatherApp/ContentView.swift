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
                .background(Gradient(colors: [.teal, .purple]))
            
            VStack{
                DailyViewBox1()
                HourlyViewBox2()
                SevenDayBoxView3()
            }
        }
    }
}


struct DailyViewBox1: View {
    @StateObject var weatherService = WeatherService()
    @State private var locationService = LocationManager()
    
    var body: some View{

        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .opacity(0.3)
                .padding(10)
            
            VStack{
                if let weatherCode = (weatherService.weather?.current.weather_code) {
                    let description = weatherDescriptionText(for: weatherCode)
                    Text("Todays weather is \(description)")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .bold))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(30)
            .padding(.bottom,250)
            
            VStack{
                if let temperature = (
                    weatherService.weather?.current.temperature_2m
                ){
                    
                    Text("\(String(format: "%.1f", temperature))°C")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                } else {
                    Text("Loading...")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                }
            }
            .padding(30)
            .padding(.bottom, 100)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 5) { // Adjust spacing as needed
                if let timeZone = (weatherService.weather?.timezone){
                    Text("\(timeZone)")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                } else {
                    Text("Searching for location...")
                }
                
                let temperatureMin = weatherService.weather?.daily.temperature_2m_min[0]
                
                let temperatureMax = weatherService.weather?.daily.temperature_2m_max[0]
                
                Text("\(String(format: "%.1f", temperatureMin ?? 0.0))°C / \(String(format: "%.1f", temperatureMax ?? 0.0))°C")
                
                if let timeDate = weatherService.weather?.current.time {
                    let formattedTime = timeDate.replacingOccurrences(of: "T", with: " ")
                    Text(formattedTime)
                } else {
                    Text("--")
                }
            }
            .padding(30)
            .padding(.top, 100)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
            
            ZStack{
                if let weatherCode = (weatherService.weather?.current.weather_code) {
                    let symbol = weatherDescriptionImages(for: weatherCode)
                    
                    Text(symbol)
                        .padding(.trailing)
                        .font(.system(size: 75))
                }
            }
            .padding(30)
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundColor(.white)
        }
        .onAppear {
            locationService.requestLocation()
            Task {
                await weatherService.fetchWeather(latitude: locationService.location?.coordinate.latitude ?? 0, longitude: locationService.location?.coordinate.longitude ?? 0)
            }
            
        }
        .refreshable {
            locationService.requestLocation()
        }
    }
}

struct HourlyViewBox2: View {
    @StateObject var weatherService = WeatherService()
    @State private var locationService = LocationManager()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .opacity(0.3)
                .padding(10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if let hourlyData = weatherService.weather?.hourly {
                        ForEach(Array(zip(hourlyData.time.prefix(24), hourlyData.temperature_2m.prefix(24))), id:\.0) {(time, temp) in
                            VStack{
                                Text(formatTime(time))
                                    .font(.caption)
                                Text("\(String(format: "%.1f", temp))°")
                                    .font(.headline)
                                
                            }
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    } else {
                        Text("Loading...")
                    }
                }
                .padding(.horizontal, 10)
            }
            .frame(width: 350)
            .clipped()
            .onAppear {
                locationService.requestLocation()
                Task {
                    await weatherService.fetchWeather(latitude: locationService.location?.coordinate.latitude ?? 0, longitude: locationService.location?.coordinate.longitude ?? 0)
                }
                
            }
        }
    }
}

func formatTime(_ time: String) -> String {
    let components = time.split(separator: "T")
    if components.count > 1 {
        let timePart = components[1]
        let hour = timePart.split(separator: ":")[0]
        return String(hour)
    }
    return time
}


//Will display the 7 day forecast
struct SevenDayBoxView3: View {
    @StateObject var weatherService = WeatherService()
    @State private var locationService = LocationManager()
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .opacity(0.3)
                .padding(10)
            
            VStack(alignment: .leading){
                if let dailyData = weatherService.weather?.daily {
                    ForEach(
                        0..<min(dailyData.time.count, 7),
                        id: \.self
                    ) { index in
                        HStack(){
                            Text(formatDate( dailyData.time[index]) )
                                .frame(width:100, alignment: .leading)
                            let symbol = weatherDescriptionImages(for: dailyData.weather_code[index])
                            
                            // Display weather description
                            Text(symbol)
                                .frame(width:80, alignment: .center)
                            Text(
                                "\(String(format: "%.1f", dailyData.temperature_2m_min[index]))°C / \(String(format: "%.1f", dailyData.temperature_2m_max[index]))°C"
                            )
                            .frame(width:160, alignment: .trailing)
                        }
                        .padding(1)
                    }
                } else{
                    Text("Loading...")
                }
            }
            .padding(30)
            .foregroundColor(.white)
            .onAppear {
                locationService.requestLocation()
                Task {
                    await weatherService.fetchWeather(latitude: locationService.location?.coordinate.latitude ?? 0, longitude: locationService.location?.coordinate.longitude ?? 0)
                }
                
            }
        }
    }
}

// dateformatter from https://chatgpt.com/c/67a0a54f-1284-8011-b899-93665bb87774
func formatDate(_ dateString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "E, MMM, d" //this will make it look like day, month day
        return outputFormatter.string(from: date)
    }
    return dateString
}

//
#Preview {
    ContentView()
}
