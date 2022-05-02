//
//  MovieDetailVC.swift
//  MovieDB
//
//  Created by Bhargavi on 27/04/22.
//

import UIKit

class MovieDetailVC: UIViewController {

    
    // MARK: - Outlet
    @IBOutlet weak var tblv: UITableView!
    
    // MARK: - Injection
    let viewModel = MovieDetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblv.separatorStyle = .none
       
    }
    
}

// MARK: - Tableview DataSource and Delegate - 
extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.movie != nil) ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as! MovieDetailCell
        cell.setupView(movie: viewModel.movie!)
        return cell
    }
    
}
