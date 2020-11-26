//
//  AView.m
//  TapGestureAndUITableView
//
//  Created by HaoCold on 2020/11/26.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "AView.h"

@interface AView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,  strong) UIView *backView;
@property (nonatomic,  strong) UIButton *backButton;
@property (nonatomic,  strong) UIView *contentView;
@property (nonatomic,  strong) UITableView *tableView;
@end

@implementation AView

#pragma mark -------------------------------------视图-------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    // 下面2个视图的事件，都能响应
    [self addSubview:self.backView];
    //[self addSubview:self.backButton];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
}

#pragma mark -------------------------------------事件-------------------------------------------

- (void)showInView:(UIView *)view
{
    self.alpha = 0;
    [view addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)tapActioin
{
    NSLog(@"backView tapActioin");
    
    [self hide];
}

- (void)buttonAction
{
    NSLog(@"backButton buttonAction");
    
    [self hide];
}

#pragma mark ---UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"resueID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行",@(indexPath.row)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"didSelectRowAtIndexPath");
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (UIView *)backView{
    if (!_backView) {
        UIView *view = [[UIView alloc] init];
        view.frame = self.bounds;
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActioin)]];
        _backView = view;
    }
    return _backView;
}

- (UIButton *)backButton{
    if (!_backButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        button.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:1<<6];
        _backButton = button;
    }
    return _backButton;
}

- (UIView *)contentView{
    if (!_contentView) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-300, CGRectGetWidth(self.bounds), 300);
        view.backgroundColor = [UIColor whiteColor];
        _contentView = view;
    }
    return _contentView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-150)*0.5, 20, 150, 200) style:0];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView = tableView;
    }
    return _tableView;
}

@end



