//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Mihai Ruber on 2/7/18.
//  Copyright © 2018 Mihai Ruber. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Variables
    var movies: [Movie] = []
    let BASE_URL = "https://image.tmdb.org/t/p/w500"
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchMovies()
        
        // Do any additional setup after loading the view.
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numberOfColumns:CGFloat = 2
//        let width = collectionView.frame.size.width
//        let xInsets: CGFloat = 10
//        let cellSpacing: CGFloat = 5
//        
//        return CGSize(width: (width / numberOfColumns) - (xInsets + cellSpacing), height: 222)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath)
        
        if let posterCell = cell as? PosterCell {
            let movie: Movie = self.movies[indexPath.row]
            posterCell.posterImageView.af_setImage(withURL: movie.posterUrl!)
        }
        
        return cell
        
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as? PosterCell {
//            let movie: Movie = self.movies[indexPath.row]
//            cell.posterImageView.af_setImage(withURL: movie.posterUrl!)
//            return cell
//        } else {
//            return UICollectionViewCell()
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell) {
            let movie = movies[indexPath.item]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
            
        }
        
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
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                // Get the dictionary from the response key
                //Set global variable movies to movies
                self.movies = []
                for dictionary in movieDictionaries {
                    let movie = Movie(dictionary: dictionary)
                    self.movies.append(movie)
                }
                
                
                self.collectionView.reloadData()
//                self.refresher.endRefreshing()
//                SVProgressHUD.dismiss()
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

