//
//  MoviesViewController.swift
//  iosTest
//
//  Created by Omar on 21/12/20.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var collectionView: UICollectionView?
    let spinner = UIActivityIndicatorView(style: .medium)
    
    private let viewModel = MoviesViewModel()
    private let margin: CGFloat = 10
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 16, height: view.frame.height / 3)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        view.addSubview(collectionView ?? UICollectionView())
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.refreshControl = refreshControl
        
        getMovies()
    }
    
    private func getMovies() {
        viewModel.fetchMovies()
        
        viewModel.updateLoadingStatus = {
            self.refreshControl.endRefreshing()
        }
        
        viewModel.didFinishFetch = {
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: Refresh control
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action:
                                    #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.movies.removeAll()
        viewModel.page = 1
        getMovies()
        self.refreshControl.beginRefreshing()
    }
}

// MARK: CollectionView
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.movie = viewModel.movies[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = MovieDetailViewController()
        detailView.modalPresentationStyle = .fullScreen
        detailView.movie = viewModel.movies[indexPath.row]
        detailView.viewModel = viewModel
        
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // forces 2 rows in collectionview
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: Int(view.frame.height) / 3)
    }
    
    // Infinite scroll
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if viewModel.movies.isEmpty { return }
        
        if collectionView.isLast(for: indexPath) {
            if viewModel.page < viewModel.totalPages {
                if viewModel.isFetchingResults {
                    return
                }
                
                viewModel.page += 1
                getMovies()
            }
        }
    }
}
