//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Roberto Riquelme on 11/13/18.
//  Copyright © 2018 Roberto Riquelme. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var movie: Movie?

    @IBOutlet weak var movieBackdrop: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        self.navigationController?.navigationBar.topItem?.title = "Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewWillAppear(_ animated: Bool) {
        if let movie = movie {
            movieTitle.text = movie.title
            if let overview = movie.overview {
                moviePlot.text = overview
            }
            if let backdropPath = movie.backdropPath {
                Client.sharedInstance().fetchImage(path: backdropPath, size: Client.PosterConstants.BackdropImage, completion: { (imageData) in
                    if let image = imageData {
                        DispatchQueue.main.async {
                            self.movieBackdrop.image = image
                        }
                    } else {
                        print("error")
                    }
                })
            }

        }
    }
    }
