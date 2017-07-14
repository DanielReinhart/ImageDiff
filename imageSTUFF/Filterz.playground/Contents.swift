import UIKit

var str = "Hello, playground"

class ComparisonFilter: CIFilter {
    private let image1: CIImage
    private let image2: CIImage
    private let colorKernel: CIColorKernel

    init(image1: CIImage, image2: CIImage) {
        self.image1 = image1
        self.image2 = image2
        self.colorKernel = ComparisonFilter.createKernel()
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("dont use this")
    }

    private class func createKernel() -> CIColorKernel {
        let kernelString =
            "kernel vec4 _invertColor( __sample s1, __sample s2, float threshold ) { \n" +
                "  float diffR = abs(s1.r - s2.r);\n" +
                "  float diffG = abs(s1.g - s2.g);\n" +
                "  float diffB = abs(s1.b - s2.b);\n" +
                "  float averageR = (s1.r + s2.r) * 0.5;\n" +
                "  float averageG = (s1.g + s2.g) * 0.5;\n" +
                "  float averageB = (s1.b + s2.b) * 0.5;\n" +
                "  float r = compare( diffR - threshold, averageR, 1.0 );\n" +
                "  float b = compare( diffB - threshold, averageB, 1.0 );\n" +
                "  if ( ((s1.r == s1.b) && (s1.b == s1.g)) && ((s2.r == s2.b) && (s2.b == s2.g)) && (diffR <= threshold) ) {\n" +
                "  return vec4(averageR, averageG, averageB, s1.a); \n" +
                "  }\n" +
                "  if ( r == 1.0 || b == 1.0 ) {\n" +
                "  if ( s1.r > s2.r ) {\n" +
                "  return vec4(r, 0.0, 0.0, s1.a); \n" +
                "  } else{\n" +
                "  return vec4(0.0, 0.0, b, s1.a); \n" +
                "  }\n" +
                "  }\n" +
                "  return vec4(averageR, averageG, averageB, s1.a); \n" +
        "}"
        return CIColorKernel(string: kernelString)!
    }

    override var outputImage : CIImage! {
        let extent = image1.extent
        let threshold = CGFloat(0.15)
        let args = [image2 as AnyObject,image1 as AnyObject, threshold as AnyObject]
        let image = colorKernel.apply(withExtent: extent, arguments: args)
        return image
    }
}
var drawing1 = UIImage(named: "drawing5_rev0.jpg")
var drawing2 = UIImage(named: "drawing5_rev6.jpg")

let filter = ComparisonFilter(image1: CIImage(image: drawing1!)!, image2: CIImage(image: drawing2!)!)
let image = filter.outputImage