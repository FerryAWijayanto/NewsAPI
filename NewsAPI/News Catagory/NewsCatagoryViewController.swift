//
//  NewsCatagoryViewController.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import UIKit

protocol NewsCatagoryViewProtocol: AnyObject {
    func showCategory()
}

class NewsCatagoryViewController: UIViewController {
    
    var tableView: UITableView!
    
    var presenter: NewsCatagoryPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }

}

extension NewsCatagoryViewController: NewsCatagoryViewProtocol {
    func showCategory() {
        tableView.reloadData()
    }
    
}

private extension NewsCatagoryViewController {
    func initialize() {
        title = "News API"
        setupTableView()
        presenter.fetchCategory()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.registerCell(type: CatagoryCell.self, identifier: CatagoryCell.identifier)
    }
}

extension NewsCatagoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: CatagoryCell.self, for: indexPath) as! CatagoryCell
        
        let category = presenter.category(at: indexPath)
        
        cell.set(category: category)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.pushToSource(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
