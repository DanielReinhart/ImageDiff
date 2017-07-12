//
//  ViewController.swift
//  imageSTUFF
//
//  Created by Daniel Reinhart on 7/11/17.
//  Copyright © 2017 Daniel Reinhart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageOneName: String?
    var imageTwoName: String?

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let image1 = UIImage(named: imageOneName!)!
        let image2 = UIImage(named: imageTwoName!)!

        let outputImage = image1.compare(to: image2)
        imageView.image = outputImage
        imageView2.image = image1
        imageView3.image = image2

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

