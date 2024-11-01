//
//  Weather.swift
//  Weatherly
//
//  Created by Jean on 31/10/24.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
}
