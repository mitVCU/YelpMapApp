//
//  PlacesDetailViewController.swift
//  GradientTableView
//
//  Created by mit on 9/23/21.
//

import UIKit
import MapKit
import CoreLocation

class PlacesDetailViewController: UIViewController {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var callBusinessButton: UIButton!
    
    var viewModel: PlacesDetailViewModel!
    var userLocation: CLLocationCoordinate2D!
    var destinationLocation: CLLocationCoordinate2D!
    
    init(place: Business, userLocation: CLLocation) {
        viewModel = PlacesDetailViewModel(place: place)
        self.userLocation = userLocation.coordinate
        self.destinationLocation = CLLocationCoordinate2D(latitude: place.coordinates!.latitude, longitude: place.coordinates!.longitude)
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        
        self.mapView.delegate = self

        configureCallBusinessButton()
        configureImageView()
        configureNameLabel()
        configureShareButton()
        
        createPath(sourceLocation: userLocation, destinationLocation: destinationLocation)
    }
    
    func configureNameLabel() {
        restaurantNameLabel.text = viewModel.place.name
    }
    
    func configureCallBusinessButton() {
        callBusinessButton.setTitle("Call Business", for: .normal)
        callBusinessButton.layer.cornerRadius = 6
        callBusinessButton.backgroundColor = .systemPurple
        callBusinessButton.addTarget(self, action: #selector(call), for: .touchUpInside)
    }
    
    func configureImageView() {
        restaurantImageView.fetchImage(url: viewModel.place.image_url)
    }
    
    func configureShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "square.and.arrow.up"), style: .plain, target: self, action: #selector(share))
    }
    
    @objc func share() {
        let shareAll = [viewModel.place.url!]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func call() {
        
        guard let placeNumber = viewModel.place.phone, !placeNumber.isEmpty, let number = URL(string: "tel://" + placeNumber) else {
            let alert = UIAlertController(title: "Alert", message: "No Phone Number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        UIApplication.shared.open(number)
    }
}

extension PlacesDetailViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let rendere = MKPolylineRenderer(overlay: overlay)
        rendere.lineWidth = 4
        rendere.strokeColor = .systemBlue
        
        return rendere
    }
    
    
    func createPath(sourceLocation : CLLocationCoordinate2D, destinationLocation : CLLocationCoordinate2D) {
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        
        let sourceAnotation = MKPointAnnotation()
        if let location = sourcePlaceMark.location {
            sourceAnotation.coordinate = location.coordinate
        }
        
        let destinationAnotation = MKPointAnnotation()
        if let location = destinationPlaceMark.location {
            destinationAnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnotation, destinationAnotation], animated: true)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("ERROR FOUND : \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            
        }
    }
}
