//
//  FavoritesTableViewCell.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/27/23.
//

import UIKit
import Kingfisher

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textColor = .white
        foodImageView.layer.borderWidth = 1
        foodImageView.layer.borderColor = UIColor.black.cgColor
        foodImageView.layer.cornerRadius = 20
        foodImageView.sizeToFit()
    }
    
    func configure(with drink: Drink) {
        guard let image = drink.image else {return}
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: URL(string: image))
        nameLabel.text = drink.name
    }
    
    func configure(with meal: Meal) {
        guard let image = meal.image else {return}
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: URL(string: image))
        nameLabel.text = meal.name
    }

    func configure(with food: Georgian) {
        guard let image = food.image else {return}
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: URL(string: image))
        nameLabel.text = food.name
    }
    
}
