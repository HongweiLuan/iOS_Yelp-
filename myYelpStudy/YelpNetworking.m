//
//  YelpNetworking.m
//  myYelpStudy
//
//  Created by Jiaoyuan Huang on 5/28/17.
//  Copyright © 2017 Hongwei. All rights reserved.
//

#import "YelpNetworking.h"
#import "YelpDataModel.h"
#import "YelpDataStore.h"

typedef void (^TokenTask)(NSString *token);
static NSString const * kGrantType = @"client_credentials";
static NSString const * kClient_id = @"0_bN5SjZ1WsGjEXQnsN6cQ";
static NSString const * kClient_secret = @"qX5WN1E3bDaXU8J9Bhxlxgzuin5xS0pXvlCsTOm4vtuytYbqm2s0wkeZ7zd2xMoq";
static NSString const * kTokenEndPoint = @"https://api.yelp.com/oauth2/token";
@interface YelpNetworking ()
@property (copy) NSString *token;
@end
@implementation YelpNetworking
+ (YelpNetworking *)sharedInstance {
    static YelpNetworking *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[YelpNetworking alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]){
        [self fetchTokenWithTokenTask:nil];
    }
    return self;
}

- (void)fetchTokenWithTokenTask:(TokenTask)tokenTask
{
    NSURL *url = [NSURL URLWithString:kTokenEndPoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"grant_type=%@&client_id=%@&client_secret=%@", kGrantType, kClient_id,kClient_secret];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask *postDataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        self.token = dict[@"access_token"];
        if (tokenTask) {
            tokenTask(self.token);
        }
    }];
    [postDataTask resume];
}

- (void)fetchRestaurantsBasedOnLocation:(CLLocation *)location term:(NSString *)term completionBlock:(RestaurantCompletionBlock)completionBlock
{
    
    TokenTask tokenTask = ^(NSString *token){
        
        NSString *string = [NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/search?term=%@&latitude=%.6f&longitude=%.6f",term, location.coordinate.latitude, location.coordinate.longitude];
        
        NSString* encodedUrl = [string stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:encodedUrl];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        
        [request setHTTPMethod:@"GET"];
        
        NSString *headerToken = [NSString stringWithFormat:@"Bearer %@",self.token];
        [request addValue:headerToken forHTTPHeaderField:@"Authorization"];
        
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *dict = @{};
            if (data) {
                dict  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            }
            
            // we update here
            if (!error) {
                NSArray<YelpDataModel *> *dataModelArray = [YelpDataModel buildDataModelArrayFromDictionaryArray:dict[@"businesses"]];
                [YelpDataStore sharedInstance].dataModels = dataModelArray;
                
                completionBlock(dataModelArray);
            }
        }];
        
        [dataTask resume];
    };
    
    if (self.token) {
        tokenTask(self.token);
    } else {
        [self fetchTokenWithTokenTask:tokenTask];
    }
}


@end
