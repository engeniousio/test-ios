//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

final class RepoTableViewCell: UITableViewCell {

    lazy var nameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        titleLabel.text = ""
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        descriptionLabel.text = ""
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .vertical;
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.alignment = .leading;
        stackView.distribution = .fill;
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16.0, leading: 16.0, bottom: 16.0, trailing: 16.0)
        stackView.layer.cornerRadius = 8.0
        return stackView
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }

    func initialize() {
        /// Setup layout
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        ])
    }
}
