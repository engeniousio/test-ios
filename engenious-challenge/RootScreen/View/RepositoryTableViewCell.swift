    //
    //  RepositoryTableViewCell.swift
    //  engenious-challenge
    //
    //  Created by Abdullah Atkaev on 20.05.2022.
    //

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    var item: RepositoryCellViewModel? {
        didSet {
            setupCell()
        }
    }
    
    let cellView: UIView = {
        let obj = UIView()
        obj.backgroundColor = UIColor(named: "lightBlue")
        obj.layer.cornerRadius = 10
        return obj
    }()
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.boldSystemFont(ofSize: 18)
        obj.textColor = UIColor(named: "blue")
        return obj
    }()
    
    let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.systemFont(ofSize: 14)
        obj.numberOfLines = 2
        obj.textColor = UIColor(named: "navy")
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(cellView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(descriptionLabel)
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.5).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.5).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    //MARK: helpers and handlers
extension RepositoryTableViewCell {
    private func setupCell() {
        addShadow()
        titleLabel.text = item?.name
        descriptionLabel.text = item?.description
    }
    
    private func addShadow() {
        cellView.layer.masksToBounds = false
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowOpacity = 0.06
        cellView.layer.shadowRadius = 7
        cellView.layer.shadowOffset.height = 7
        cellView.layer.shadowColor = UIColor.black.cgColor
    }
}
