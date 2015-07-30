//
//  ViewController.m
//  RACTest
//
//  Created by tangbo on 15/7/29.
//  Copyright (c) 2015年 tangbo. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <Masonry/Masonry.h>
#import "MainViewController.h"
#import "LoginViewModel.h"
@interface ViewController ()
@property (nonatomic, strong) LoginViewModel *viewModel;
@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _viewModel = [LoginViewModel new];
        _viewModel.viewController = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    UITextField *userNameTextField = [UITextField new];
    RAC(self.viewModel, userName) = userNameTextField.rac_textSignal;
    RAC(userNameTextField, backgroundColor) = self.viewModel.validUserNameSignal;
    [self.view addSubview:userNameTextField];
    
    UITextField *passwordTextField = [UITextField new];
    RAC(self.viewModel, password) = passwordTextField.rac_textSignal;
    RAC(passwordTextField, backgroundColor) = self.viewModel.validPasswordSignal;
    [self.view addSubview:passwordTextField];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
//    loginBtn.rac_command = self.viewModel.loginCommand;
    
    RAC(loginBtn, backgroundColor) = self.viewModel.ValidLoginBtnSignal;
    [self.view addSubview:loginBtn];
    
    UILabel *loginRelLabel = [UILabel new];
    loginRelLabel.textColor = [UIColor whiteColor];
    loginRelLabel.backgroundColor = [UIColor redColor];
    loginRelLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loginRelLabel];
    
    [[[[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        loginRelLabel.alpha = 1;
    }] flattenMap:^RACStream *(id value) {
        @strongify(self);
        return [self.viewModel signSignal];
    }] subscribeNext:^(NSNumber *loginRel) {
        @strongify(self);
        BOOL rel = [loginRel boolValue];
        if (rel) {
            loginRelLabel.text = @"登录成功";
            [self loginSuccess];
        } else {
            loginRelLabel.text = @"登录失败";
        }
        [UIView animateWithDuration:2.0f animations:^{
            loginRelLabel.alpha = 0.0f;
        }];
    }];
    
    [userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
    
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userNameTextField.mas_bottom).offset(10);
        make.left.equalTo(userNameTextField.mas_left);
        make.right.equalTo(userNameTextField.mas_right);
        make.height.equalTo(userNameTextField.mas_height);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordTextField.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [loginRelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(30);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
}

- (void)loginSuccess
{
    MainViewController *vc = [[MainViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
