    //
    //  RepositoryView.swift
    //  engenious-challenge
    //
    //  Created by Anastasia Kholod on 07.06.2022.
    //

import UIKit

class RepositoryView: UIView {
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.boldSystemFont(ofSize: 24)
        obj.tintColor = UIColor(named: "navy")
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView(frame: .zero, style: .grouped)
        obj.backgroundColor = .white
        obj.estimatedRowHeight = 200.0
        obj.rowHeight = UITableView.automaticDimension
        obj.separatorStyle = .none
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
        // MARK: - Functions
    private func setup() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(tableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 61).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.5).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

