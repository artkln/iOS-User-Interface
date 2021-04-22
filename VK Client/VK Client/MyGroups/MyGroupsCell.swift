//
//  MyGroupsCell.swift
//  VK Client
//
//  Created by Артём Калинин on 10.03.2021.
//

import UIKit

class MyGroupsCell: UITableViewCell {

    @IBInspectable var startColor: UIColor = .white
    @IBInspectable var endColor: UIColor = .white
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        groupName.text = ""
        groupImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIView.getGradient(on: self, with: [startColor, endColor], isVertical: true)
    }
    
    func configure(name: String, image: UIImage) {
        self.groupName.text = name
        self.groupImage.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
