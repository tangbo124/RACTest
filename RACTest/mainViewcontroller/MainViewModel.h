//
//  MainViewModel.h
//  RACTest
//
//  Created by tangbo on 15/7/29.
//  Copyright (c) 2015年 tangbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
@class MainViewController;
@interface MainViewModel : NSObject
@property (nonatomic, strong) NSArray *dataArray;
@property(nonatomic, weak) MainViewController *viewController;
@property(nonatomic, readonly) RACSignal *selectedCellSignal;
- (NSDictionary *)configDicWithIndexPath:(NSIndexPath *)indexPath;
- (RACSignal *)didSelectedRowAtIndexPath:(NSIndexPath *)indexPath;
@end
