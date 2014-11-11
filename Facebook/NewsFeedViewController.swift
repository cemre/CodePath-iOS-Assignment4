//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var isPresenting: Bool = true
    var zoomingImage: UIImageView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.startAnimating()

        // Configure the content size of the scroll view
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
        scrollView.hidden = true
        
        delay(0.1) {
            self.scrollView.hidden = false
            self.activityIndicatorView.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        
        destinationViewController.image = self.imageView.image
        
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
        
    }
    
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        imageView = sender.view as UIImageView
        performSegueWithIdentifier("photoSegue", sender: self)
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        zoomingImage = UIImageView(image: imageView.image)
        zoomingImage.contentMode = imageView.contentMode
        zoomingImage.clipsToBounds = imageView.clipsToBounds
        
        var window = UIApplication.sharedApplication().keyWindow
        
        window?.addSubview(zoomingImage)
        
        if (isPresenting) {
            var photoViewController = toViewController as PhotoViewController
            photoViewController.imageView.hidden = true
            zoomingImage.frame = CGRectOffset(imageView.frame, scrollView.frame.origin.x - scrollView.contentOffset.x, scrollView.frame.origin.y - scrollView.contentOffset.y)
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            var size = imageView.image!.size
            
            imageView.hidden = true
            
            photoViewController.imageView.frame = CGRect(x: 0, y: 0, width: 320, height: 320 * size.height / size.width)
            photoViewController.imageView.center = CGPoint(x: 320/2, y: 568/2)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                self.zoomingImage.frame = photoViewController.imageView.frame
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    photoViewController.imageView.hidden = false
                    self.zoomingImage.removeFromSuperview()
            }
        } else {
            var feedViewController = toViewController as NewsFeedViewController
            var photoViewController = fromViewController as PhotoViewController
            
            zoomingImage.frame = photoViewController.imageView.frame
            
            photoViewController.imageView.hidden = true
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                self.zoomingImage.frame = CGRectOffset(feedViewController.imageView.frame, feedViewController.scrollView.frame.origin.x - feedViewController.scrollView.contentOffset.x, feedViewController.scrollView.frame.origin.y - feedViewController.scrollView.contentOffset.y)
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
                    feedViewController.imageView.hidden = false
                    self.zoomingImage.removeFromSuperview()
            }
        }
    }

}
