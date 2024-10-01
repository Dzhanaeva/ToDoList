//
//  Extension.swift
//  To Do List
//
//  Created by Гидаят Джанаева on 02.09.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView ...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
