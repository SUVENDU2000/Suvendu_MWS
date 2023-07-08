//
//  MyTableViewCell.swift
//  MaybeLLine
//
//  Created by Suvendu Kumar on 08/07/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var FirstLabel: UILabel!
    
    @IBOutlet weak var SecondLabel: UILabel!
    
    @IBOutlet weak var ThirdLabel: UILabel!
    
    @IBOutlet weak var ForthLabel: UILabel!
    
    @IBOutlet weak var FifthLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
struct MakeupProduct: Codable {
    let description: String
    let id: Int
    let brand: String
    let name: String
    let price: String
    let image_link: String
    let rating: Double?
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
