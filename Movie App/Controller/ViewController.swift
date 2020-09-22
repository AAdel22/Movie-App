//
//  ViewController.swift
//  Movie App
//
//  Created by Alaa Adel on 9/21/20.
//  Copyright © 2020 Alaa Adel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    
    var isAnimated = false
    var ratedMovies: [RatedMovies] = [RatedMovies]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self

        
        Api.ratedMovies { (error: Error?, movies: [RatedMovies]?) in
            if let movies = movies {
                self.ratedMovies = movies
                self.tableview.reloadData()
            }
        }
        
    }


}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topRatedcell", for: indexPath) as! TopRatedCell
        cell.configure(with: ratedMovies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! TopRatedCell
        if !cell.isAnimated {
            // the init state of the cell
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
            cell.layer.transform = transform
            
            // animate the cell to the final state
            UIView.animate(withDuration: 1.0) {
                cell.alpha = 1.0
                cell.layer.transform = CATransform3DIdentity
            }
            cell.isAnimated = true
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMovieDetails" {
            let movieDetailsVC = segue.destination as! MoviesDetailsViewController
            if let movieIndex = tableview.indexPathForSelectedRow {
                if let movieID = ratedMovies[movieIndex.row].id {
                    movieDetailsVC.movieID = movieID
                }
            }
        }
    }
}
