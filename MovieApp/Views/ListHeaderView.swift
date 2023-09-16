//
//  ListHeaderView.swift
//  MovieApp
//
//  Created by Altan on 15.09.2023.
//

import UIKit

class ListHeaderView: UIView {
    
    private let listImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "list")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()

    private let listLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "List"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(listImage)
        addSubview(listLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        let listImageConstraints = [
            listImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            listImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            listImage.heightAnchor.constraint(equalToConstant: 40),
            listImage.widthAnchor.constraint(equalToConstant: 40)
        ]
        
        let listLabelConstraints = [
            listLabel.centerYAnchor.constraint(equalTo: listImage.centerYAnchor),
            listLabel.leadingAnchor.constraint(equalTo: listImage.trailingAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(listImageConstraints)
        NSLayoutConstraint.activate(listLabelConstraints)
    }

}
