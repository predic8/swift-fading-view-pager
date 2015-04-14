//
//  ViewController.swift
//  PagingScrollview
//
//  Created by Daniel Bonnauer on 31.03.15.
//  Copyright (c) 2015 Daniel Bonnauer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!

    var tabCount = 7
    var images:[UIImageView]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var frame = CGRect(x: 0, y: 0, width: self.view.bounds.width*CGFloat(tabCount), height: self.view.bounds.height)
        var rootView = UIView(frame: frame)
        
        for index in 0...tabCount-1 {
            var subFrame = CGRect(x: self.view.bounds.width*CGFloat(index), y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            var subView = UIView(frame: subFrame)

            var image = UIImage(named: "iphone")
            var imageView = UIImageView(image: image)
            
            // zentrieren des Inhalts
            if let width = image?.size.width {
                imageView.frame.origin.x = (self.view.bounds.width-width)/2
            }
            if let height = image?.size.height {
                imageView.frame.origin.y = (self.view.bounds.height-height)/2
            }
            
            // erzeugen der einzelnen Hintergründe
            var backgroundimage = UIImage(named: "page\(index+1)")
            var backgroundImageView = UIImageView(frame: self.view.frame)
            backgroundImageView.contentMode = .ScaleAspectFill
            backgroundImageView.image = backgroundimage
            images.append(backgroundImageView)
            self.view.insertSubview(backgroundImageView, belowSubview: scrollView)
            subView.addSubview(imageView)
            rootView.addSubview(subView)
        }

        // initializing Control Elements
        pageControl.numberOfPages = tabCount
        pageControl.currentPage = 0

        scrollView.delegate = self
        scrollView.addSubview(rootView)
        scrollView.contentSize = frame.size
        
        animiereWechsel()
    }
    
    func animiereWechsel() {
        
        pageControl.currentPage = aktuelleSeite()
        var viewWidth = self.view.frame.width
        
        for (index, view) in enumerate(images) {
            view.alpha = (scrollView.contentOffset.x-(CGFloat(index-1)*viewWidth))/viewWidth
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        animiereWechsel()
    }
    
    // MARK: - Util Methods
    
    func blätterFortschritt() -> CGFloat {
        return (scrollView.contentOffset.x % self.view.frame.width) / self.view.frame.width
    }
    
    func bildschirmBreite() -> Int {
        return Int(self.view.frame.width)
    }
    
    func aktuelleSeite() -> Int {
        return Int(scrollView.contentOffset.x) / bildschirmBreite()
    }

}