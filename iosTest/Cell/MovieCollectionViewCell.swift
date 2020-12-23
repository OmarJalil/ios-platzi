//
//  MovieCollectionViewCell.swift
//  iosTest
//
//  Created by Omar on 21/12/20.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    public var movie: Movie? {
        didSet {
            if let url = URL(string: "https://image.tmdb.org/t/p/original\(movie?.posterPath ?? "")") {
                posterImageView.kf.setImage(with: url)
                grayView.layer.cornerRadius = 9
                // bottom corners 
                grayView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }
            titleLabel.text  = movie?.originalTitle
            dateLabel.text   = movie?.releaseDate
            ratingLabel.text = movie?.voteAverage.description
        }
    }
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 9
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .white
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.textColor = .white
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
    }()
    
    let grayView: UIView = {
        let grayView = UIView()
        grayView.backgroundColor = UIColor(red: 0.7327767015, green: 0.7284224629, blue: 0.7361249328, alpha: 0.7961240857)
        grayView.translatesAutoresizingMaskIntoConstraints = false
        return grayView
    }()
    
    let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Constraints
    public func addViews() {
        addSubview(posterImageView)
        addSubview(grayView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(ratingLabel)
        addSubview(starImageView)
        
        // 0 to all sides
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        
        // All the way to the bottom, with 80 heigh
        grayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        grayView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        grayView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        grayView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        //8 left, 8 top to titleLabel
        dateLabel.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -8).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: grayView.leftAnchor, constant: 8).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: grayView.rightAnchor, constant: 0).isActive = true
        
        // 8 to both sides, 2 top, 8 bottom to dateLabel
        titleLabel.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 2).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: grayView.leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: grayView.rightAnchor, constant: -8).isActive = true
        
        // right corner 8
        ratingLabel.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -8).isActive = true
        ratingLabel.leftAnchor.constraint(equalTo: starImageView.rightAnchor, constant: 4).isActive = true
        ratingLabel.rightAnchor.constraint(equalTo: grayView.rightAnchor, constant: -8).isActive = true
        
        // 20x20 star centered with ratingLabel
        starImageView.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
