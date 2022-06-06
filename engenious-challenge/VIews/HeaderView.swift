//
//  HeaderView.swift
//  engenious-challenge
//
//  Created by Alex Kogut on 06.06.2022.
//

import UIKit

final class HeaderView: UIView {
    
    // MARK: - Outlet
    private let textLabel = UILabel()
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    // MARK: - Private Method
    private func initialize() {
        backgroundColor = .clear
        self.addSubview(textLabel)
        textLabel.setConstraint(to: self, top: 16, leading: 20.5, trailing: -20, bottom: -16)
    }
    
    // MARK: - Internal Methods
    func setup(with text: String) {
        textLabel.text = text
        textLabel.textColor = .kSecondary
        textLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        textLabel.numberOfLines = 0
        textLabel.autoresizingMask = .flexibleWidth
    }
}
