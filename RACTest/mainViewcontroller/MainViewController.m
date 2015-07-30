//
//  MainViewController.m
//  RACTest
//
//  Created by tangbo on 15/7/29.
//  Copyright (c) 2015年 tangbo. All rights reserved.
//

#import "MainViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <Masonry/Masonry.h>
#import "MainViewModel.h"
#import "MyTableViewCell.h"

static NSString *reuseCell = @"cell";

@interface MainViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MainViewModel *viewModel;
@property (nonatomic, strong) UILabel *label;
@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _viewModel = [MainViewModel new];
        _viewModel.viewController = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    _label = [UILabel new];
    _label.backgroundColor = [UIColor blueColor];
    _label.textColor = [UIColor whiteColor];
    [self.view addSubview:_label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"消失" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    @weakify(self);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:btn];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:reuseCell];
    [self.view addSubview:_tableView];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-10);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(66, 0, 0, 0));
    }];
}

#pragma - mark - UITableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    NSDictionary *modelDic = [self.viewModel configDicWithIndexPath:indexPath];
    cell.nameLabel.text = [modelDic objectForKey:@"nameLabel"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RACSignal *selectedSignal = [self.viewModel didSelectedRowAtIndexPath:indexPath];
    RAC(self.label, text) = selectedSignal;
    /*
     *等同于RAC(self.label, text) = selectedSignal;
     *
    [selectedSignal subscribeNext:^(id x) {
        _label.text = x;
    }];
     */
}

- (void)dealloc
{
    NSLog(@"main vc dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
