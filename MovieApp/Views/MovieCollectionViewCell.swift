//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Altan on 5.09.2023.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
    }
    
    func configure(posterUrl: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterUrl)") else { return }
        
        imageView.sd_setImage(with: url, completed: nil)
    }
}
