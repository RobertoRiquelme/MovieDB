//
//  NowPlayingCollectionViewController.swift
//  MovieDB
//
//  Created by Roberto Riquelme on 11/12/18.
//  Copyright © 2018 Roberto Riquelme. All rights reserved.
//

import UIKit

class NowPlayingCollectionViewController: UICollectionViewController {

    @IBOutlet var movieCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var movies: [Movie] = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupLayout()
        fetchMovies()
    }

    func setupView() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.topItem?.title = "Movies"
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupLayout() {
        let space:CGFloat = 0.0
        let numberOfColumns:CGFloat = 2.0
        let itemWidth = (view.frame.size.width - (numberOfColumns - 1)) / numberOfColumns
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
    }

    func fetchMovies () {
        Client.sharedInstance().fetchMovies { (movies) in
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

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellReuseIdentifier = "collectionCell"
        let movie = movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CustomCollectionViewCell

        cell.poster!.contentMode = UIView.ContentMode.scaleAspectFit

        if let posterPath = movie.posterPath {
            Client.sharedInstance().fetchImage(path: posterPath, size: Client.PosterConstants.RowPoster, completion: { (imageData) in
                if let image = imageData {
                    DispatchQueue.main.async {
                        cell.poster!.image = image
                    }
                } else {
                    print("error")
                }
            })
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller: DetailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.movie = movies[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numberOfSections = 0
        if movies.count > 0 {
            numberOfSections = 1
            collectionView.backgroundView = nil
        } else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
            noDataLabel.text = "No Data Available, Please Check Your Connection Then Refresh."
            noDataLabel.numberOfLines = 0
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = .center
            collectionView.backgroundView = noDataLabel
        }
        return numberOfSections
    }
}

