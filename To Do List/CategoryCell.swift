//
//  TaskCell.swift
//  To Do List
//
//  Created by Гидаят Джанаева on 02.09.2024.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    
    let iconImage = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubviews(iconImage, titleLabel, subtitleLabel)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        iconImage.contentMode = .scaleAspectFit
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textColor = .gray
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = false
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOpacity = 0.30
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
       

    }
    
    func configure(title: String, subtitle: String, icon: UIImage?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        iconImage.image = icon
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 60),
            iconImage.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
        
        
        ])

        
        
    }

}

