//
//  CustomCollectionViewCell.swift
//  MovieDB
//
//  Created by Roberto Riquelme on 11/12/18.
//  Copyright © 2018 Roberto Riquelme. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
   // @IBOutlet weak var poster: UIImageView!
    public var poster: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        poster = UIImageView()
    }

    func addImage(){
        addSubview(poster)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
