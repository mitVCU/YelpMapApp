//
//  MapViewController.swift
//  GradientTableView
//
//  Created by mit on 9/18/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        render()
    }
    
    func render() {
        guard let coordinate = viewModel.userLocation?.coordinate else {
            print("Problem with coor")
            return
        }
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        mapView.setRegion(region, animated: false)
        createPins()
    }
    
    func createPins() {
        for coor in viewModel.placesCoor() {
            let pin = MKPointAnnotation()
            pin.coordinate = coor
            mapView.addAnnotation(pin)
        }
    }
    
    
}
