//
//  MainTabBarController.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/10/23.
//

import UIKit

// UITabBarController

class MainTabBarController: UITabBarController {
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // - 1 -
        //UITabBar.appearance().barTintColor = UIColor(hex: "00425A")
        
        setupNavBarAndTabBar()
        print("Git")
    }
    
    //MARK: - Methods
    
    func setupNavBarAndTabBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        navigationBarAppearance.backgroundColor = UIColor(hex: "00425A")
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor = UIColor(hex: "00425A")
        UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        UITabBar.appearance().standardAppearance = tabBarApperance
        
        UITabBar.appearance().tintColor = UIColor.white
        //UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
     
}


