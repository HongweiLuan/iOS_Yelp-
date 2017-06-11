//
//  TableViewCell.h
//  myYelpStudy
//
//  Created by Jiaoyuan Huang on 5/29/17.
//  Copyright © 2017 Hongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"


@interface TableViewCell : UITableViewCell
- (void)upBasedOnDataModel:(YelpDataModel *)dataModel;
@end
