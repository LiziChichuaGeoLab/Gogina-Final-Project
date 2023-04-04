//
//  CocktailsTableViewCell.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/13/23.
//

import UIKit
import Kingfisher

class CocktailsTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cocktailImageView.layer.cornerRadius = 20
        cocktailName.textColor = .white
        cocktailImageView.layer.borderWidth = 1
        cocktailImageView.layer.borderColor = UIColor.black.cgColor
        cocktailImageView.backgroundColor = .white
        cocktailImageView.sizeToFit()
    }
    
    //MARK: -  Methods
    func configure(with drink: Drink) {
        guard let image = drink.image else { return }
        cocktailName.text = drink.name
        cocktailImageView.kf.indicatorType = .activity
        cocktailImageView.kf.setImage(with: URL(string: image))
    }
    
}
