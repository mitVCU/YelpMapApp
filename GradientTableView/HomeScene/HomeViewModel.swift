//
//  HomeViewModel.swift
//  GradientTableView
//
//  Created by mit on 9/18/21.
//

import Foundation
import CoreLocation
protocol HomeViewModelDelegate: AnyObject {
    func didUpdateState()
}


class HomeViewModel {
    enum State {
        case loading
        case success
        case failure
    }
    
    var state: State {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdateState()
            }
        }
    }
    
    var userLocation: CLLocation? {
        didSet {
            retrieveFoodPlaces()
        }
    }
    
    private let dispatchGroup = DispatchGroup()
    private var anyError: Error?
    
    weak var delegate: HomeViewModelDelegate?
    
    var places: [Business]?
    
    init() {
        state = .loading
    }
    
    
    func retrieveFoodPlaces() {
        let lat: Double? = userLocation?.coordinate.latitude
        let long: Double? = userLocation?.coordinate.longitude
        NetworkService.request(.getBusinesses(latitude: lat, longitude: long)) { (result: Result<Businesses, Error>) in
            switch result {
            case .success(let places):
                self.places = places.businesses
                self.state = .success
            case .failure(let error):
                self.anyError = error
                print(error, " :Network error")
                self.state = .failure
            }
        }
    }
    
}
