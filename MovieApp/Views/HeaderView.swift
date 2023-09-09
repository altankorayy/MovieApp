//
//  HeaderView.swift
//  MovieApp
//
//  Created by Altan on 4.09.2023.
//

import UIKit
import SDWebImage

class HeaderView: UIView {
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let playButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Play"
        configuration.image = UIImage(systemName: "play.fill")
        configuration.baseBackgroundColor = .black
        configuration.imagePadding = 10
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        button.tintColor = .black
        button.clipsToBounds = true
        return button
    }()
    
    private let addToListButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "List"
        configuration.image = UIImage(systemName: "plus")
        configuration.baseBackgroundColor = .black
        configuration.imagePadding = 10
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerImageView)
        addSubview(playButton)
        addSubview(addToListButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let playButtonConstraints = [playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
                                     playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                                     playButton.widthAnchor.constraint(equalToConstant: 120),
                                     playButton.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let addToListButtonConstraints = [addToListButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
                                          addToListButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                                          addToListButton.widthAnchor.constraint(equalToConstant: 120),
                                          addToListButton.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(addToListButtonConstraints)
    }
    
    func configure(model: HeaderModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterUrl)") else { return }
        
        headerImageView.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
