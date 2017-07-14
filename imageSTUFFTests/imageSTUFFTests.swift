//
//  imageSTUFFTests.swift
//  imageSTUFFTests
//
//  Created by Daniel Reinhart on 7/11/17.
//  Copyright © 2017 Daniel Reinhart. All rights reserved.
//

import XCTest
@testable import imageSTUFF

class imageSTUFFTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCompareOne() {
        // This is an example of a performance test case.
        let image1 = UIImage(named: "drawing1.jpg")!
        let image2 = UIImage(named: "drawing2.jpg")!
        self.measure {
            _ = image1.compare(to: image2)
        }
    }

    func testCompareTwo() {
        // This is an example of a performance test case.
        let image1 = UIImage(named: "drawing1.jpg")!
        let image2 = UIImage(named: "drawing2.jpg")!
        self.measure {
            _ = image1.compare2(to: image2)
        }
    }

    func testCompareThree() {
        // This is an example of a performance test case.
        let image1 = UIImage(named: "drawing1.jpg")!
        let image2 = UIImage(named: "drawing2.jpg")!
        self.measure {
            _ = image1.compare3(to: image2)
        }
    }

    func testCompareFour() {
        // This is an example of a performance test case.
        let image1 = UIImage(named: "drawing1.jpg")!
        let image2 = UIImage(named: "drawing2.jpg")!
        self.measure {
            _ = image1.compare4(to: image2)
        }
    }

    func testKernel() {
        let image1 = CIImage(image: UIImage(named: "drawing1.jpg")!)!
        let image2 = CIImage(image: UIImage(named: "drawing2.jpg")!)!
        let filter = ComparisonFilter(image1: image1, image2: image2)
        self.measure {
            _ = filter.outputImage
        }
    }

}
