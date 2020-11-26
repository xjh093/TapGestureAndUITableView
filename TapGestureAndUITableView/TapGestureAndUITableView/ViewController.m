//
//  ViewController.m
//  TapGestureAndUITableView
//
//  Created by HaoCold on 2020/11/26.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "AView.h"

/* 层级结构
 ViewController
 |---view (UIView)                     添加了点击手势
     |---AView (UIView)                未添加
          |----backView (UIView)       添加了点击手势
          |----backButton (UIButton)   添加了Target-Action
          |----contentView (UIView)    未添加
          |----tableView (UITableView) 未添加
 
 问题：
 点击 contentView 和 tableViewcell
 最顶层的 view 会响应事件
 
 */

@interface ViewController ()
@property (nonatomic,  strong) AView *aview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)]];
    
    [self setupViews];
}

- (void)setupViews
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.backgroundColor = [UIColor lightGrayColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"弹出" forState:0];
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:1<<6];
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)didTap
{
    NSLog(@"------点击事件响应");
}

- (void)buttonAction
{
    NSLog(@"按钮事件响应");
    
    [self.aview showInView:self.view];
    
    // 解决方案
    //[self.aview showInView:self.view.window];
}

- (AView *)aview{
    if (!_aview) {
        _aview = [[AView alloc] initWithFrame:self.view.bounds];
    }
    return _aview;
}


@end
