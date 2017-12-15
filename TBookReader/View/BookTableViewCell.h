//
//  BookTableViewCell.h
//  TBookReader
//
//  Created by Sean on 2017/12/14.
//  Copyright © 2017年 Tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVObject;
@interface BookTableViewCell : UITableViewCell

@property (strong, nonatomic) AVObject * model;
@property ( nonatomic) BOOL load;
@end
