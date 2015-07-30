//
//  LoginViewModel.m
//  RACTest
//
//  Created by tangbo on 15/7/29.
//  Copyright (c) 2015年 tangbo. All rights reserved.
//

#import "LoginViewModel.h"
#import "ViewController.h"
@implementation LoginViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        RACSignal *validUserNameSignal = [RACObserve(self, userName) map:^id(NSString *value) {
            @strongify(self);
            return @([self validateUserName:value]);
        }];
        RACSignal *validPasswordSignal = [RACObserve(self, password) map:^id(NSString *value) {
            @strongify(self);
            return @([self validatePassword:value]);
        }];
        _validUserNameSignal = [validUserNameSignal map:^id(NSNumber *validate) {
            return [validate boolValue]?[UIColor blueColor]:[UIColor redColor];
        }];
        _validPasswordSignal = [validPasswordSignal map:^id(NSNumber *validate) {
            return [validate boolValue]?[UIColor blueColor]:[UIColor redColor];
        }];
        RACSignal *btnEnabledSignal = [RACSignal combineLatest:@[validUserNameSignal, validPasswordSignal] reduce:^(NSNumber *userNameValid, NSNumber *passwordValid){
            BOOL rel = [userNameValid boolValue] && [passwordValid boolValue];
            return @(rel);
        }];
        
//        _loginCommand = [[RACCommand alloc] initWithEnabled:btnEnabledSignal signalBlock:^RACSignal *(id input) {
//            NSLog(@"点击");
//            @strongify(self);
//            if ([_userName isEqualToString:@"tangbo"] && [_password isEqualToString:@"111111"]) {
//                [self.viewController loginSuccess];
//            }
//            return [RACSignal empty];
//        }];
        _ValidLoginBtnSignal = [btnEnabledSignal map:^id(NSNumber *value) {
            BOOL rel = [value boolValue];
            return rel?[UIColor blueColor]:[UIColor redColor];
        }];
    }
    return self;
}

- (BOOL)validateUserName:(NSString *)userName
{
    return userName.length > 0;
}

- (BOOL)validatePassword:(NSString *)password
{
    return password.length > 0;
}

- (RACSignal *)signSignal
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        if ([self.userName isEqualToString:@"tangbo"] && [self.password isEqualToString:@"111111"]) {
            [subscriber sendNext:@(YES)];
            [subscriber sendCompleted];
        } else {
            [subscriber sendNext:@(NO)];
            [subscriber sendCompleted];
        }
        return nil;
    }];
}
@end
