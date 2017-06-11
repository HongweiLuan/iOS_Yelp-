//
//  YelpDataStore.m
//  myYelpStudy
//
//  Created by Jiaoyuan Huang on 6/4/17.
//  Copyright © 2017 Hongwei. All rights reserved.
//


#import "YelpDataStore.h"
@implementation YelpDataStore

+ (YelpDataStore *)sharedInstance {
    static YelpDataStore *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[YelpDataStore alloc] init];
    });
    return _sharedInstance;
}
@end
