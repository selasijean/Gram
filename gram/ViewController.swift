//
//  ViewController.swift
//  gram
//
//  Created by Jean Adedze on 6/20/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var gettingStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let backgroundView = UIImageView(frame: view.bounds )//CGRectMake(0, 200, 300, 325))
        
//        let foregroundView = UIImageView(frame: view.bounds)
//        foregroundView.backgroundColor = UIColor.whiteColor()
//        foregroundView.makeBlurImage(foregroundView)
//        self.view.insertSubview(foregroundView, atIndex: 0)
        
        let backgroundImage:UIImage = UIImage(named: "cat1")!
        backgroundView.image = backgroundImage
        backgroundView.makeBlurImage(backgroundView)
        self.view.insertSubview(backgroundView, atIndex: 0)
        
        self.gettingStartedButton.layer.cornerRadius  = 20
        
        
        
    }
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(1.5, animations: {() -> Void in
            let endingColor = UIColor(red: (255.0/255.0), green: (61.0/255.0), blue: (24.0/255.0), alpha: 1.0)
            self.gettingStartedButton.backgroundColor = endingColor
//            let scaleTransform = CGAffineTransformMakeScale(1.5, 1.5)
//            self.gettingStartedButton.transform = scaleTransform
//            let rotationTransform = CGAffineTransformMakeRotation(3.14)
//            self.gettingStartedButton.transform = rotationTransform
//            self.gettingStartedButton.titleLabel?.transform = rotationTransform
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

