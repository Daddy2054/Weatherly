//
//  Location.swift
//  Weatherly
//
//  Created by Jean on 31/10/24.
//

import Foundation

struct
Location: Decodable {
    let name: String
    let lat: Double
    let lon: Double
}
