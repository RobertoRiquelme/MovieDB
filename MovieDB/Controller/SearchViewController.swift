//
//  SearchViewController.swift
//  MovieDB
//
//  Created by Roberto Riquelme on 11/16/18.
//  Copyright © 2018 Roberto Riquelme. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating{

    var searchController: UISearchController!
    var movies: [Movie] = [Movie]()

    var movieCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupSearch()
        setupLayout()
    }

    func setupView() {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    func setupSearch(){
        self.definesPresentationContext = true
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies..."
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barStyle = .blackTranslucent

        self.navigationItem.hidesSearchBarWhenScrolling = false;
        self.navigationItem.searchController = searchController
        searchController.isActive = true
    }

    func setupLayout() {
        let space:CGFloat = 0.0
        let numberOfColumns:CGFloat = 2.0
        let itemWidth = (view.frame.size.width - (numberOfColumns - 1)) / numberOfColumns

        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)

        movieCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        movieCollectionView.backgroundColor = UIColor.black
        self.view.addSubview(movieCollectionView)
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        debugPrint("Searching...\(searchString)")
        switch searchString{
        case "":
            break
        default:
            searchMovies(with: searchString)
        }
    }

    func searchMovies (with query: String) {
        Client.sharedInstance().searchMovies(with:query) { (movies) in
            if let movies = movies {
                self.movies = movies
                DispatchQueue.main.async {
                    self.movieCollectionView.reloadData()
                }
            } else {
                print("error occured while fetching movies")
            }
        }
    }
}

extension SearchViewController:  UICollectionViewDataSource, UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellReuseIdentifier = "collectionCell"
        let movie = movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:cell.frame.size.width, height:cell.frame.size.height))
        if let posterPath = movie.posterPath {
            Client.sharedInstance().fetchImage(path: posterPath, size: Client.PosterConstants.RowPoster, completion: { (imageData) in
                if let image = imageData {
                    DispatchQueue.main.async {
                        imageView.image = image
                        imageView.contentMode = UIView.ContentMode.scaleAspectFit
                        cell.addSubview(imageView)
                    }
                } else {
                    print("error")
                }
            })
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cellMovie = movies[indexPath.row]
        let controller = DetailViewController()
        controller.movie = cellMovie
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numberOfSections = 0
        if movies.count > 0 {
            numberOfSections = 1
            collectionView.backgroundView = nil
        } else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
            noDataLabel.text = ""
            noDataLabel.numberOfLines = 0
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = .center
            collectionView.backgroundView = noDataLabel
        }
        return numberOfSections
    }
}
