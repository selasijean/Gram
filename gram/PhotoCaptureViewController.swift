//
//  PhotoCaptureViewController.swift
//  gram
//
//  Created by Jean Adedze on 6/20/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit
import M13ProgressSuite

class PhotoCaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var captionField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickPhoto(sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func takePhoto(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        photoView.image = editedImage
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postPhoto(sender: AnyObject) {
//        M13ProgressView.init(frame: view.bounds)
//        self.view.addSubview(M13ProgressView.v)
//        let progressView = M13ProgressViewPie()
//        progressView.backgroundRingWidth = 2.0
//        progressView.setProgress(0.1, animated: true)
////        let progressView = M13ProgressViewPie.init()
////        progressView.backgroundRingWidth = 2.0
//        self.view.addSubview(progressView)
        
//        progressView.animationDuration = 5.0
        
        Post.postUserImage(photoView.image, withCaption: captionField.text, withCompletion: {(success: Bool, error: NSError?) in
            if success{
                print ("Photo Upload Successfull")
            }
            else{
            print ("failed")
            }
        })
        
        
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
