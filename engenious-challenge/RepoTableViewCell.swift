//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

//MARK: - Config
fileprivate struct Config {
    static let gradientBackgroundGaps = UIEdgeInsets(top: 8.0, left: 20.5, bottom: -8.0, right: -20.5)
    static let titleLabelGaps = UIEdgeInsets(top: 24.0, left: 36.5, bottom: 8.0, right: -36.5)
    static let descriptionLabelGaps = UIEdgeInsets(top: 8.0, left: 36.5, bottom: -24.0, right: -36.5)
    
    static let gradientBackgroundColors = [
        UIColor(named: "gradientBackgroundLeft")?.cgColor ?? UIColor(red: 0.838, green: 0.933, blue: 1, alpha: 1).cgColor,
        UIColor(named: "gradientBackgroundRight")?.cgColor ?? UIColor(red: 0.717, green: 0.881, blue: 1, alpha: 0.76).cgColor
    ]
    static let gradientBackgroundLocations: [NSNumber] = [0, 1]
    static let gradientBackgroundStartPoint = CGPoint(x: 0.25, y: 0.5)
    static let gradientBackgroundEndPoint = CGPoint(x: 0.75, y: 0.5)
    
    static let shadowColor = UIColor(named: "gradientBackgroundShadow")?.cgColor ?? UIColor(red: 0, green: 0.417, blue: 0.716, alpha: 0.08).cgColor
    static let shadowOpacity: Float = 1
    static let shadowOffset = CGSize(width: 0, height: 6)
    static let shadowRadius: CGFloat = 6
    static let shadowCornerRadius: CGFloat = 10
    
    static let cornerRadius: CGFloat = 10
    
    static let titleLabelFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
    static let titleLabelColor = UIColor(named: "cellTitle") ?? UIColor(red: 0, green: 0.417, blue: 0.716, alpha: 1)
    
    static let descriptionLabelFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    static let descriptionLabelColor = UIColor(named: "cellDescription") ?? UIColor(red: 0, green: 0.283, blue: 0.487, alpha: 1)
}

// MARK: - Cell
final class RepoTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Config.titleLabelFont
        label.textColor = Config.titleLabelColor
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = Config.descriptionLabelFont
        label.textColor = Config.descriptionLabelColor
        return label
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Config.gradientBackgroundColors
        gradientLayer.locations = Config.gradientBackgroundLocations
        gradientLayer.startPoint = Config.gradientBackgroundStartPoint
        gradientLayer.endPoint = Config.gradientBackgroundEndPoint
        gradientLayer.cornerRadius = Config.cornerRadius
        return gradientLayer
    }()
    
    private lazy var shadowLayer: CALayer = {
        let shadowLayer = CALayer()
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadowLayer.shadowColor = Config.shadowColor
        shadowLayer.shadowOpacity = Config.shadowOpacity
        shadowLayer.shadowOffset = Config.shadowOffset
        shadowLayer.shadowRadius = Config.shadowRadius
        shadowLayer.cornerRadius = Config.shadowCornerRadius
        return shadowLayer
    }()
    
    private lazy var gradientBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.insertSublayer(shadowLayer, at: 0)
        view.layer.insertSublayer(gradientLayer, at: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(gradientBackgroundView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        updateGradientAndShadow()
    }
    
    private func updateGradientAndShadow() {
        gradientLayer.frame = gradientBackgroundView.bounds
        shadowLayer.frame = gradientBackgroundView.bounds
    }
    
    private func setConstraints() {
        let gradientBackgroundViewConstraints: [NSLayoutConstraint] = [
            gradientBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Config.gradientBackgroundGaps.left),
            gradientBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Config.gradientBackgroundGaps.top),
            gradientBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Config.gradientBackgroundGaps.right),
            gradientBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Config.gradientBackgroundGaps.bottom)
        ]
        
        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Config.titleLabelGaps.top),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Config.titleLabelGaps.left),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Config.titleLabelGaps.right)
        ]
        
        let descriptionLabelConstraints: [NSLayoutConstraint] = [
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Config.descriptionLabelGaps.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Config.descriptionLabelGaps.left),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Config.descriptionLabelGaps.right),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Config.descriptionLabelGaps.bottom)
        ]
        
        let constraints: [NSLayoutConstraint] = gradientBackgroundViewConstraints + titleLabelConstraints + descriptionLabelConstraints
        NSLayoutConstraint.activate(constraints)
    }
}
