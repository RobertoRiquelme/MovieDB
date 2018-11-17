//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Roberto Riquelme on 11/13/18.
//  Copyright © 2018 Roberto Riquelme. All rights reserved.
//

import UIKit
import TinyConstraints

class DetailViewController: UIViewController{

    var movie: Movie?

    var movieBackdrop = UIImageView()
    var movieTitle = UILabel()
    var moviePlot = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadMovie()
        setupView()
        setupLayout()
    }

    func setupView() {
        setupNavigation()
        setupImage()
        setupTitle()
        setupPlot()
    }

    func setupNavigation(){
        self.navigationController?.navigationBar.topItem?.title = "Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = false

        view.backgroundColor = UIColor.black
    }

    func setupImage(){
        movieBackdrop.contentMode = UIView.ContentMode.scaleAspectFill
    }

    func setupTitle(){
        let labelFont = UIFont(name: "HelveticaNeue-Bold", size: 18)
        let titleAttributes :Dictionary = [NSAttributedString.Key.font : labelFont, NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleAttrString = NSAttributedString(string: movieTitle.text!, attributes:titleAttributes as [NSAttributedString.Key : Any])
        movieTitle.attributedText = titleAttrString
        movieTitle.textAlignment = .left
    }

    func setupPlot(){
        moviePlot.textColor = UIColor.white
        moviePlot.textAlignment = .left
        moviePlot.lineBreakMode = .byWordWrapping
        moviePlot.numberOfLines = 0
        moviePlot.sizeToFit()
    }

    func setupLayout(){
        let stackView = UIStackView()
        view.addSubview(stackView)
        let views = [movieBackdrop, movieTitle, moviePlot]
        stackView.stack(views, axis: .vertical, spacing: 20)
        stackView.edgesToSuperview(excluding: .bottom, insets: .top(0.0) + .left(20) + .right(20), usingSafeArea: true)
    }

    fileprivate func loadMovie() {
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
