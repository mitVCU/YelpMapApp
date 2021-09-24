//
//  PlacesListViewModel.swift
//  GradientTableView
//
//  Created by mit on 9/23/21.
//

import Foundation
import UIKit
class PlacesListViewModel {
    var places: [Business]
    
    init(places: [Business]?) {
        self.places = places ?? []
    }
    
    func formatPriceText(_ price: String?) -> NSMutableAttributedString {
        let grayAttribute = [NSAttributedString.Key.foregroundColor: UIColor.gray]

        let basePrice = "$$$$"
        let range = (basePrice as NSString).range(of: price ?? "")
        
        let base = NSAttributedString(string: basePrice, attributes: grayAttribute)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(base)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: range)

        return mutableAttributedString
    }
    
    func getDetailsText(price: String?, distance: Double?) -> NSMutableAttributedString {
        let priceText = formatPriceText(price)
        let distanceInMiles = distance?.inMiles()
        
        let mutableAttributedString = NSMutableAttributedString()
        
        let grayAttribute = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        mutableAttributedString.append(priceText)
        
        let bulletAttributedString = NSAttributedString(string: " \u{2022} \(distanceInMiles ?? 0.0) miles", attributes: grayAttribute)
        mutableAttributedString.append(bulletAttributedString)
        
        return mutableAttributedString
    }
}

extension Double {
    func inMiles() -> Double {
        return (self * 0.000621371192).truncate(places: 2)
      }
    
    func truncate(places : Int)-> Double {
            return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
