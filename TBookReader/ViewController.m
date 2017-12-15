//
//  PrefixHeader.pch
//  TBookReader
//
//  Created by Sean on 2017/12/14.
//  Copyright © 2017年 Tany. All rights reserved.
//

#import "ViewController.h"
#import "TReaderViewController.h"
#import <AVOSCloud.h>
#import "BookTableViewCell.h"
#import <MBProgressHUD.h>
#import "AddBookView.h"
#import "UIView+NIB.h"
#import "UIView+Hidden.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *HUD;
    UIView * mask;
}
@property (strong, nonatomic) UITableView * table;
@property (strong, nonatomic) NSArray * dataSource;
@property (strong, nonatomic) AddBookView * addBook;
@end
static NSString * CellID = @"CellID";
@implementation ViewController
- (void)loadBunble
{
}
- (void)getDataSource
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = @"加载中 ... ";
    
    AVQuery *query = [AVQuery queryWithClassName:@"book"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [HUD hideAnimated:YES];
            self.dataSource = objects;
            [self.table reloadData];
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                HUD.label.text = error.localizedDescription;
                [HUD hideAnimated:YES afterDelay:1.5];
            });
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.table];
    [self loadBunble];
    [self getDataSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AVObject * obj = self.dataSource[indexPath.row];
    BookTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (self.dataSource.count > 0) {
        cell.model = obj;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TReaderViewController *VC = [[TReaderViewController alloc]init];
    VC.model = self.dataSource[indexPath.row];
    if ([XXTools fileExistsBook:[VC.model objectForKey:@"name"]]) {
        [self.navigationController pushViewController:VC animated:YES];
    }else
    {
        HUD = [MBProgressHUD showHUDAddedTo:self.table animated:YES];
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = @"没有下载这本书噢";
        [HUD hideAnimated:YES afterDelay:1.5];
    }
}
- (void)hideAddBookView
{
    [self.addBook.superview removeFromSuperview];
}
- (IBAction)addBook:(UIBarButtonItem *)sender {
    
    mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mask.backgroundColor = [UIColor darkGrayColor];
    mask.alpha = 0.66;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAddBookView)];
    [mask addGestureRecognizer:tap];
    if (![mask.subviews containsObject:self.addBook]) {
        self.addBook = [AddBookView createViewFromNib];
        [self.view addSubview:mask];
        [mask addSubview:self.addBook];
    }
    self.addBook.frame = CGRectMake(-100, -100, SCREEN_WIDTH+200, SCREEN_HEIGHT+200);
    self.addBook.alpha = 0;
    self.addBook.layer.cornerRadius = 2;
    self.addBook.clipsToBounds = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.addBook.alpha = 0.5;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.addBook.frame = CGRectMake(0, 0, 300, 190);
            self.addBook.alpha = 1;
            self.addBook.center = self.view.center;
        }];
    }];
}

- (UITableView *)table
{
    if (!_table) {
        _table =  [[UITableView alloc]initWithFrame:SCREEN_BOUNDS];
        _table.dataSource = self;
        _table.delegate = self;
        _table.rowHeight = 46;
        _table.tableFooterView = [UIView new];
        [_table registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    }
    return _table;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
