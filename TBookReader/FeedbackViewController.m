//
//  FeedbackViewController.m
//  TBookReader
//
//  Created by Sean on 2017/12/15.
//  Copyright © 2017年 Tany. All rights reserved.
//

#import "FeedbackViewController.h"
#import <MBProgressHUD.h>
#import <AVOSCloud.h>

@interface FeedbackViewController ()<UITextViewDelegate>
{
    MBProgressHUD * HUD;
}
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UITextView *text;

@end

@implementation FeedbackViewController
- (IBAction)done:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)push:(UIBarButtonItem *)sender {
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    if ([self.text.text isEqualToString:@"请在此输入您的意见"]||[self.text.text isEqualToString:@""]) {
        HUD.label.text = @"内容不可以为空喔";
        [HUD hideAnimated:YES afterDelay:1.0];
        return;
    }
    HUD.label.text = @"上传中 ... ";
    AVObject *product = [AVObject objectWithClassName:@"feedback"];
    [product setObject:self.textfield.text forKey:@"email"];
    [product setObject:self.text.text forKey:@"text"];
    [product saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            HUD.label.text = @"感谢";
            [HUD hideAnimated:YES afterDelay:1.5];
        } else {
            [HUD hideAnimated:YES];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textfield.layer.borderColor = MASTER_COLOR.CGColor;
    self.textfield.layer.borderWidth = 1;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
