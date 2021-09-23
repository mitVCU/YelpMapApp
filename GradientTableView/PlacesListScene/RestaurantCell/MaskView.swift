//
//  MaskView.swift
//  GradientTableView
//
//  Created by mit on 9/17/21.
//

import Foundation
import UIKit
class MaskView: UIView {

    let centralView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.centralView)
        self.backgroundColor = .clear
        
        let mask = CAShapeLayer()
        
        let image = UIImage(named: "burger")
        mask.contents = image?.cgImage

        mask.frame.size = CGSize(width: 32, height: 32)

        mask.fillColor = UIColor.clear.cgColor
        
//        self.centralView.backgroundColor = .red
//        self.centralView.clipsToBounds = true
        self.centralView.center = CGPoint(x: 32, y: 32)
        self.centralView.bounds.size = CGSize(width: 32, height: 32)
        self.centralView.layer.mask = mask
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createMask() -> UIImageView? {
        let prevBGColor = self.backgroundColor
        defer {
            self.backgroundColor = prevBGColor
        }

        self.backgroundColor = .white
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }

        guard let ciImage = CIImage(image: image)?.applyingFilter("CIMaskToAlpha") else {
            return nil
        }

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
