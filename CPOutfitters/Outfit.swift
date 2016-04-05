//
//  Outfit.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 08/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Outfit: PFObject, PFSubclassing {
    
    @NSManaged var owner: PFUser!
    @NSManaged var components: [Article]!
    @NSManaged var favorite: Bool
    @NSManaged var lastWorn: NSDate?
    @NSManaged var useCount: Int
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Outfit"
    }
    
    override init() {
        super.init()
    }
    
    init(object: PFObject) {
        super.init()
        
        self.owner = object["owner"] as? PFUser
        self.components = object["articles"] as! [Article]
        self.favorite = object["favorite"] as! Bool
        self.lastWorn = object["last_worn"] as? NSDate
        self.useCount = object["use_count"] as! Int
    }

}
