//
//  DetailViewController.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 03/02/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var article: Article!
    
    let webview = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func loadView() {
        view = webview
        view.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.webview.load(self.article.url)
            self.view.hideLoading()
        }
    }
}
