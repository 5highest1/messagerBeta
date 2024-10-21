//
//  UsersCellTableViewCell.swift
//  qChat
//
//  Created by Highest on 20.10.2024.
//

import UIKit

class UsersCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    static let reoseId = "UsersCellTableViewCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCell(_ name: String) {
        userName.text = name
    }
    
    func settingCell() {
        parentView.layer.cornerRadius = 10
        userImage.layer.cornerRadius = userName.frame.width/2
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
