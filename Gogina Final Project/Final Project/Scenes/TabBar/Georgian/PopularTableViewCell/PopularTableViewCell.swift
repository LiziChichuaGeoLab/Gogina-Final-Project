//
//  PopularTableViewCell.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/21/23.
//

import UIKit

protocol PopularCollectionViewCellDelegate: AnyObject {
    func didSelectPopularItem(with food: Georgian)
}

class PopularTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: - Properties
    weak var delegate: PopularCollectionViewCellDelegate?
    var food = [Georgian]() {
        didSet {
            self.collectionView.reloadData()
        }
    }

    //MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = .white
        configureCollectionView()
    }

    //MARK: - Methods
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PopularCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: "PopularCollectionViewCell")
        self.collectionView.backgroundColor = UIColor(hex: "2B3A55")
    }
    
}

//MARK: - UICollectionViewDelegate
extension PopularTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        self.delegate?.didSelectPopularItem(with: food[indexPath.row])
    }
}

//MARK: - UICollectionViewDataSource
extension PopularTableViewCell:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        food.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
        cell.configure(with: food[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PopularTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
