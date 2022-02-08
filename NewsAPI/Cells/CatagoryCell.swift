//
//  CatagoryCell.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import UIKit

class CatagoryCell: UITableViewCell {

    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(category: CatagoryItem) {
        categoryLbl.text = category.name?.capitalized
        if let imageName = category.image, let color = category.color {
            categoryImageView.image = UIImage(named: imageName)
            containerView.backgroundColor = UIColor(hexString: "#\(color)")
        }
    }
    
}
