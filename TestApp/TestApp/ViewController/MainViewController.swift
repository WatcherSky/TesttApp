//
//  MainViewController.swift
//  TestApp
//
//  Created by Владимир on 26.06.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    
    private let networkService = NetworkService()
    private var sections: [Section] = [.menu, .grid, .table]
    private var results = [Results]()
    private var itemsShows = 10
    
    //MARK: - ViewController life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNetworkService()
    }
    
    //MARK: - Methods
    private func setupTableView() {        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        
        tableView.registerCell(MenuTableViewCell.self)
        tableView.registerCell(GridTableViewCell.self)
        tableView.registerCell(ItemTableViewCell.self)
    }
    
    private func setupNetworkService() {
        networkService.setViewDelegate(networkDelegate: self)
        networkService.getTracks(limit: itemsShows)
    }
}

// MARK: - NetworkServiceProtocol
extension MainViewController: NetworkServiceDelegate {
    func fetchTracks(results: [Results]) {
        self.results = results
        self.tableView.reloadData()
    }
}

// MARK: - TableViewDelegate and DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .menu:
            return Constants.menuCount
        case .grid:
            return Constants.gridCount
        case .table:
            return results.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section {
        case .menu:
            return Constants.menuHeight
        case .grid:
            return Constants.gridHeight
        case .table:
            return Constants.tableHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .menu:
            let cell = tableView.dequeueCell(MenuTableViewCell.self, for: indexPath)
            return cell
        case .grid:
            let cell = tableView.dequeueCell(GridTableViewCell.self, for: indexPath)
            return cell
        case .table:
            let cell = tableView.dequeueCell(ItemTableViewCell.self, for: indexPath)
            cell.resultsFromApi = results[indexPath.row]
            cell.setupUI()
            cell.setupDateLabel()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        
        switch section {
        case .grid:
            return CGFloat(4)
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }
}

//COMMENTS
