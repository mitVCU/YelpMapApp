//
//  RestaurantTableViewCell.swift
//  GradientTableView
//
//  Created by mit on 9/16/21.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    
    
    let identifier = "RestaurantTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        self.contentView.backgroundColor = .white
//
//        let backView = UIView(frame: contentView.frame)
//
//        let mask = MaskView(frame: backView.frame)
//        backView.mask = mask.createMask()
//
//        self.addSubview(backView)
        
    }

    func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
