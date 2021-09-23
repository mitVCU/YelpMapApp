//
//  Endpoint.swift
//  GradientTableView
//
//  Created by mit on 9/16/21.
//

import Foundation
let apiKey = "TKqeJdIUHzJrF7EweGe6p-rV1hG95tPvJ3wlABTXAQYjn3IyfM8dG3lVmKPH27LftTi9sp1FJCuYpmqhWlqLIcfrob2N5BJ4oemHgDhiNEInlnWdqcR1ReukpnHgWHYx"

enum Endpoint {
    case getBusinesses(latitude: Double?, longitude: Double?)
    
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "api.yelp.com"
    }
    
    var path: String {
        switch self {
        case .getBusinesses:
            return "/v3/businesses/search"
        }
    }
    
    var method: String {
        switch self {
        case .getBusinesses:
            return "GET"
        }
    }
    
    var queryParams: [URLQueryItem] {
        var result: [URLQueryItem] = []
        switch self {
        case .getBusinesses(let latitude, let longitude):
            result.append(URLQueryItem(name: "radius", value: "1000"))
            result.append(URLQueryItem(name: "sort_by", value: "distance"))
            result.append(URLQueryItem(name: "categories", value: "pizza,mexican,chinese,burgers"))
            result.append(URLQueryItem(name: "latitude", value: "\(latitude ?? 40.758896)"))
            result.append(URLQueryItem(name: "longitude", value: "\(longitude ?? -73.985130)"))
           
        }
        return result
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryParams
        return components.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
}

