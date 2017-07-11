//
//  Image+Pixels.h
//  imageSTUFF
//
//  Created by Daniel Reinhart on 7/11/17.
//  Copyright © 2017 Daniel Reinhart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Image_Pixels : NSObject

+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)x andY:(int)y count:(int)count;

@end
