//
//  NewAndPopularTableViewCell.swift
//  MovieApp
//
//  Created by Altan on 7.09.2023.
//

import UIKit
import SDWebImage

class NewAndPopularTableViewCell: UITableViewCell {
    
    static let identifier = "NewAndPopularTableViewCell"
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        return image
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "paperplane", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(posterImageView)
        addSubview(title)
        addSubview(overViewLabel)
        addSubview(playButton)
        addSubview(addButton)
        addSubview(shareButton)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(posterUrl: String, title: String, overView: String) {
        self.title.text = title
        self.overViewLabel.text = overView
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterUrl)") else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
        
    }
    
    private func setConstraints() {
        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ]
        
        let titleConstraints = [
            title.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
        ]
        
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            playButton.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            playButton.heightAnchor.constraint(equalTo: title.heightAnchor)
        ]
        
        let addButtonConstrains = [
            addButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -15),
            addButton.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10)
        ]
        
        let shareButtonConstraints = [
            shareButton.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            shareButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -15)
        ]
        
        let overViewLabelConstaints = [
            overViewLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            overViewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            overViewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            overViewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ]
        
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(addButtonConstrains)
        NSLayoutConstraint.activate(shareButtonConstraints)
        NSLayoutConstraint.activate(overViewLabelConstaints)
    }
}
