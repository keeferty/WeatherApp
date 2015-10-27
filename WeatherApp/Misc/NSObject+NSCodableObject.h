//
//  NSObject+NSCodableObject.h
//  BrandUCenter
//
//  Created by Pawel Weglewski on 22/08/14.
//  Copyright (c) 2014 ITMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSCodableObject) <NSCoding>
- (NSArray *)propertyNames;
- (NSArray *)ivarNames;
@end
