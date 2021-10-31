//
//  PlacesDetailViewController.swift
//  GradientTableView
//
//  Created by mit on 9/23/21.
//

import UIKit
import MapKit

class PlacesDetailViewController: UIViewController {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var callBusinessButton: UIButton!
    
    var viewModel: PlacesDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureNameLabel() {
        restaurantNameLabel.text = viewModel.place.name
    }
    
    func configureCallBusinessButton() {
        callBusinessButton.setTitle("Call Business", for: .normal)
        callBusinessButton.layer.cornerRadius = 6
        callBusinessButton.backgroundColor = .systemPurple
    }
    
    func configureImageView() {
        restaurantImageView.fetchImage(url: viewModel.place.image_url)
    }
    
}

let cache = NSCache<NSString, UIImage>()

extension UIImageView {
    @discardableResult
    func fetchImage(url: URL?, placeholder: UIImage? = nil) -> URLSessionDataTask? {
        self.image = nil
        
        guard let url = url else {
            return nil
        }
        
        if let cachedImage = cache.object(forKey: NSString(string: url.absoluteString)) {
            self.image = cachedImage
            return nil
        }
        
        if let placeholder = placeholder {
            self.image = placeholder
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    cache.setObject(downloadedImage, forKey: NSString(string: url.absoluteString))
                    self.image = downloadedImage
                }
            }
        }
        task.resume()
        
        return task
    }
    
}
