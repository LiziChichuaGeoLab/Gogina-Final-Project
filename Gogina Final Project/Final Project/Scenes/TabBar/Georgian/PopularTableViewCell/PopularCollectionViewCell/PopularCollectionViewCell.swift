//
//  PopularCollectionViewCell.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/21/23.
//

import UIKit
import Kingfisher

class PopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.textColor = .white
        foodImageView.layer.cornerRadius = 20
    }
    
    func configure(with food: Georgian) {
        guard let image = food.image else {return}
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: URL(string: image))
        nameLabel.text = food.name
    }

}


