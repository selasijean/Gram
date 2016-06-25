//
//  IndPhotoViewController.swift
//  gram
//
//  Created by Jean Adedze on 6/24/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit
import Parse

class IndPhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let HeaderViewIdentifier = "TableHeaderView"
    
    var photo: PFObject?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier)! as UITableViewHeaderFooterView
        
        let frame = CGRectMake(5, 5, 20, 20)
        let myCustomView = UIImageView(frame: frame)
        let myImage = UIImage(named: "defaultPhoto")
        myCustomView.image = myImage
        myCustomView.circularImage(myCustomView)
        
        let labelFrame = CGRectMake(30, 5, 100, 20)
        let label = UILabel(frame: labelFrame)
        label.font = label.font.fontWithSize(12)
        //label.font = UIFont(name: "System", size: 5)
        
        
        //let cellphoto = photo![section]
        let author = photo!["author"] as? PFUser
        if let username = author{
            let user = username["username"]
            label.text = user as? String
            header.addSubview(label)
            //header.textLabel!.text = user as? String
            header.addSubview(myCustomView)
            
        }
        return header
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ICell") as! IndTableViewCell
        
        //
        let likers = photo!["likers"] as? [String]
        
        if likers?.contains("\(PFUser.currentUser()!["username"])") == true {
            cell.likeButton.LikeState = true
            cell.likeButton.tintColor = UIColor.redColor()
            cell.likeButton.setImage(UIImage(named: "like2"),forState: UIControlState.Normal)
            
        }else{
            cell.likeButton.setImage(UIImage(named: "like"),forState: UIControlState.Normal)
            cell.likeButton.tintColor = UIColor.blackColor()
            cell.likeButton.LikeState = false
            
        }
        
        cell.likeButton.addTarget(self, action: #selector(IndPhotoViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //
        cell.gramPost = photo
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonClicked(sender: LikeButton){
        //shorter
        //        if sender.selected == true{
        //            sender.tintColor = UIColor.redColor()
        //        }
        //
        //        sender.selected = !sender.selected
        //
        var photo1 = photo!
        var likers = photo1["likers"] as? [String]
        let username = PFUser.currentUser()!["username"] as! String
        
        if !sender.LikeState{
            sender.tintColor = UIColor.redColor()
            sender.setImage(UIImage(named: "like2"),forState: UIControlState.Normal)
            likers?.append(username)
            photo1["likers"] = likers
            sender.LikeState = !sender.LikeState
        }else{
            sender.tintColor = UIColor.blackColor()
            sender.setImage(UIImage(named: "like"),forState: UIControlState.Normal)
            sender.LikeState = !sender.LikeState
            let index = likers?.indexOf(username)
            //print(likers)
            likers?.removeAtIndex(index!)
            print(likers)
            photo1["likers"] = likers
        }
        photo1.saveInBackground()
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
