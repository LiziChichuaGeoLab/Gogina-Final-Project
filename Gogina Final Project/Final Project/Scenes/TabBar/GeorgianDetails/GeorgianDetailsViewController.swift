//
//  GeorgianDetailsViewController.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/22/23.
//

import UIKit
import Kingfisher
import youtube_ios_player_helper
import AVFoundation

class GeorgianDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var calLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var ingrLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var prepLabel: UILabel!
    @IBOutlet weak var preparationLabel: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var favoriteCheckImageView: UIImageView!
    @IBOutlet weak var viewForScroll: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    //MARK: - Properties
    var geoFood: Georgian?
    var isChecked = false
    var player: AVAudioPlayer!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIComponents()
        setupUI()
        setupFavoriteCheckBox()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerView.stopVideo()
    }
    
    //MARK: - Methods
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func setupUIComponents() {
        nameLabel.textColor =  .white
        calLabel.textColor = .white
        caloriesLabel.textColor = .white
        ingrLabel.textColor = .white
        ingredientsLabel.textColor = .white
        prepLabel.textColor = .white
        preparationLabel.textColor = .white
        view.backgroundColor = UIColor(hex: "2B3A55")
        viewForScroll.backgroundColor = UIColor(hex: "2B3A55")
        imageView.layer.cornerRadius = 20
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
            if let geoFood = geoFood {
                GeorgianFavorites.shared.geoFavFood.removeAll{$0.name == geoFood.name}
            }
        } else {
            imageName = "heart_checked"
            favoriteCheckImageView.image = UIImage(named: imageName)
            playSound(soundName: "like_sound")
            if let geoFood = geoFood {
                GeorgianFavorites.shared.geoFavFood.append(geoFood)
            }
            print(GeorgianFavorites.shared.geoFavFood)
        }
        favoriteCheckImageView.image = UIImage(named: imageName)
        isChecked.toggle()
        
//        let imageName = isChecked ? "heart" : "heart_checked"
//        favoriteCheckImageView.image = UIImage(named: imageName)
//        isChecked.toggle()
        
    }
    
    func setupUI() {
        guard let food = geoFood,
              let image = food.image,
              let video = food.video else {return}
        var ingredients: String = ""
        var instructions: String = ""
        nameLabel.text = food.name
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: image))
        caloriesLabel.text = "\(food.cal ?? 0)"
        food.ingredients?.forEach({ingredients += "● \($0)\n"})
        ingredientsLabel.text = ingredients
        food.instructions?.forEach({instructions += "● \($0)\n\n"})
        preparationLabel.text = instructions
        playerView.delegate = self
        self.playerView.load(withVideoId: "\(video)", playerVars: ["playsinline": 1])
        
        if GeorgianFavorites.shared.geoFavFood.contains(where: {$0.name ==  food.name}) {
            isChecked = true
            favoriteCheckImageView.image = UIImage(named: "heart_checked")
        } else {
            favoriteCheckImageView.image = UIImage(named: "heart")
        }
        
//        DispatchQueue.global().async {
//            self.playerView.load(withVideoId: "\(video)", playerVars: ["playsinline": 1])
//        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.playerView.load(withVideoId: "\(video)", playerVars: ["playsinline": 1])
//        }
        
//        DispatchQueue.main.async {
//            self.playerView.load(withVideoId: "\(video)", playerVars: ["playsinline": 1])
//        }
    }
}

extension GeorgianDetailsViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.stopVideo()
    }
}
