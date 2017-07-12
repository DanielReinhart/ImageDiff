//
//  SampleDataListViewController.swift
//  imageSTUFF
//
//  Created by Bradley Zeller on 7/12/17.
//  Copyright © 2017 Daniel Reinhart. All rights reserved.
//

import UIKit

struct ImagePair {
    let first: String
    let second: String
}

class SampleDataListViewController: UITableViewController {

    var imagePairs = [ImagePair]()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePairs = [
            ImagePair(first: "drawing1.jpg", second: "drawing2.jpg"),
            ImagePair(first: "drawing3.jpg", second: "drawing4.jpg"),
            ImagePair(first: "drawing3_rev0.jpg", second: "drawing3_rev4.jpg"),
        ]
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagePairs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let pair = imagePairs[indexPath.row]
        cell.textLabel?.text = "\(pair.first) / \(pair.second)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "push" {
            let vc = segue.destination as! ViewController
            let pair = imagePairs[tableView.indexPathForSelectedRow!.row]
            vc.imageOneName = pair.first
            vc.imageTwoName = pair.second
        }
    }
}
