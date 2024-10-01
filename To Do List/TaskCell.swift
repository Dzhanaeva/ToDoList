//
//  TaskCell.swift
//  To Do List
//
//  Created by Гидаят Джанаева on 10.09.2024.
//

import UIKit

class TaskCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
 
    lazy var detailsLabel: UILabel = {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(nameLabel, detailsLabel)
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            detailsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        
            
        ])
    }
}
