//
//  SampleCellView.m
//  HXFloatingSelectorView
//
//  Created by MacBook on 7/21/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "SampleCellView.h"
#import <Masonry.h>
@implementation SampleCellView

- (instancetype)initWithDataModel:(id)dataModel{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        UILabel *label = [UILabel new];
        label.text = dataModel;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
