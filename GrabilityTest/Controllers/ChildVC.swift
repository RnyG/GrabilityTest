//
//  ChildVC.swift
//  GrabilityTest
//
//  Created by Rhonny Gonzalez on 10/5/18.
//  Copyright © 2018 Rhonny Gonzalez. All rights reserved.
//

import UIKit
import SDWebImage

class ChildVC: UIViewController {
    
    @IBOutlet weak var childCV: UICollectionView!
    
    var navIndex = 0
    var tabIndex = 0
    var moviesClass = MoviesClass()
    var movies: [Movie] = []
    var series: [Serie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        childCV.delegate = self
        childCV.dataSource = self
        moviesClass.moviesDelegates = self
        let type = types(rawValue: tabIndex) ?? types(rawValue: 0)!
        let url = endpoints(navIndex, type: type)?.url ?? endpoints(0, type: type)!.url
        moviesClass.getMovies(url: url + "&page=1", screen: "PopularMovies")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ChildVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postersCell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342" + movies[indexPath.row].poster_path), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
}

extension ChildVC: moviesDelegates{
    func successMoviesConnection(array: NSArray, request: String) {
        self.movies = []
        self.series = []
        for data in array{
            if ((data as? NSDictionary) != nil){
                if tabIndex == 0{
                self.movies.append(Movie(data: data as! NSDictionary)!)
                }else{
                self.series.append(Serie(data: data as! NSDictionary)!)
                }
            }
        }
        DispatchQueue.main.async {
            self.childCV.reloadData()
        }
    }
    func badMoviesConnection(message: String) {
        
    }
}
