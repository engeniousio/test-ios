//
//  ReposHeaderView.swift
//  engenious-challenge
//
//  Created by Sergii Tkachenko on 28.05.2022.
//

import UIKit

final class ReposHeaderView: UIView {

    lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        headerLabel.text = "Header text"
        headerLabel.textAlignment = .left
        headerLabel.textColor = .black
        return headerLabel
    }()

    @available(*, unavailable)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    init() {
        super.init(frame: .zero)
        self.initialize()
    }

    func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        /// Setup layout
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            headerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
