//
//  MaskView.swift
//  GradientTableView
//
//  Created by Mit Amin on 12/24/21.
//

import Foundation
import UIKit

enum PlaceType: String {
    case burgers
    case mexican
    case chinese
    case pizza
}

class IconView: UIView {
    let centralView = UIView()
    
    init(frame: CGRect, place: PlaceType) {
        super.init(frame: frame)
        self.addSubview(self.centralView)
        self.backgroundColor = .clear
        self.centralView.backgroundColor = .red
        self.centralView.clipsToBounds = true
        self.centralView.frame = CGRect(x: 16, y: 16, width: 32, height: 32)
        self.centralView.center = CGPoint(x: 32, y: self.frame.height / 2)
        // Set mask to imageview that will shape the icon
        let image = UIImage(named: place.rawValue)!
        self.centralView.mask = UIImageView(image: image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Do not touch anything in here
    func createMask() -> UIImageView? {
        self.backgroundColor = .white
        
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }

        guard let ciImage = CIImage(image: image)?.applyingFilter("CIMaskToAlpha") else { return nil }

        // Create a UIImage
        let maskImage = UIImage(ciImage: ciImage)
        // Create a UIImageView from the UIImage
        let imageView = UIImageView(image: maskImage)
        // Set the bounds
        imageView.frame = self.bounds
        // Return the imageView
        return imageView
    }
}
