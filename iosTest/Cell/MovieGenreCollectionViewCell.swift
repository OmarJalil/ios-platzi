//
//  MovieGenreCollectionViewCell.swift
//  iosTest
//
//  Created by Omar on 21/12/20.
//

import UIKit

class MovieGenreCollectionViewCell: UICollectionViewCell {
    
    public var genre: String? {
        didSet {
            genreLabel.text = genre
        }
    }
    
    private let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.textColor = .white
        genreLabel.textAlignment = .center
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        return genreLabel
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func addViews() {
        contentView.addSubview(genreLabel)
        
        genreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        genreLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        genreLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        
        contentView.backgroundColor = #colorLiteral(red: 0.8428743482, green: 0.6950973868, blue: 0.3475212455, alpha: 1)
        contentView.layer.cornerRadius = 9
    }
}
