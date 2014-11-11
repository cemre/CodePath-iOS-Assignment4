//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Cemre Güngör on 11/9/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var photoActionsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        scrollView.delegate = self
        scrollView.contentSize = imageView.frame.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            var translation = sender.translationInView(view)
            var velocity = sender.velocityInView(view)
            
            
            
            if sender.state == UIGestureRecognizerState.Began {
                
            } else if sender.state == UIGestureRecognizerState.Changed {
                imageView.center = CGPoint(x: 320 / 2, y: 568 / 2 + translation.y)
                var newAlpha = CGFloat(convertValue(abs(Float(translation.y)), r1Min: 0, r1Max: 100, r2Min: 1, r2Max: 0))
                view.backgroundColor = UIColor(white: 0, alpha: newAlpha)
                photoActionsImageView.alpha = newAlpha
                doneButton.alpha = newAlpha
                
            } else if sender.state == UIGestureRecognizerState.Ended {
                if abs(Float(translation.y)) < 100 {
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.imageView.center = self.view.center
                        self.view.backgroundColor = UIColor(white: 0, alpha: 1)
                        self.doneButton.alpha = 1
                        self.photoActionsImageView.alpha = 1
                    })
                } else {
                    dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }

    }
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
}
