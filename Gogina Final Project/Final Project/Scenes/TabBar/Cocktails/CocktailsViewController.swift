//
//  CocktailsViewController.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/10/23.
//

import UIKit

class CocktailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    
    //MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var cocktailAPIManager: CocktailManagerProtocol = CocktailManager()
    var drinks: [Drink] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var selectedType: DrinkType = .alcoholic
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "00425A")
        navigationController?.navigationBar.tintColor = UIColor.white
        setupSegmentUI()
        searchNavigationBar()
        hideKeyboardWhenTappedAround()
        setupTableView()
        fetchDrinks()
    }
    
    //MARK: - Actions
    @IBAction func didTapDrinkType(_ sender: UISegmentedControl) {
        guard let drinkType = DrinkType(rawValue: sender.selectedSegmentIndex) else { return }
        selectedType = drinkType
        self.fetchDrinks(with: drinkType)
    }
    
    //MARK: - Methods
    func setupSegmentUI() {
        segmentedControlOutlet.backgroundColor = UIColor(hex: "00425A")
        segmentedControlOutlet.selectedSegmentTintColor = UIColor(hex: "00425A")
        segmentedControlOutlet.layer.borderWidth = 1
        segmentedControlOutlet.layer.borderColor = UIColor.black.cgColor //UIColor(hex: "00425A").cgColor
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControlOutlet.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControlOutlet.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    func searchNavigationBar() {        
        searchController.searchBar.searchTextField.tintColor = .white
        searchController.searchBar.searchTextField.backgroundColor = UIColor(hex: "6096B4")
        //let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        
        navigationItem.searchController = searchController
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CocktailsTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "CocktailsTableViewCell")
        self.tableView.backgroundColor = UIColor(hex: "00425A") //UIColor(hex: "00425A")2B3A55
        
    }
    
    func fetchDrinks(with type: DrinkType = .alcoholic) {
        cocktailAPIManager.fetchDrinks(with: type) { result in
            switch result {
            case .success(let drinkResponse):
                self.drinks = drinkResponse.drinks
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

//MARK: - Extension - UISearchControllerDelegate
extension CocktailsViewController: UISearchControllerDelegate {
    
}

//MARK: - Extension - UISearchResultsUpdating
extension CocktailsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        if text.isEmpty {
            fetchDrinks(with: selectedType)
        } else {
            self.drinks = self.drinks.filter({$0.name!.lowercased().contains(text.lowercased())})
        }
    }
}

//MARK: - Extension - UITableViewDelegate
extension CocktailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = UIStoryboard(name: "CocktailDetails", bundle: nil).instantiateViewController(withIdentifier: "CocktailDetails") as! CocktailDetailsViewController
        detailsVC.drinks = drinks[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - Extension - UITableViewDataSource
extension CocktailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailsTableViewCell", for: indexPath) as! CocktailsTableViewCell
        cell.configure(with: drinks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 00425A   -   2B3A55
        cell.backgroundColor = UIColor(hex: "2B3A55") //UIColor.clear
        cell.layer.borderWidth = 1
        cell.layer.borderColor  = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
    }
    
    
}
