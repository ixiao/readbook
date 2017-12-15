//
//  AddBookView.h
//  TBookReader
//
//  Created by Sean on 2017/12/15.
//  Copyright © 2017年 Tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBookView : UIView
@property (weak, nonatomic) IBOutlet UITextField *bookName;
@property (weak, nonatomic) IBOutlet UITextField *bookUrl;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end
