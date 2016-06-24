//
//  Post.swift
//  gram
//
//  Created by Jean Adedze on 6/20/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        print(PFUser.currentUser())
        post["caption"] = caption
        post["likeState"] = false
//        var dict = NSDictionary()
//        dict{"hello"} = "strong"
//        dict[PFUser.currentUser()] = "false"
//        var likeDict = [PFUser: Bool]()
//        likeDict[PFUser.currentUser()!] = false
        post["likesCount"] = 0
        post["likers"] = []
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
