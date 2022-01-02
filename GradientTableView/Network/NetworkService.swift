//
//  NetworkService.swift
//  GradientTableView
//
//  Created by mit on 9/16/21.
//

import Foundation

private enum NetworkError: Error {
    case dataFailure
    case badResponse
    case badDecoding
}

class NetworkService {
    
    class func request<T: Decodable> (_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let urlRequest = endpoint.urlRequest else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.badResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }

            // TODO: Print statement for Debugging
//            if let JSONString = String(data: data
//                                       , encoding: String.Encoding.utf8) {
//               print(JSONString)
//            }
            
            if let resultModel = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(resultModel))
            } else {
                completion(.failure(NetworkError.badDecoding))
            }
            
        }.resume()
    }
    
}
