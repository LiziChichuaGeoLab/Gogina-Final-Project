//
//  FavoritesViewController.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/15/23.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedOutlet: UISegmentedControl!
    
    //MARK: - Properties
    var favoriteDrinks = CocktailFavorites.shared.cocktailFavoriteDrinks
    var favoriteMeals = MealFavorites.shared.mealFavFood
    var favoriteGeorgian = GeorgianFavorites.shared.geoFavFood //{
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = UIColor.white
        view.backgroundColor = UIColor(hex: "00425A")
        configureSegmentUI()
        configureTableView()
        //tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteDrinks = CocktailFavorites.shared.cocktailFavoriteDrinks
        favoriteMeals = MealFavorites.shared.mealFavFood
        favoriteGeorgian = GeorgianFavorites.shared.geoFavFood
        tableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func selectCategory(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    //MARK: - Methods
    func configureSegmentUI() {
        segmentedOutlet.backgroundColor = UIColor(hex: "00425A")
        segmentedOutlet.selectedSegmentTintColor = UIColor(hex: "00425A")
        segmentedOutlet.layer.borderWidth = 1
        segmentedOutlet.layer.borderColor = UIColor.black.cgColor
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedOutlet.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedOutlet.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesTableViewCell")
        tableView.backgroundColor = UIColor(hex: "2B3A55")
    }
}

//MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentedOutlet.selectedSegmentIndex {
        case 0:
            let detailsVC = UIStoryboard(name: "CocktailDetails", bundle: nil).instantiateViewController(withIdentifier: "CocktailDetails") as! CocktailDetailsViewController
            detailsVC.drinks = favoriteDrinks[indexPath.row]
            navigationController?.pushViewController(detailsVC, animated: true)
        case 1:
            let detailsVC = UIStoryboard(name: "MealDetails", bundle: nil).instantiateViewController(withIdentifier: "MealDetails") as! MealDetailsViewController
            detailsVC.meals = favoriteMeals[indexPath.row]
            navigationController?.pushViewController(detailsVC, animated: true)
        case 2:
            let detailsVC = UIStoryboard(name: "GeorgianDetails", bundle: nil).instantiateViewController(withIdentifier: "GeorgianDetails") as! GeorgianDetailsViewController
            detailsVC.geoFood = favoriteGeorgian[indexPath.row]
            navigationController?.pushViewController(detailsVC, animated: true)
        default:
            break
        }
    }
}

//MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedOutlet.selectedSegmentIndex {
        case 0:
            return favoriteDrinks.count
        case 1:
            return favoriteMeals.count
        case 2:
            return favoriteGeorgian.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        
        switch segmentedOutlet.selectedSegmentIndex {
        case 0:
            cell.configure(with: favoriteDrinks[indexPath.row])
        case 1:
            cell.configure(with: favoriteMeals[indexPath.row])
        case 2:
            cell.configure(with: favoriteGeorgian[indexPath.row])
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
    }
}
