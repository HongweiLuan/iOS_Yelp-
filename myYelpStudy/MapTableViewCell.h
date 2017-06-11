//
//  MapTableViewCell.h
//  myYelpStudy
//
//  Created by Jiaoyuan Huang on 6/9/17.
//  Copyright © 2017 Hongwei. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "YelpDataModel.h"
#import "YelpAnnotation.h"

@interface MapTableViewCell : UITableViewCell

- (void)upBasedOnDataModel:(YelpDataModel *)dataModel;

@end

