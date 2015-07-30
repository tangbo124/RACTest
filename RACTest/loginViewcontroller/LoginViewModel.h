//
//  LoginViewModel.h
//  RACTest
//
//  Created by tangbo on 15/7/29.
//  Copyright (c) 2015年 tangbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
@class ViewController;
@interface LoginViewModel : NSObject
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, readonly) RACSignal *validUserNameSignal;
@property (nonatomic, readonly) RACSignal *validPasswordSignal;
//@property (nonatomic, readonly) RACSignal *loginRelSignal;
@property (nonatomic, readonly) RACSignal *ValidLoginBtnSignal;
@property (nonatomic, weak) ViewController *viewController;

- (RACSignal *)signSignal;

@end
