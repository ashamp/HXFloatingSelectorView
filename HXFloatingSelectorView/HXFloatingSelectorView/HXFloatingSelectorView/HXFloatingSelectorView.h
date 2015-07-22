//
//  HXFloatingSelectorView.h
//  HXFloatingSelectorView
//
//  Created by MacBook on 7/21/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView*(^HXFloatingSelectorViewCellViewCreationBlock)(id dataModel);

typedef void(^HXFloatingSelectorViewCellDidSelectBlock)(id dataModel);

@interface HXFloatingSelectorView : UIControl

- (instancetype)initWithDataSource:(NSArray *)dataSource
             cellViewCreationBlock:(HXFloatingSelectorViewCellViewCreationBlock)creationBlock
                cellDidSelectBlock:(HXFloatingSelectorViewCellDidSelectBlock)cellDidSelectBlock;

@end
