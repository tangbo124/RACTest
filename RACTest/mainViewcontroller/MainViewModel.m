//
//  MainViewModel.m
//  RACTest
//
//  Created by tangbo on 15/7/29.
//  Copyright (c) 2015年 tangbo. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 30; i ++) {
            [arr addObject:[NSString stringWithFormat:@"%i", i]];
        }
        _dataArray = [arr copy];
    }
    return self;
}

- (NSDictionary *)configDicWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *nameLabelStr = self.dataArray[indexPath.row];
    return @{@"nameLabel": nameLabelStr};
}

- (RACSignal *)didSelectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *nameLabelStr = self.dataArray[indexPath.row];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:nameLabelStr];
        [subscriber sendCompleted];
        return nil;
    }];
}
@end
