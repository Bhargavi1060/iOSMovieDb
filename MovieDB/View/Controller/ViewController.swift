//
//  ViewController.swift
//  MovieDB
//
//  Created by Bhargavi on 27/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    enum TableSection: Int {
          case userList
          case loader
      }

    // MARK: - Outlet
    @IBOutlet weak var tblv: UITableView!
    
    
    // MARK: - Injection
    let viewModel = MovieViewModel(dataService: DataService())
    var movieList:Results?
    private let pageLimit = 20
    private var currentLastId: Int? = 1
   
    private var users = [Results]() {
          didSet {
              DispatchQueue.main.async { [weak self] in
                  self?.tblv.reloadData()
              }
          }
      }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        fetchData(withId: 1)
        
    }
    

    private func setupView() {
        tblv.rowHeight = 150
        tblv.dataSource = self
        tblv.delegate = self
        tblv.separatorStyle = .none
      
           
       }

    // MARK: - Networking
    private func fetchData(withId id: Int, completed: ((Bool) -> Void)? = nil ) {
        viewModel.fetchmovie(withId: id)
        
        viewModel.updateLoadingStatus = {

        }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                print(error.localizedDescription)
                completed?(false)
            }
        }
        
        viewModel.didFinishFetch = {
            if let results = self.viewModel.moviewList {
            if let result = results.results {
            self.users.append(contentsOf: result)
            // assign last id for next fetch
            self.currentLastId = (results.page ?? 0) + 1
            }
            }
            completed?(true)
            
        }
    }
    func navigateToMovieDetailVC(movie:Results){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailVC
        vc?.viewModel.movie = movie
        self.navigationController?.pushViewController(vc!, animated: true)
    
    }
    
}

// MARK: - Tableview DataSource and Delegate - 
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let listSection = TableSection(rawValue: section) else { return 0 }
          switch listSection {
          case .userList:
              return users.count
          case .loader:
              return users.count >= pageLimit ? 1 : 0
          }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovileListCell", for: indexPath) as! MovileListCell
        
        switch section {
            case .userList:
            let result = users[indexPath.row]
            cell.setupView(movie: result)
            case .loader:
            cell.textLabel?.textColor = .systemBlue
            }
             
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        guard !users.isEmpty else { return }

        if section == .loader {
            print("load new data..")
            fetchData(withId: currentLastId!) { [weak self] success in
                if !success {
                    self?.hideBottomLoader()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        navigateToMovieDetailVC(movie:users[indexPath.row])
    }
    
    private func hideBottomLoader() {
         DispatchQueue.main.async {
             let lastListIndexPath = IndexPath(row: self.users.count - 1, section: TableSection.userList.rawValue)
             self.tblv.scrollToRow(at: lastListIndexPath, at: .bottom, animated: true)
         }
     }
}

