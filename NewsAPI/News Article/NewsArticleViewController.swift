//
//  NewsArticleViewController.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import UIKit

protocol NewsArticleViewProtocol: AnyObject {
    func reloadArticle()
    func showError(_ error: String)
    func loadingIndicator()
}

class NewsArticleViewController: UIViewController {
    
    var tableView: UITableView!
    
    var presenter: NewsArticlePresenterInput!
    
    lazy var footerView = FooterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
    let searchController = UISearchController()
    
    var source: Source!
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }

}

extension NewsArticleViewController: NewsArticleViewProtocol {
    func reloadArticle() {
        view.hideLoading()
        tableView.reloadData()
    }
    
    func showError(_ error: String) {
        presentAlert(withTitle: "Error", message: error)
    }
    
    func loadingIndicator() {
        view.showLoading()
    }
}

private extension NewsArticleViewController {
    func initialize() {
        title = "Articles"
        setupTableView()
        setupSearchController()
        presenter.showLoading()
        presenter.fetchArticle(with: source.id, page: page)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = footerView
        tableView.registerCell(type: ArticleCell.self, identifier: ArticleCell.identifier)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater   = self
        searchController.searchBar.delegate     = self
        searchController.searchBar.placeholder  = "Search source"
        navigationItem.searchController         = searchController
    }
}

extension NewsArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? presenter.filterCount() : presenter.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: ArticleCell.self, for: indexPath) as! ArticleCell
        
        let article = searchController.isActive ? presenter.filterCellForRowAt(at: indexPath) : presenter.cellForRow(at: indexPath)
        cell.set(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let contentY            = scrollView.contentOffset.y
        let height              = scrollView.contentSize.height
        let scrollViewHeight    = scrollView.frame.size.height
        
        if contentY > height - scrollViewHeight {
            footerView.startAnimating()
            guard presenter.hasMoreArticle() else { return }
            page += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.footerView.stopAnimating()
                self.presenter.fetchArticle(with: self.source.id, page: self.page)
                self.tableView.reloadData()
            }
        }
    }
}

extension NewsArticleViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.searchArticle(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.showLoading()
        presenter.articleFilterRemoveAll()
        presenter.fetchArticle(with: source.id, page: page)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let isEmpty = searchController.searchBar.text?.isEmpty else { return }
        if isEmpty {
            presenter.articleFilterRemoveAll()
            presenter.fetchArticle(with: source.id, page: page)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter.allArticles()
    }
}
