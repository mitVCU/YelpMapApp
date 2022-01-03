//
//  ImageView+Ext.swift
//  GradientTableView
//
//  Created by Mit Amin on 1/2/22.
//

import Foundation
import UIKit

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
