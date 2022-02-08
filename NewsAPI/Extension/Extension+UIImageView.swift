//
//  Extension+UIImageView.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 03/02/22.
//

import UIKit.UIImageView

extension UIImageView {
    func load(from urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
}
