//
//  CategoryCell.swift
//  Quizz
//
//  Created by Мирас Асубай on 12.04.2023.
//

import UIKit


class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func set(category: Category) {
        categoryImageView.image = category.image
        categoryTitleLabel.text = category.name
    }
    
    func setConstraints() {
        
        addSubview(categoryImageView)
        addSubview(categoryTitleLabel)
        
        NSLayoutConstraint.activate([
            categoryImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            categoryTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryTitleLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
