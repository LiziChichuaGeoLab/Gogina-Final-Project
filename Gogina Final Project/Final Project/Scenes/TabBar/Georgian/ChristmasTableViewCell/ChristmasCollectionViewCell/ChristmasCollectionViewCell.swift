//
//  ChristmasCollectionViewCell.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/21/23.
//

import UIKit
import Kingfisher

class ChristmasCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var cornerRadius = 20.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        
        foodImageView.layer.cornerRadius = 20
        foodImageView.layer.borderWidth = 1
        foodImageView.layer.borderColor = UIColor.black.cgColor
        nameLabel.textColor = .white
    }
    
    
    
    func configure(with food: Georgian) {
        guard let image = food.image else {return}
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: URL(string: image))
        nameLabel.text = food.name
    }

}
