//
//  GeorgianViewController.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/21/23.
//

import UIKit

class GeorgianViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Properties
    var georgianAPIManager: GeorgianManagerProtocol = GeorgianManager()
    let searchController = UISearchController(searchResultsController: nil)
    var selectType: GeoType?
    var popularFood: [Georgian] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var bakedFood: [Georgian] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var christmasFood: [Georgian] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "00425A")
        titleLabel.backgroundColor = UIColor(hex: "00425A")
        titleLabel.textColor = .white
        setupNavigationBar()
        searchNavigationBar()
        setupTableView()
        fetchFood()
    }
    
    //MARK: - Methods
    func searchNavigationBar() {
        searchController.searchBar.searchTextField.tintColor = .white
        searchController.searchBar.searchTextField.backgroundColor = UIColor(hex: "6096B4")
        navigationItem.searchController = searchController
        searchController.delegate = self
        searchController.searchResultsUpdater = self
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")
        tableView.register(UINib(nibName: "BakedTableViewCell", bundle: nil),       forCellReuseIdentifier: "BakedTableViewCell")
        tableView.register(UINib(nibName: "ChristmasTableViewCell", bundle: nil), forCellReuseIdentifier: "ChristmasTableViewCell")
        self.tableView.backgroundColor = UIColor(hex: "2B3A55")
    }
    
    func fetchFood() {
        georgianAPIManager.fetchGeoFood(with: .popular) { result in
            switch result {
            case .success(let foodResponse):
                self.popularFood = foodResponse.meals
                //print(foodResponse.meals)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        georgianAPIManager.fetchGeoFood(with: .baked) { result in
            switch result {
            case .success(let foodResponse):
                self.bakedFood = foodResponse.meals
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        georgianAPIManager.fetchGeoFood(with: .christmas) { result in
            switch result {
            case .success(let foodResponse):
                self.christmasFood = foodResponse.meals
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

//MARK: - UITableViewDelegate
extension GeorgianViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension GeorgianViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GeoType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let category = GeoType(rawValue: indexPath.row) else {return UITableViewCell()}
        switch category {
        case .popular:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
            cell.food = popularFood
            //
            cell.delegate = self
            return cell
        case .baked:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BakedTableViewCell", for: indexPath) as! BakedTableViewCell
            cell.food = bakedFood
            cell.delegate = self
            return cell
        case .christmas:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChristmasTableViewCell", for: indexPath) as! ChristmasTableViewCell
            cell.food = christmasFood
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

//MARK: - PopularCollectionViewCellDelegate
//
extension GeorgianViewController: PopularCollectionViewCellDelegate {
    func didSelectPopularItem(with food: Georgian) {
        let storyBoard = UIStoryboard(name: "GeorgianDetails", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "GeorgianDetails") as! GeorgianDetailsViewController
        detailsVC.geoFood = food
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - BakedCollectionViewCellDelegate
extension GeorgianViewController: BakedCollectionViewCellDelegate  {
    func didSelectBakedItem(with food: Georgian) {
        let storyBoard = UIStoryboard(name: "GeorgianDetails", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "GeorgianDetails") as! GeorgianDetailsViewController
        detailsVC.geoFood = food
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - ChristmasCollectionViewCellDelegate
extension GeorgianViewController: ChristmasCollectionViewCellDelegate {
    func didSelectChristmasItem(with food: Georgian) {
        let storyBoard = UIStoryboard(name: "GeorgianDetails", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "GeorgianDetails") as! GeorgianDetailsViewController
        detailsVC.geoFood = food
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARKL - UISearchControllerDelegate - UISearchResultsUpdating
extension GeorgianViewController: UISearchControllerDelegate {
    
}
extension GeorgianViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        if text.isEmpty {
            fetchFood()
        } else {
            self.popularFood = self.popularFood.filter({$0.name!.lowercased().contains(text.lowercased())})
//            self.popularFood = self.popularFood.filter({$0.name!.lowercased().contains(text.lowercased())})
//            self.bakedFood = self.bakedFood.filter({$0.name!.lowercased().contains(text.lowercased())})
//            self.christmasFood = self.christmasFood.filter({$0.name!.lowercased().contains(text.lowercased())})
        }
    }
}
