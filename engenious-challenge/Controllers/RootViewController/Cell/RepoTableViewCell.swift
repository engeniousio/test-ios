//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

final class RepoTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    final let cardView: UIView = .init()
    final let stackView: UIStackView = .init()
    final let primaryTextLabel: UILabel = .init()
    final let secondaryTextLabel: UILabel = .init()
    
    // MARK: - Properties
    var item: RepoModel? {
        willSet {
            configure(item: newValue)
        }
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        setupLabels()
        setupStackView()
        setupView()
        setupLayouts()
    }
    
    private func setupLayouts() {
        // cardView
        contentView.addSubview(cardView)
        cardView.setConstraint(to: contentView, top: 8, leading: 20.5, trailing: -20.5, bottom: -8)
        
        // stackView
        cardView.addSubview(stackView)
        stackView.setConstraint(to: cardView, top: 16, leading: 16, trailing: -16, bottom: -16)
    }
    
    private func setupView() {
        cardView.backgroundColor = .kTopCellGradient
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 8
        cardView.setGradientBackground(top: .kTopCellGradient, bottom: .kBottomCellGradient)
    }
    
    private func setupStackView() {
        stackView.backgroundColor = .clear
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.addArrangedSubview(primaryTextLabel)
        stackView.addArrangedSubview(secondaryTextLabel)
        stackView.spacing = 5
    }
    
    private func setupLabels() {
        primaryTextLabel.textColor = .kSecondary
        primaryTextLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        primaryTextLabel.numberOfLines = 0
        
        secondaryTextLabel.textColor = .kPrimary
        secondaryTextLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        secondaryTextLabel.numberOfLines = 0
    }
    
    private func configure(item: RepoModel?) {
        primaryTextLabel.text = item?.name
        secondaryTextLabel.text = item?.description
    }
}
