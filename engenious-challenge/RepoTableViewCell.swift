//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    private enum Consts {
        static let outerMargin = 16
        static let textMargin = 8
        static let bgColor = CGColor(red: 0.838, green: 0.933, blue: 1, alpha: 1)
        static let titleColor = CGColor(red: 0, green: 0.417, blue: 0.716, alpha: 1)
        static let textColor = CGColor(red: 0, green: 0.283, blue: 0.487, alpha: 1)
        static let titleFont = UIFont(name: "SFProText-Bold", size: 18)
        static let textFont = UIFont(name: "SFProText-Medium", size: 14)
    }

    var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    var text: String? {
        get {
            textLabel.text
        }
        set {
            textLabel.text = newValue
        }
    }

    private let titleLabel: UILabel = .init()
    private let textLabel: UILabel = .init()

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupViews()
    }

    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Consts.outerMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Consts.outerMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Consts.outerMargin).isActive = true

        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Consts.textMargin).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Consts.outerMargin).isActive = true
    }

    private func setupViews() {
        contentView.layer.backgroundColor = Consts.bgColor
        contentView.cornerRadius = 10

        titleLabel.textColor = Consts.titleColor
        titleLabel.font = Consts.

        textLabel.textColor = Consts.textColor
        textLabel.font = Consts.textFont
        textLabel.numberOfLines = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
