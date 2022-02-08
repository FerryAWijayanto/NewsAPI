//
//  ArticleCell.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(article: Article) {
        articleImageView.load(from: article.urlToImage ?? "")
        titleLbl.text = article.title
        contentLbl.text = article.description?.replacingOccurrences(of: "\"", with: "") ?? ""
        sourceLbl.text = article.source.name
    }
}
