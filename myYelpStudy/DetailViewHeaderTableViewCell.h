//
//  DetailViewHeaderTableViewCell.h
//  myYelpStudy
//
//  Created by Jiaoyuan Huang on 6/4/17.
//  Copyright © 2017 Hongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"

@interface DetailViewHeaderTableViewCell : UITableViewCell
- (void)upBasedOnDataModel:(YelpDataModel *)dataModel;
@end
