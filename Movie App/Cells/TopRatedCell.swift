//
//  TopRatedCell.swift
//  Movie App
//
//  Created by Alaa Adel on 9/21/20.
//  Copyright © 2020 Alaa Adel. All rights reserved.
//

import UIKit
import Kingfisher
class TopRatedCell: UITableViewCell {

    @IBOutlet weak var movieBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var poster: UIImageView!
    var isAnimated = false
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
    }
    func cellDesign() {
        
        self.movieBackgroundView.layer.cornerRadius = 25
        self.movieBackgroundView.layer.borderWidth = 3
        self.movieBackgroundView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.movieBackgroundView.clipsToBounds = true
    }

    func configure(with data: RatedMovies){
        self.titleLabel.text = data.title
        self.overviewLabel.text = data.overview
        self.poster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w185"+data.poster_path!))
    }

}
