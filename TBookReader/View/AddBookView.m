//
//  AddBookView.m
//  TBookReader
//
//  Created by Sean on 2017/12/15.
//  Copyright © 2017年 Tany. All rights reserved.
//

#import "AddBookView.h"
#import <AVOSCloud.h>
#import <MBProgressHUD.h>

@implementation AddBookView
{
    MBProgressHUD * HUD;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _okButton.layer.cornerRadius = 3;
    _okButton.clipsToBounds = YES;
}
- (IBAction)okButtonAction:(UIButton *)sender {

    HUD = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = @"上传中 ... ";
    if (![self.bookUrl.text hasPrefix:@"http"]) {
        HUD.label.text = @"请确认您的URL格式";
        [HUD hideAnimated:YES afterDelay:1.5];
        return;
    }else if (![self.bookUrl.text hasSuffix:@".txt"]){
        HUD.label.text = @"URL必须'.txt'结尾哦";
        [HUD hideAnimated:YES afterDelay:1.5];
        return;
    }

    AVObject *product = [AVObject objectWithClassName:@"book"];
    [product setObject:self.bookName.text forKey:@"name"];
    [product setObject:self.bookUrl.text forKey:@"url"];
    [product saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            HUD.label.text = @"感谢";
            [HUD hideAnimated:YES afterDelay:1.5];
        } else {
            [HUD hideAnimated:YES];
        }
        [self.superview removeFromSuperview];
    }];
}

@end
