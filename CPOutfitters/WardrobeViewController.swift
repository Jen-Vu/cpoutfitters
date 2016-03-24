//
//  WardrobeViewController.swift
//  CPOutfitters
//
//  Created by Eric Gonzalez on 3/10/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

let cellHeight: CGFloat = 100.0
let kAddArticleSegueIdentifier = "addArticle"
let kEditArticleSegueIdentifier = "editArticle"

class WardrobeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var types = ["Tops", "Bottoms", "Footwear"]
    var expanded = [true, true, true]
    var articles: [[Article]] = [[],[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellHeight
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ImageLabelView(frame: CGRectZero)
        
        // Add gradient
        view.backgroundColor = UIColor.whiteColor()
        let gradientLayer = view.gradientLayer
        gradientLayer.colors = [UIColor(white: 1.0, alpha: 1.0).CGColor, UIColor(white: 0.85, alpha: 1.0).CGColor]
        gradientLayer.locations = [0.5]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)

        
        // Customize per Section
        view.imageSideLeft = false
        view.labelView.text = types[section]
        var imageName: String

        switch (section) {
        case 0: imageName = "tops"
        case 1: imageName = "bottoms"
        default: imageName = "footwear"
        }
        view.imageView.image = UIImage(named: imageName)
        
        
        // Add expand/collapse gesture recognizer
        var tapGesture = CPTapGestureRecognizer(target: self, action: "toggleSection:")
        tapGesture.section = section
        view.addGestureRecognizer(tapGesture)
        
        
        // Add Expand Icon
        let expandButton = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.image = UIImage(named: "arrow")
        let isExpanded = expanded[section]
        expandButton.layer.transform = CATransform3DMakeRotation(angleForArrow(isExpanded), 0, 0, 1.0)
        
        view.addSubview(expandButton)
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: expandButton, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: expandButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0))
        
        // Add add Icon
        
        let addButton = UIButton(type: .ContactAdd)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.tintColor = UIColor.whiteColor()
        addButton.layer.backgroundColor = UIColor(red: 0.0999, green: 0.7602, blue: 0.0144, alpha: 1.0).CGColor
        addButton.layer.cornerRadius = 12
        
        view.addSubview(addButton)
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Right, relatedBy: .Equal, toItem: addButton, attribute: .Right, multiplier: 1.0, constant: 8))
        view.addConstraint(NSLayoutConstraint(item: addButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 8))
        
        tapGesture = CPTapGestureRecognizer(target: self, action: "addArticle:")
        tapGesture.section = section
        addButton.addGestureRecognizer(tapGesture)

        return view
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expanded[section] ? articles[section].count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WardrobeTypeCell", forIndexPath: indexPath) as! WardrobeTypeCell

        cell.article = articles[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func toggleSection(sender: CPTapGestureRecognizer) {
        let section = sender.section
        expanded[section] = !expanded[section]
        tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
    }

    func addArticle(sender: CPTapGestureRecognizer) {
        self.performSegueWithIdentifier(kAddArticleSegueIdentifier, sender: sender)
    }
    
    func angleForArrow(expanded: Bool) -> CGFloat {
        return CGFloat(expanded ? M_PI / 2.0 : M_PI * 1.5 )
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var article: Article?
        
        if segue.identifier == kAddArticleSegueIdentifier {
            let gesture = sender as! CPTapGestureRecognizer
            article = Article()
            switch (gesture.section) {
            case 0: article!.type = "top"
            case 1: article!.type = "bottom"
            default: article!.type = "footwear"
            }
            
            article!.owner = PFUser.currentUser()
        }
        else {  // Edit segue
            let cell = sender as! WardrobeTypeCell
            article = cell.article
        }
        
        // Get the new view controller using segue.destinationViewController.
        if let articleController = segue.destinationViewController as? ArticleViewController {
            articleController.article = article
        }
    }

}