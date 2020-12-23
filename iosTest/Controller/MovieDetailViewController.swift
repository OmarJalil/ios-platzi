//
//  MovieDetailViewController.swift
//  iosTest
//
//  Created by Omar on 21/12/20.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var genresCollectionView: UICollectionView?
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let lenghtLabel: UILabel = {
        let lenghtLabel = UILabel()
        lenghtLabel.textColor = .label
        lenghtLabel.translatesAutoresizingMaskIntoConstraints = false
        return lenghtLabel
    }()
    
    private let releaseDateLabel: UILabel = {
        let releaseDateLabel = UILabel()
        releaseDateLabel.textColor = .label
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return releaseDateLabel
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.textColor = .label
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .label
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    // I used a UITextView to let the users with small screens scroll through
    private let descriptionLabel: UITextView = {
        let descriptionLabel = UITextView()
        descriptionLabel.textColor = .label
        descriptionLabel.contentMode = .topLeft
        descriptionLabel.textAlignment = .justified
        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.isEditable = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.sizeToFit()
        return descriptionLabel
    }()
    
    public var movie: Movie?
    public var viewModel: MoviesViewModel?
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        addViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewModel?.fetchMovie(id: movie?.id ?? 0)
        
        viewModel?.didFinishFetch = {
            if let url = URL(string: "https://image.tmdb.org/t/p/original\(self.viewModel?.movieDetails?.backdropPath ?? "")") {
                self.posterImageView.kf.setImage(with: url)
            }
            
            self.lenghtLabel.text = "Lenght: \(self.viewModel?.movieDetails?.runtime ?? 120) min"
            self.releaseDateLabel.text = "Relase date: \(self.viewModel?.movieDetails?.releaseDate ?? "na")"
            self.ratingLabel.text = "⭐ \(self.viewModel?.movieDetails?.voteAverage.description ?? "na")"
            
            self.titleLabel.text = self.viewModel?.movieDetails?.originalTitle
            
            if self.viewModel?.movieDetails?.overview?.isEmpty == true {
                self.descriptionLabel.text = "Esta película no cuenta con descripción."
            } else {
                self.descriptionLabel.text = self.viewModel?.movieDetails?.overview
            }
                        
            self.genresCollectionView?.reloadData()
        }
    }
    
    // MARK: Constraints
    func addViews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        layout.itemSize = CGSize(width: 100, height: 30)
        layout.scrollDirection = .horizontal
        
        genresCollectionView = UICollectionView(frame: CGRect(x: 16, y: 256, width: self.view.frame.width, height: 50), collectionViewLayout: layout)
        genresCollectionView?.dataSource = self
        genresCollectionView?.register(MovieGenreCollectionViewCell.self, forCellWithReuseIdentifier: "MovieGenreCollectionViewCell")
        genresCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        genresCollectionView?.backgroundColor = .systemBackground
        genresCollectionView?.showsHorizontalScrollIndicator = false
        
        view.backgroundColor = .systemBackground
        view.addSubview(genresCollectionView!)
        view.addSubview(posterImageView)
        view.addSubview(lenghtLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(ratingLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        posterImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        posterImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 4).isActive = true
        
        genresCollectionView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        genresCollectionView?.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8).isActive = true
        genresCollectionView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        genresCollectionView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: genresCollectionView!.bottomAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        lenghtLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        lenghtLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        lenghtLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        lenghtLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        releaseDateLabel.topAnchor.constraint(equalTo: lenghtLabel.bottomAnchor, constant: 8).isActive = true
        releaseDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        releaseDateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8).isActive = true
        ratingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        ratingLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        descriptionLabel.sizeToFit()
    }
}

// MARK: CollectionView
extension MovieDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movieDetails?.genres.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGenreCollectionViewCell", for: indexPath) as? MovieGenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.genre = viewModel?.movieDetails?.genres[indexPath.row].name
        
        return cell
    }
    
}
