//
//  MapViewModel.swift
//  GradientTableView
//
//  Created by mit on 9/21/21.
//

import Foundation
import CoreLocation
class MapViewModel {
    var places: [Business]?
    var userLocation: CLLocation?
    
    init(places: [Business]?, location: CLLocation?) {
        self.places = places
        self.userLocation = location
    }
    
    func placesCoor() -> [CLLocationCoordinate2D] {
        guard let places = places else {
            return []
        }
        
        let res: [CLLocationCoordinate2D?] = places.map { place in
            if let coordinate = place.coordinates {
                return CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)

            }
            return nil
        }
        
        return res.compactMap({$0})
    }
    
    
}
