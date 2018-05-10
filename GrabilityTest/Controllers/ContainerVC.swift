//
//  ContainerVC.swift
//  GrabilityTest
//
//  Created by Rhonny Gonzalez on 10/5/18.
//  Copyright © 2018 Rhonny Gonzalez. All rights reserved.
//

import UIKit
import Parchment

class ContainerVC: UIViewController {
    
    var moviesClass = MoviesClass()
    var movies: [Movie] = []
    let titles = [
        "Popular",
        "Top Rated",
        "Upcomming",
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureParchment()
    }
    
    func configureParchment(){
        var viewControllers: [UIViewController] = []
        for i in 0 ..< titles.count{
            let vc = storyboard!.instantiateViewController(withIdentifier: "ChildVC") as! ChildVC
            vc.title = titles[i]
            vc.navIndex = i
            vc.tabIndex = self.tabBarController?.selectedIndex ?? 0
            viewControllers.append(vc)
        }
        let pagingViewController = FixedPagingViewController(viewControllers:viewControllers)
        pagingViewController.menuItemSize = .fixed(width: self.view.frame.size.width / 3, height: 30)
        pagingViewController.textColor = .lightGray
        pagingViewController.indicatorColor = #colorLiteral(red: 0, green: 0.841566205, blue: 0.5404788852, alpha: 1)
        pagingViewController.backgroundColor = #colorLiteral(red: 0.02011371963, green: 0.1463510096, blue: 0.188203007, alpha: 1)
        pagingViewController.selectedTextColor = .white
        pagingViewController.menuBackgroundColor = #colorLiteral(red: 0.02011371963, green: 0.1463510096, blue: 0.188203007, alpha: 1)
        pagingViewController.borderColor = #colorLiteral(red: 0.02011371963, green: 0.1463510096, blue: 0.188203007, alpha: 1)
        pagingViewController.selectedBackgroundColor = #colorLiteral(red: 0.02011371963, green: 0.1463510096, blue: 0.188203007, alpha: 1)
        
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParentViewController: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
            ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
