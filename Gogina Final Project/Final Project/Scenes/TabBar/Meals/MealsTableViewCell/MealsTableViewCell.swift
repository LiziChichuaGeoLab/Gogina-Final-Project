//
//  MealsTableViewCell.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/13/23.
//

import UIKit
import Kingfisher

class MealsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mealImageView.layer.cornerRadius = 20
        mealName.textColor = .white
        mealImageView.layer.borderWidth = 1
        mealImageView.layer.borderColor = UIColor.black.cgColor
    }
    
    func configure(with meal: Meal) {
        guard let image = meal.image else { return }
        mealName.text = meal.name
        mealImageView.kf.indicatorType = .activity
        mealImageView.kf.setImage(with: URL(string: image))
    }
    
}
