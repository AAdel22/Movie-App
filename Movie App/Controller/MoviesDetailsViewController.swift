//
//  MoviesDetailsViewController.swift
//  Movie App
//
//  Created by Alaa Adel on 9/21/20.
//  Copyright © 2020 Alaa Adel. All rights reserved.
//

import UIKit
import Kingfisher
class MoviesDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    var detailsMovies: DetailsMovies = DetailsMovies()
    var movieID: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        Api.movieDetails(movieID: movieID!) { (error: Error?, movies: DetailsMovies?) in
            if let movies = movies {
                self.detailsMovies = movies
                print("\(self.detailsMovies.title!)")
                self.titleLabel.text = "\(self.detailsMovies.title!)"
                self.descriptionLabel.text = "\(self.detailsMovies.overview!)"
                self.poster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w185" + self.detailsMovies.backdrop_path!))
                self.releaseDateLabel.text = "\(self.detailsMovies.release_date!)"
                self.voteAverageLabel.text = "\(self.detailsMovies.vote_average!)"
            }
        }
    }
    
}
