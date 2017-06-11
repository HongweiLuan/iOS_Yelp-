//
//  YelpNetworking.h
//  myYelpStudy
//
//  Created by Jiaoyuan Huang on 5/28/17.
//  Copyright © 2017 Hongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
//#import "YelpDataModel.h"

@import CoreLocation;
@class YelpDataModel;

typedef void (^RestaurantCompletionBlock)(NSArray <YelpDataModel *>* dataModelArray);

@interface YelpNetworking : NSObject

+ (YelpNetworking *)sharedInstance;

- (void)fetchRestaurantsBasedOnLocation:(CLLocation *)location term:(NSString *)term completionBlock:(RestaurantCompletionBlock)completionBlock;

@end
