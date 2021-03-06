//
//  Post.swift
//  CPOutfitters
//
//  Created by Cory Thompson on 4/6/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    class func postUserImage(image: UIImage?, withCaption caption: NSString?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")
        post["image"] = Article.getPFFileFromImage(image)
        post["author"] = PFUser.currentUser()
        post["caption"] = caption
        
        post.saveInBackgroundWithBlock(completion)
    }
    
    class func postOutfit(topImage: UIImage?, bottomImage: UIImage?, footwearImage: UIImage?, withCaption caption: NSString?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")
        post["topImage"] = Article.getPFFileFromImage(topImage)
        post["bottomImage"] = Article.getPFFileFromImage(bottomImage)
        post["footwearImage"] = Article.getPFFileFromImage(footwearImage)
        post["author"] = PFUser.currentUser()
        post["caption"] = caption
        
        post.saveInBackgroundWithBlock(completion)
    }
}
