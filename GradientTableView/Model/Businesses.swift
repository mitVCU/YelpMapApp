//
//  Businesses.swift
//  GradientTableView
//
//  Created by mit on 9/16/21.
//

import Foundation
struct Businesses: Decodable {
    let businesses: [Business]
}

struct Business: Decodable {
    let id: String
    let name: String
    let price: String?
    let coordinates: coordinate?
    let distance: Double?
    let image_url: URL?
    let url: URL?
}

struct coordinate: Decodable {
    let latitude: Double
    let longitude: Double
}
