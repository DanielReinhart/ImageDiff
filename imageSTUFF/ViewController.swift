//
//  ViewController.swift
//  imageSTUFF
//
//  Created by Daniel Reinhart on 7/11/17.
//  Copyright © 2017 Daniel Reinhart. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var imageOneName: String?
    var imageTwoName: String?
    @IBOutlet weak var scrollView: UIScrollView!
    var diffImageView = UIImageView(frame: .zero)

    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let image1 = UIImage(named: imageOneName!)!
        let image2 = UIImage(named: imageTwoName!)!

        let outputImage = image1.compare(to: image2)
        imageView2.image = image1
        imageView3.image = image2

        diffImageView.image = outputImage
        diffImageView.translatesAutoresizingMaskIntoConstraints = false
        diffImageView.frame = scrollView.bounds
        scrollView.contentSize = outputImage.size
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 5
        scrollView.addSubview(diffImageView)
        scrollView.delegate = self

        diffImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint(item: diffImageView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: diffImageView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return diffImageView
    }

}

