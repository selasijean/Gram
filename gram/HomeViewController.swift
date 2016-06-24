//
//  HomeViewController.swift
//  gram
//
//  Created by Jean Adedze on 6/21/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit
import Parse


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //@IBOutlet weak var navigationBar: UINavigationBar!

    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]?()
    let HeaderViewIdentifier = "TableHeaderView"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        
        let logo = UIImage(named: "gram3")
    
       let logoView = UIImageView(image: logo)
        self.navigationController?.navigationBar.topItem?.titleView = logoView
        
        // Do any additional setup after loading the view.
        
        //loadData()
        //tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = true
        //self.setNeedsStatusBarAppearanceUpdate()
        //self.tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return (navigationController?.navigationBarHidden)!
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
        //tableView.reloadData()
    }
    
    func loadData(){
        let query = PFQuery(className: "Post")
        query.includeKey("author")
        query.includeKey("likeState")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (posts:[PFObject]?, error: NSError?) -> Void in
            if error == nil{
                self.posts = posts
                self.tableView.reloadData()
                print(posts)
            }else{
                print(error)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let posts = posts{
            return posts.count
        }else{
            return 0
        }
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
        
    
        let photo = posts![section]
        let author = photo["author"] as? PFUser
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
        
        if let posts = posts{
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        let photo = posts![indexPath.section]
//        var photoName = "like"
//        
//        photoName = !cell.likeButton.LikeState ? "like" : "like2"
        //cell.likeButton.LikeState = photo["likeState"] as? Bool
//        let likeDict = photo["likesCount"] as! [PFUser: Bool]
//        let author = photo["author"] as! PFUser
//        cell.likeButton.LikeState = likeDict[author]!
        cell.likeButton.LikeIndex = indexPath.section
        let likers = photo["likers"] as? [String]
        if likers?.contains("\(PFUser.currentUser()!["username"])") == true {
            cell.likeButton.LikeState = true
            cell.likeButton.tintColor = UIColor.redColor()
            cell.likeButton.setImage(UIImage(named: "like2"),forState: UIControlState.Normal)
            
        }else{
            cell.likeButton.LikeState = false
            
        }
        cell.likeButton.addTarget(self, action: #selector(HomeViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.gramPost = photo
        
//        cell.likeButton.setImage(UIImage(named: photoName), forState: UIControlState.Normal)
        return cell
    }

    func buttonClicked(sender: LikeButton){
        //shorter
//        if sender.selected == true{
//            sender.tintColor = UIColor.redColor()
//        }
//        
//        sender.selected = !sender.selected
//        
        var photo = posts![sender.LikeIndex]
        var likers = photo["likers"] as? [String]
        let username = PFUser.currentUser()!["username"] as! String
        
        if !sender.LikeState{
            sender.tintColor = UIColor.redColor()
            sender.setImage(UIImage(named: "like2"),forState: UIControlState.Normal)
                likers?.append(username)
                photo["likers"] = likers
                sender.LikeState = !sender.LikeState
        }else{
            sender.tintColor = UIColor.blackColor()
            sender.setImage(UIImage(named: "like"),forState: UIControlState.Normal)
            sender.LikeState = !sender.LikeState
            let index = likers?.indexOf(username)
            //print(likers)
            likers?.removeAtIndex(index!)
            print(likers)
            photo["likers"] = likers
    }
        
     photo.saveInBackground()
        //loadData()
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
