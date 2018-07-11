//
//  ViewController.swift
//  favourite-movies-app
//
//  Created by Will Andrews on 11/07/2018.
//  Copyright © 2018 Will Andrews. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moviecell = tableView.dequeueReusableCell(withIdentifier: "customcell",
                                                      for: indexPath) as! CustomTableViewCell
        
        let idx: Int = indexPath.row
        
        moviecell.movieTitle?.text = favouriteMovies[idx].title
        moviecell.movieYear?.text = favouriteMovies[idx].year
        displayMovieImage(idx, moviecell: moviecell)
        
        return moviecell
    }
    
    func displayMovieImage(_ row: Int, moviecell: CustomTableViewCell) {
        let url: String = (URL(string: favouriteMovies[row].imageUrl)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler:{ (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                moviecell.movieImageView?.image = image
            })
        }).resume()
    }
    
    var favouriteMovies: [Movie]  = []
    
    @IBOutlet var mainTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchMoviesSegue" {
            let controller = segue.destination as! SearchViewController
            
            controller.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainTableView.reloadData()
        if favouriteMovies.count == 0 {
            favouriteMovies.append(Movie(id: "tt0372784", title: "Batman Begins", year: "2005", imageUrl: "https://upload.wikimedia.org/wikipedia/en/a/af/Batman_Begins_Poster.jpg"))
        }
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

