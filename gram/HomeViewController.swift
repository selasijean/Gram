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

    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]?()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //self.loadData()
    
        // Do any additional setup after loading the view.
        
        //loadData()
        //tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
        //tableView.reloadData()
    }
    
    func loadData(){
        let query = PFQuery(className: "Post")
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts{
            return posts.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        let photo = posts![indexPath.row]
        cell.gramPost = photo
        
        
        return cell
        
        
        
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
