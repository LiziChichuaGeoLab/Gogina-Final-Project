//
//  UIViewController + Extensions.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/13/23.
//

import UIKit

extension CocktailsViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(CocktailsViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.searchController.isActive = false
        self.searchController.searchBar.resignFirstResponder()
        self.searchController.searchBar.endEditing(true)
    }
}

extension MealsViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(MealsViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.searchController.isActive = false
        self.searchController.searchBar.resignFirstResponder()
        self.searchController.searchBar.endEditing(true)
    }
}
