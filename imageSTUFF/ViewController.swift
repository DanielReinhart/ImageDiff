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
    @IBOutlet weak var scrollViewOne: UIScrollView!
    var imageViewOne = UIImageView(frame: .zero)
    @IBOutlet weak var scrollViewTwo: UIScrollView!
    var imageViewTwo = UIImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        let image1 = UIImage(named: imageOneName!)!
        let image2 = UIImage(named: imageTwoName!)!

        let outputImage = image1.compare4(to: image2)

        // Diff view setup
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

        // image view 1 setup
        imageViewOne.image = image1
        imageViewOne.translatesAutoresizingMaskIntoConstraints = false
        imageViewOne.frame = scrollViewOne.bounds
        scrollViewOne.contentSize = image1.size
        scrollViewOne.minimumZoomScale = 0.5
        scrollViewOne.maximumZoomScale = 5
        scrollViewOne.addSubview(imageViewOne)
        scrollViewOne.delegate = self

        imageViewOne.contentMode = .scaleAspectFit
        NSLayoutConstraint(item: imageViewOne, attribute: .width, relatedBy: .equal, toItem: scrollViewOne, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageViewOne, attribute: .height, relatedBy: .equal, toItem: scrollViewOne, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageViewOne, attribute: .centerY, relatedBy: .equal, toItem: scrollViewOne, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageViewOne, attribute: .centerX, relatedBy: .equal, toItem: scrollViewOne, attribute: .centerX, multiplier: 1, constant: 0).isActive = true

        // image view 2 setup
        imageViewTwo.image = image2
        imageViewTwo.translatesAutoresizingMaskIntoConstraints = false
        imageViewTwo.frame = scrollViewTwo.bounds
        scrollViewTwo.contentSize = image2.size
        scrollViewTwo.minimumZoomScale = 0.5
        scrollViewTwo.maximumZoomScale = 5
        scrollViewTwo.addSubview(imageViewTwo)
        scrollViewTwo.delegate = self

        imageViewTwo.contentMode = .scaleAspectFit
        NSLayoutConstraint(item: imageViewTwo, attribute: .width, relatedBy: .equal, toItem: scrollViewTwo, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageViewTwo, attribute: .height, relatedBy: .equal, toItem: scrollViewTwo, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageViewTwo, attribute: .centerY, relatedBy: .equal, toItem: scrollViewTwo, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageViewTwo, attribute: .centerX, relatedBy: .equal, toItem: scrollViewTwo, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if scrollView === self.scrollView {
            return diffImageView
        } else if scrollView === self.scrollViewOne {
            return imageViewOne
        } else if scrollView === self.scrollViewTwo {
            return imageViewTwo
        } else {
            fatalError()
        }
    }

}

