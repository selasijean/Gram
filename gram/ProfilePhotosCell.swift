//
//  ProfilePhotosCell.swift
//  gram
//
//  Created by Jean Adedze on 6/22/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfilePhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: PFImageView!
    
    var myPost: PFObject! {
        didSet {
            self.photoView.file = myPost["media"] as? PFFile
            self.photoView.loadInBackground()
            //            if let caption = gramPost["caption"] as? String{
            //              self.captionLabel.text = caption
            //            }
            //self.captionLabel.text = gramPost["caption"] as? String
            
        }
    }

    
    
}
