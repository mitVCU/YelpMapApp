//
//  ViewController.swift
//  GradientTableView
//
//  Created by mit on 9/16/21.
//

import UIKit



class RestaurantListViewController: UIViewController {

    @IBOutlet weak var restaurantTableView: UITableView!
    
    var places : [Business] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        configureGradientBackground()
        configureTableViewHeaderFooter()
        
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
        
        restaurantTableView.register(RestaurantTableViewCell().nib(), forCellReuseIdentifier: RestaurantTableViewCell().identifier)
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
        
        restaurantTableView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)

    }


}

extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = restaurantTableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell().identifier) as? RestaurantTableViewCell {
            cell.titleLabel.text = places[indexPath.row].name
            cell.subHeaderLabel.text = "\(places[indexPath.row].price ?? "$$$$") * \(places[indexPath.row].distance ?? 0.1) miles"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        return UITableViewCell()
    }
    
}
