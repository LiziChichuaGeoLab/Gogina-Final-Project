//
//  UISearchBar + Extension.swift
//  Final Project
//
//  Created by Giorgi Goginashvili on 2/28/23.
//

import UIKit

public extension UISearchBar {

     func setNewcolor(color: UIColor) {
        let clrChange = subviews.flatMap { $0.subviews }
        guard let sc = (clrChange.filter { $0 is UITextField }).first as? UITextField else { return }
        sc.textColor = color
    }
}

//public extension UISearchBar {
//    func setNewColor(color: UIColor) {
//        let colorChange = subviews.flatMap {$0.subviews}
//        guard let sc = (colorChange.filter {$0 is UITextField}).first as? UITextField else { return}
//        sc.textColor = color
//    }
//}
