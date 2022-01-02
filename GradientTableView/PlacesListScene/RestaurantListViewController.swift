//
//  ViewController.swift
//  GradientTableView
//
//  Created by mit on 9/16/21.
//

import UIKit



class RestaurantListViewController: UIViewController {

    @IBOutlet weak var restaurantTableView: UITableView!
    
    var viewModel: PlacesListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        configureGradientBackground()
        configureTableViewHeaderFooter()
        
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
        
        restaurantTableView.register(PlaceTableViewCell.nib(), forCellReuseIdentifier: PlaceTableViewCell.identifier)
    }
    
    func configureGradientBackground() {
        
        let gradientBackgroundColors = [
            UIColor.red.cgColor,
            UIColor.blue.cgColor
        ]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = [0, 1]

        gradientLayer.frame = restaurantTableView.bounds
        let backgroundView = UIView(frame: restaurantTableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        restaurantTableView.backgroundView = backgroundView
    }
    
    func configureTableViewHeaderFooter() {
        var topFrame = restaurantTableView.bounds
        topFrame.origin.y = -topFrame.size.height
        topFrame.size.height = topFrame.size.height
        topFrame.size.width = UIScreen.main.bounds.size.width
        let topView = UIView(frame: topFrame)
        topView.backgroundColor = UIColor.white
        restaurantTableView.addSubview(topView)
        
        restaurantTableView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: -restaurantTableView.frame.height, right: 0)
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: restaurantTableView.frame.width, height: restaurantTableView.frame.height))
        customView.backgroundColor = UIColor.white
        restaurantTableView.tableFooterView = customView
        
        self.restaurantTableView.separatorStyle = .none

    }

}

extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.places.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let place = viewModel.places[indexPath.row]

        guard let cell = cell as? PlaceTableViewCell else { return }
        guard let placeType = viewModel.getPlaceType(place: place) else { return }
        
        cell.setIcon(place: placeType)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = restaurantTableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier) as? PlaceTableViewCell else { return UITableViewCell() }
        let place = viewModel.places[indexPath.row]
        cell.tileLabel.text = place.name
        cell.subTitleLabel.attributedText = viewModel.getDetailsText(price: place.price, distance: place.distance)
        cell.backgroundColor = .white
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PlacesDetailViewController") else { return }
        let navController = UINavigationController(rootViewController: myVC)

        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    

    
}
