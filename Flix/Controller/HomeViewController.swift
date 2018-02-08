//
//  ViewController.swift
//  Flix
//
//  Created by Mihai Ruber on 1/30/18.
//  Copyright © 2018 Mihai Ruber. All rights reserved.
//

import UIKit
import AlamofireImage
import SVProgressHUD

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var movies: [[String:Any]] = []
    let BASE_URL = "https://image.tmdb.org/t/p/w500"
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Activity Spinner
        SVProgressHUD.show()
        
        // Nav Bar Custom Settings
        //Navigation Shadow
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.navigationController?.navigationBar.layer.shadowRadius = 2.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Updating movies 😊")
        refresher.addTarget(self, action: #selector(HomeViewController.didPullToRefresh), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refresher, at: 0)
        
        // Do any additional setup after loading the view, typically from a nib.
      tableView.delegate = self
      tableView.dataSource = self
      fetchMovies()
      
    }
    
    @objc func didPullToRefresh() {
        fetchMovies()
    }
    
    func fetchMovies() {
        // Call the API
        // Do any additional setup after loading the view, typically from a nib.
        // Network request snippet
        // Get movies playing now
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                // Get the dictionary from the response key
                let movies = dataDictionary["results"] as! [[String:Any]]
                //Set global variable movies to movies
                self.movies = movies
                self.tableView.reloadData()
                self.refresher.endRefreshing()
                SVProgressHUD.dismiss()
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Movie", for: indexPath) as? MovieTableViewCell {
            let movie = movies[indexPath.row]
            let movieTitle = movie["title"] as! String
            let voteAvg = String(describing: movie["vote_average"] as! NSNumber)
            let releaseDate = movie["release_date"] as! String
            let movieImgURL = movie["poster_path"] as! String
            let description = movie["overview"] as! String
            print(voteAvg)
            // Setting up the view
            cell.movieTitleLabel.text = movieTitle
            cell.movieDescriptionTextView.text = description
            let posterURL = URL(string: "\(BASE_URL)\(movieImgURL)")
            if let posterURL = posterURL {
                cell.movieImage.af_setImage(withURL: posterURL)
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
        
    }

}

