//
//  MealDetailsViewController.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/15/23.
//

import UIKit
import Kingfisher
import AVFoundation

class MealDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var calLabel: UILabel!
    @IBOutlet weak var ingrLabel: UILabel!
    @IBOutlet weak var prepLabel: UILabel!
    @IBOutlet weak var viewForScroll: UIView!
    @IBOutlet weak var favoriteCheckImageView: UIImageView!
    
    //MARK: - Properties
    var meals: Meal?
    var isChecked = false
    var player: AVAudioPlayer!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealImageView.layer.cornerRadius = 20
        setupComponentsUI()
        configureUI()
        setupFavoriteCheckBox()
    }
    
    //MARK: - Methods
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func setupComponentsUI() {
        nameLabel.textColor =  .white
        ingrLabel.textColor = .white
        ingredientsLabel.textColor = .white
        prepLabel.textColor = .white
        instructionLabel.textColor = .white
        calLabel.textColor = .white
        caloriesLabel.textColor = .white
        view.backgroundColor = UIColor(hex: "2B3A55")
        viewForScroll.backgroundColor = UIColor(hex: "2B3A55")
        mealImageView.layer.cornerRadius = 20
        
    }
    
    func configureUI() {
        guard let meals = meals else { return }
        var ingredient = ""
        var instruction = ""
        mealImageView.kf.indicatorType = .activity
        mealImageView.kf.setImage(with: URL(string: meals.image ?? ""))
        nameLabel.text = meals.name
        caloriesLabel.text = "\(meals.calories ?? 0)"
        meals.ingredients?.forEach({ingredient += "● \($0)\n"})
        ingredientsLabel.text = ingredient
        meals.instructions?.forEach({instruction += "● \($0)\n\n"})
        instructionLabel.text = instruction
        
        if MealFavorites.shared.mealFavFood.contains(where: {$0.name == meals.name}) {
            isChecked = true
            favoriteCheckImageView.image = UIImage(named: "heart_checked")
        } else {
            favoriteCheckImageView.image = UIImage(named: "heart")
        }
    }
    
    func setupFavoriteCheckBox() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        favoriteCheckImageView.isUserInteractionEnabled = true
        favoriteCheckImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped() {
        var imageName = ""
        if isChecked {
            imageName = "heart"
            favoriteCheckImageView.image = UIImage(named: imageName)
            if let meals = meals {
                MealFavorites.shared.mealFavFood.removeAll{$0.name == meals.name}
            }
        } else {
            imageName = "heart_checked"
            favoriteCheckImageView.image = UIImage(named: imageName)
            playSound(soundName: "like_sound")
            if let meals = meals {
                MealFavorites.shared.mealFavFood.append(meals)
            }
            print(MealFavorites.shared.mealFavFood)
        }
        favoriteCheckImageView.image = UIImage(named: imageName)
        isChecked.toggle()
    }
    
}


