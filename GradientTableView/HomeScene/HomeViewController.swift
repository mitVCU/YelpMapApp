//
//  HomeViewController.swift
//  GradientTableView
//
//  Created by mit on 9/18/21.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    private lazy var placesViewController: RestaurantListViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(identifier: "RestaurantListViewController") as! RestaurantListViewController
        viewController.viewModel = PlacesListViewModel(places: viewModel.places ?? [])
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var mapViewController: MapViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(identifier: "MapViewController") as! MapViewController
        viewController.viewModel = MapViewModel(places: viewModel.places, location: viewModel.userLocation)
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    var viewModel: HomeViewModel!
    private let manager = CLLocationManager()

    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!

    @IBAction func didTapSegmentControl(_ sender: UISegmentedControl) {
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        viewModel.delegate = self
        configureSegmentControl()
        didUpdateState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestLocation()
        }
    }
    
    func configureSegmentControl() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedController.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    func updateView() {
        mapViewController.view.isHidden = segmentedController.selectedSegmentIndex != 0
        placesViewController.view.isHidden = segmentedController.selectedSegmentIndex == 0
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            viewModel.userLocation = location
        } else {
            viewModel.userLocation = CLLocation(latitude: CLLocationDegrees(40.758896), longitude: CLLocationDegrees(-73.985130))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        viewModel.userLocation = CLLocation(latitude: CLLocationDegrees(40.758896), longitude: CLLocationDegrees(-73.985130))
        print(error, " :Error \n")
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didUpdateState() {
        switch viewModel.state {
        case .loading:
            loadingSpinner.startAnimating()
            loadingSpinner.hidesWhenStopped = true
            segmentedController.selectedSegmentIndex = 0
            segmentedController.isHidden = true
            containerView.isHidden = true
        case .success:
            loadingSpinner.stopAnimating()
            segmentedController.isHidden = false
            containerView.isHidden = false
            updateView()
        case .failure:
            print("ERRROOORR")
        }
    }
}
