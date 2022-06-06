//
//  UIView.swift
//  engenious-challenge
//
//  Created by Alex Kogut on 06.06.2022.
//

import UIKit

extension UIView {
    
    func setGradientBackground(top:UIColor, bottom: UIColor) {
        let colorTop =  top
        let colorBottom = bottom
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 8
        
        layer.shadowOffset = CGSize(width: 1, height: 5)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.masksToBounds = false
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setEqualToConstraint(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setConstraint(to view: UIView, top: CGFloat, leading: CGFloat, trailing: CGFloat, bottom: CGFloat)  {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
    }
}
