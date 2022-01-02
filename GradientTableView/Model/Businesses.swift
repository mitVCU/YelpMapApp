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
    let categories: [Categories]
    let name: String
    let price: String?
    let coordinates: Coordinates?
    let distance: Double?
    let image_url: URL?
    let url: URL?
}

struct Categories: Decodable {
    let alias: String
    let title: String
}

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
}
