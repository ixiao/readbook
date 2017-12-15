//
//  BookTableViewCell.m
//  TBookReader
//
//  Created by Sean on 2017/12/14.
//  Copyright © 2017年 Tany. All rights reserved.
//

#import "BookTableViewCell.h"
#import <AVObject.h>
#import <AFNetworking.h>

@interface BookTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UIButton *download;
@end

@implementation BookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setLoad:(BOOL)load
{
    _load = load;
    self.download.hidden = _load;
    if (_load) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}
- (void)setModel:(AVObject *)model
{
    _model = model;
    NSString * name = [model objectForKey:@"name"];
    self.bookName.text = name;
    
    BOOL file = [[NSFileManager defaultManager]fileExistsAtPath:[XXTools getPath:name]];
    if (file) {
        self.load = YES;
    }
}
- (IBAction)downloadButton:(UIButton *)sender {
    
    NSError * readErr;
    NSURL *url = [NSURL URLWithString:[self.model objectForKey:@"url"]];
    NSString * strData = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&readErr];
    if (readErr) {
        XLog(@"error:%@",readErr.localizedDescription);
    }
    NSString * filePath = [XXTools getPath:[self.model objectForKey:@"name"]];
    NSError * error;
    
    BOOL ok = [strData writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!ok) {
        XLog(@"error:%@",error.localizedDescription);
    }else
    {
        self.load = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
