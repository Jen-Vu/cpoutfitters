//
//  PostViewController.swift
//  CPOutfitters
//
//  Created by Cory Thompson on 4/6/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostViewController: UIViewController {
    
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaptionTextField: UITextField!

    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        article.mediaImage.getDataInBackgroundWithBlock { (picture: NSData?, error: NSError?) in
            if error == nil {
                self.postImageView.image = UIImage(data: picture!)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPostImage(sender: AnyObject) {
        Post.postUserImage(postImageView.image, withCaption: postCaptionTextField.text) { (success: Bool, error: NSError?) in
            if success {
                print("posted")
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }

    @IBAction func onCancel(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
