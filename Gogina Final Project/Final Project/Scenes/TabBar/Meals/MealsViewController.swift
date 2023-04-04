//
//  MealsViewController.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/10/23.
//

import UIKit

class MealsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    
    //MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var mealAPIManager: MealManagerProtocol = MealManager()
    var meals: [Meal] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var selectedType: MealType = .seafood
    

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "00425A")
        navigationController?.navigationBar.tintColor = UIColor.white
        setupSegmentUI()
        mealSearchNavigationBar()
        hideKeyboardWhenTappedAround()
        setupTableView()
        fetchMeals()
    }
    

    //MARK: - Actions
    @IBAction func didTapMealType(_ sender: UISegmentedControl) {
        guard let mealType = MealType(rawValue: sender.selectedSegmentIndex) else {return}
        selectedType = mealType
        fetchMeals(with: mealType)
    }
    
    //MARK: - Methods
    func setupSegmentUI() {
        segmentedControlOutlet.backgroundColor = UIColor(hex: "00425A")
        segmentedControlOutlet.selectedSegmentTintColor = UIColor(hex: "00425A")
        segmentedControlOutlet.layer.borderWidth = 1
        segmentedControlOutlet.layer.borderColor = UIColor.black.cgColor
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControlOutlet.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControlOutlet.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    func mealSearchNavigationBar() {
        searchController.searchBar.searchTextField.tintColor = UIColor.white
        searchController.searchBar.searchTextField.backgroundColor = UIColor(hex: "6096B4")
        
        //title = "Search"  --  BUG 💀
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MealsTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "MealsTableViewCell")
        self.tableView.backgroundColor = UIColor(hex: "2B3A55")
    }
    
    func fetchMeals(with type: MealType = .seafood) {
        mealAPIManager.fetchMeal(with: type) { result in
            switch result {
            case .success(let mealResponse):
                self.meals = mealResponse.meals
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

//MARK: - Extension - UISearchResultsUpdating
extension MealsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        if text.isEmpty {
            fetchMeals(with: selectedType)
        } else {
            self.meals = self.meals.filter({$0.name!.lowercased().contains(text.lowercased())})
        }
    }
}

//MARK: - Extension - UITableViewDelegate
extension MealsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = UIStoryboard(name: "MealDetails", bundle: nil).instantiateViewController(withIdentifier: "MealDetails") as! MealDetailsViewController
        detailsVC.meals = meals[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - Extension - UITableViewDataSource
extension MealsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealsTableViewCell", for: indexPath) as! MealsTableViewCell
        cell.configure(with: meals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
    }
}
