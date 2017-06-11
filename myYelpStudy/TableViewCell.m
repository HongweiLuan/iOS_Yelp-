//
//  TableViewCell.m
//  myYelpStudy
//
//  Created by Jiaoyuan Huang on 5/29/17.
//  Copyright © 2017 Hongwei. All rights reserved.
//

#import "TableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "YelpDataModel.h"
@interface TableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImage;
@property (weak, nonatomic) IBOutlet UILabel *reviews;
@property (weak, nonatomic) IBOutlet UILabel *dollarLabel;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *category;

@end

@implementation TableViewCell

- (void)upBasedOnDataModel:(YelpDataModel *)dataModel
    {
        self.restaurantName.text = dataModel.name;
        [self.restaurantImage setImageWithURL:[NSURL URLWithString:dataModel.imageUrl]];
        self.ratingImage.image = dataModel.ratingImage;
        self.reviews.text = [NSString stringWithFormat:@"reviews %ld", dataModel.reviewCount];
        self.dollarLabel.text = dataModel.price;
        self.address.text = dataModel.displayAddress;
        self.category.text = dataModel.categories;
    }
    
- (void)awakeFromNib {
        [super awakeFromNib];
        // Initialization code
        self.restaurantImage.layer.cornerRadius = 5.0f;
        self.restaurantImage.layer.masksToBounds = YES;
    }
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
        [super setSelected:selected animated:animated];
        
        // Configure the view for the selected state
    }



@end
