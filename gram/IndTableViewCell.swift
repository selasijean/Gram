//
//  IndTableViewCell.swift
//  gram
//
//  Created by Jean Adedze on 6/24/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class IndTableViewCell: UITableViewCell {
    


    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    
    var gramPost: PFObject! {
        didSet {
            self.photoView.file = gramPost["media"] as? PFFile
            self.photoView.loadInBackground()
            //            if let caption = gramPost["caption"] as? String{
            //              self.captionLabel.text = caption
            //            }
            self.captionLabel.text = gramPost["caption"] as? String
            //let username = gramPost["author"] as? PFUser
//            if let name = username!["username"]{
//                self.userLabel.text = name as? String
            }
        }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
