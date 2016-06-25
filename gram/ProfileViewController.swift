//
//  ProfileViewController.swift
//  gram
//
//  Created by Jean Adedze on 6/20/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit
import Parse

extension UIImageView{
    public func circularImage(anyImage: UIImageView){
        anyImage.layer.frame = CGRectInset(anyImage.layer.frame, 0, 0)
        anyImage.layer.borderColor = UIColor.grayColor().CGColor
        anyImage.layer.cornerRadius = anyImage.frame.height/2
        anyImage.layer.masksToBounds = false
        anyImage.clipsToBounds = true
        anyImage.layer.borderWidth = 0.5
        anyImage.contentMode = UIViewContentMode.ScaleAspectFill
    }
}

class ProfileViewController: UIViewController,UICollectionViewDelegate  {

    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var posts = [PFObject]?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        profilePhoto.circularImage(profilePhoto)
        infoView.layer.cornerRadius = 10
        //collectionView.layer.cornerRadius = 10
        
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 15)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
    }
    
    func loadData(){
        let query = PFQuery(className: "Post")
        query.includeKey("author")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (posts:[PFObject]?, error: NSError?) -> Void in
            if error == nil{
                self.posts = posts
                self.collectionView.reloadData()
                //print(posts)
            }else{
                //print(error)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOut(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logOutSegue", sender: nil)
   
    }

    
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPathForCell(cell)
        let photo = posts![(indexPath?.row)!]
        let detailViewController = segue.destinationViewController as! IndPhotoViewController
        detailViewController.photo = photo
        detailViewController.index = indexPath?.row
        
         //Get the new view controller using segue.destinationViewController.
         //Pass the selected object to the new view controller.
        
    }
    

}
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let posts = posts {
            return posts.count
        }else{
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Photo", forIndexPath: indexPath) as! ProfilePhotosCell
        let photo = posts![indexPath.row]
        cell.myPost = photo
        
        
        
        //let cellColor = colorForIndexPath(indexPath)
        //cell.backgroundColor = cellColor
        
//        if CGColorGetNumberOfComponents(cellColor.CGColor) == 4 {
//            let redComponent = CGColorGetComponents(cellColor.CGColor)[0] * 255
//            let greenComponent = CGColorGetComponents(cellColor.CGColor)[1] * 255
//            let blueComponent = CGColorGetComponents(cellColor.CGColor)[2] * 255
//            cell.colorLabel.text = String(format: "%.0f, %.0f, %.0f", redComponent, greenComponent, blueComponent)
//        }
        
        return cell
    }
}

