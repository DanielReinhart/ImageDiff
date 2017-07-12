//
//  ViewController.swift
//  imageSTUFF
//
//  Created by Daniel Reinhart on 7/11/17.
//  Copyright © 2017 Daniel Reinhart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var imageView2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let image1 = UIImage(named: "drawing3.jpg")!
        let image2 = UIImage(named: "drawing4.jpg")!

        let outputImage = image1.compare3(to: image2)
        imageView.image = outputImage
        imageView2.image = image1

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

