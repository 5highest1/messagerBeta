//
//  SlideLoginCollectionViewCell.swift
//  qChat
//
//  Created by Highest on 08.09.2024.
//

import UIKit


class SlideLoginCollectionViewCell: UICollectionViewCell {
    static let reoseId = "SlideLoginCollectionViewCell"
    
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var slideImg: UIImageView!
    @IBOutlet weak var regBtn: UIButton!
    @IBOutlet weak var authBtn: UIButton!
    var delegate: LoginViewControllerDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(slide: Slides) {
        slideImg.image = slide.img
        descriptionText.text = slide.text
    }
    @IBAction func regBtnClick(_ sender: Any) {
        delegate.openRegVC()
        
        
    }
    @IBAction func authBtnCkick(_ sender: Any) {
        delegate.openAuthVC()
    }
    
}
