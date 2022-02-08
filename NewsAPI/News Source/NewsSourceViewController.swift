//
//  NewsSourceViewController.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import UIKit

protocol NewsSourceViewProtocol: AnyObject {
    func reloadSource()
    func displayError(error: String)
    func loadingIndicator()
}

class NewsSourceViewController: UIViewController {
    
    var tableView: UITableView!
    
    var presenter: NewsSourcePresenterInput!
    let searchController = UISearchController()
    
    var item: CatagoryItem!
    lazy var footerView = FooterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }

}

extension NewsSourceViewController: NewsSourceViewProtocol {
    func reloadSource() {
        view.hideLoading()
        tableView.reloadData()
    }
    
    func displayError(error: String) {
        presentAlert(withTitle: "Error", message: error)
    }
    
    func loadingIndicator() {
        view.showLoading()
    }
}

private extension NewsSourceViewController {
    func initialize() {
        title = "Sources"
        setupTableView()
        setupSearchController()
        if let name = item.name {
            presenter.showLoading()
            presenter.fetch(source: name, page: page)
        }
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = footerView
        tableView.registerCell(type: SourceCell.self, identifier: SourceCell.identifier)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater   = self
        searchController.searchBar.delegate     = self
        searchController.searchBar.placeholder  = "Search source"
        navigationItem.searchController         = searchController
    }
}

extension NewsSourceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? presenter.filterCount() : presenter.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: SourceCell.self, for: indexPath) as! SourceCell
        
        let source = searchController.isActive ? presenter.filterCellForRowAt(at: indexPath) : presenter.cellForRowAt(at: indexPath)
        cell.set(source: source)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.pushToArticle(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let contentY            = scrollView.contentOffset.y
        let height              = scrollView.contentSize.height
        let scrollViewHeight    = scrollView.frame.size.height
        
        if contentY > height - scrollViewHeight {
            footerView.startAnimating()
            guard presenter.hasMoreSource() else { return }
            page += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.footerView.stopAnimating()
                self.presenter.fetch(source: self.item.name ?? "", page: self.page)
                self.tableView.reloadData()
            }
        }
    }
}

extension NewsSourceViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.searchSource(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.showLoading()
        presenter.sourceFilterRemoveAll()
        presenter.fetch(source: item.name ?? "", page: page)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let isEmpty = searchController.searchBar.text?.isEmpty else { return }
        if isEmpty {
            presenter.sourceFilterRemoveAll()
            presenter.fetch(source: item.name ?? "", page: page)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter.allSources()
    }
}
