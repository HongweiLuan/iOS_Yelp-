//
//  YelpDataStore.h
//  myYelpStudy
//
//  Created by Jiaoyuan Huang on 6/4/17.
//  Copyright © 2017 Hongwei. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "YelpDataModel.h"
@import CoreLocation;
@interface YelpDataStore : NSObject
@property (nonatomic, copy) NSArray <YelpDataModel *> *dataModels;
@property (nonatomic) CLLocation *userLocation;

+ (YelpDataStore *)sharedInstance;
@end
