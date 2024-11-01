//
//  ContentView.swift
//  Weatherly
//
//  Created by Jean on 31/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var city: String = ""
    @State private var isFetchingWeather: Bool = false
    
    let geocodingClient = GeocodingClient()
    let weatherClient  = WeatherClient()
    
    @State private var weather: Weather?
    
    private func fetchWeather() async {
        do {
            guard let location = try await geocodingClient.coordinateByCity(city) else {return}
            print(location)
            weather = try await weatherClient.fetchWeather(location: location)
        } catch {
            print(error)
        }

    }
    var body: some View {
        VStack {
            TextField("Enter City", text: $city)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    isFetchingWeather = true
                }.task(id: isFetchingWeather) {
                    if isFetchingWeather {
                        await fetchWeather()
                        isFetchingWeather = false
                        city = ""
                    }
                }
            if let weather {
                Text(MeasurementFormatter.temperature(value: weather.temp))
                    .font(.system(size: 150))
            }
            Spacer()
//            Button("Get Coordinates") {
//                Task {
//                    let geocodingClient = GeocodingClient()
//                    let weatherClient  = WeatherClient()
//                    let location = try! await geocodingClient.coordinateByCity("Houston")
//                    let weather = try! await weatherClient.fetchWeather(location: location!)
//                    print(location)
//                    print(weather)
//                }
                
//            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
