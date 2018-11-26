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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupSearch()
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
                    //self.movieCollectionView.reloadData()
                }
            } else {
                print("error occured while fetching movies")
            }
        }
    }
}
