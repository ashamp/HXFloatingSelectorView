//
//  UIView+JWMasonryConstraint.m
//  JWMasonryConstraint
//
//  Created by 谢俊伟 on 6/18/15.
//  Copyright (c) 2015 XieJunwei. All rights reserved.
//

#import "UIView+JWMasonryConstraint.h"
#import <Masonry.h>
@implementation UIView (JWEqualWidthConstraint)

-(void)makeEqualWidthViews:(NSArray *)views{
    [self makeEqualWidthViews:views
                  LeftPadding:0
                 RightPadding:0
                   TopPadding:0
                BottomPadding:0
                  viewPadding:0];
}

-(void)makeEqualWidthViews:(NSArray *)views
                 LRpadding:(CGFloat)LRpadding{
    [self makeEqualWidthViews:views
                  LeftPadding:LRpadding
                 RightPadding:LRpadding
                   TopPadding:0
                BottomPadding:0
                  viewPadding:0];
}

-(void)makeEqualWidthViews:(NSArray *)views
                 TBpadding:(CGFloat)TBpadding{
    [self makeEqualWidthViews:views
                  LeftPadding:0
                 RightPadding:0
                   TopPadding:TBpadding
                BottomPadding:TBpadding
                  viewPadding:0];
}

-(void)makeEqualWidthViews:(NSArray *)views
              viewPadding :(CGFloat)viewPadding{
    [self makeEqualWidthViews:views
                  LeftPadding:0
                 RightPadding:0
                   TopPadding:0
                BottomPadding:0
                  viewPadding:viewPadding];
}

-(void)makeEqualWidthViews:(NSArray *)views
                 LRpadding:(CGFloat)LRpadding
              viewPadding :(CGFloat)viewPadding{
    [self makeEqualWidthViews:views
                  LeftPadding:LRpadding
                 RightPadding:LRpadding
                   TopPadding:0
                BottomPadding:0
                  viewPadding:viewPadding];
}

-(void)makeEqualWidthViews:(NSArray *)views
                 LRpadding:(CGFloat)LRpadding
                 TBpadding:(CGFloat)TBpadding
              viewPadding :(CGFloat)viewPadding{
    [self makeEqualWidthViews:views
                  LeftPadding:LRpadding
                 RightPadding:LRpadding
                   TopPadding:TBpadding
                BottomPadding:TBpadding
                  viewPadding:viewPadding];
}

-(void)makeEqualWidthViews:(NSArray *)views
               LeftPadding:(CGFloat)leftPadding
              RightPadding:(CGFloat)rightPadding
                TopPadding:(CGFloat)topPadding
             BottomPadding:(CGFloat)bottomPadding
              viewPadding :(CGFloat)viewPadding{
    UIView *lastView;
    for (UIView *view in views) {
        [self addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(lastView);
                make.left.greaterThanOrEqualTo(lastView.mas_right).offset(viewPadding);
                make.left.equalTo(lastView.mas_right).offset(viewPadding).priority(999);//用于防止宽度过小时的约束错误
                make.width.equalTo(lastView);
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(self).insets(UIEdgeInsetsMake(topPadding, leftPadding, bottomPadding, rightPadding));
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.greaterThanOrEqualTo(self).offset(-rightPadding);
        make.right.equalTo(self).offset(-rightPadding).priority(999);
    }];
}

+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end

@implementation UIView (JWEqualHeightConstraint)

-(void)makeEqualHeightViews:(NSArray *)views{
    [self makeEqualHeightViews:views
                   LeftPadding:0
                  RightPadding:0
                    TopPadding:0
                 BottomPadding:0
                   viewPadding:0];
}

-(void)makeEqualHeightViews:(NSArray *)views
                  LRpadding:(CGFloat)LRpadding{
    [self makeEqualHeightViews:views
                   LeftPadding:LRpadding
                  RightPadding:LRpadding
                    TopPadding:0
                 BottomPadding:0
                   viewPadding:0];
}

-(void)makeEqualHeightViews:(NSArray *)views
                  TBpadding:(CGFloat)TBpadding{
    [self makeEqualHeightViews:views
                   LeftPadding:0
                  RightPadding:0
                    TopPadding:TBpadding
                 BottomPadding:TBpadding
                   viewPadding:0];
}

-(void)makeEqualHeightViews:(NSArray *)views
               viewPadding :(CGFloat)viewPadding{
    [self makeEqualHeightViews:views
                   LeftPadding:0
                  RightPadding:0
                    TopPadding:0
                 BottomPadding:0
                   viewPadding:viewPadding];
}

-(void)makeEqualHeightViews:(NSArray *)views
                  LRpadding:(CGFloat)LRpadding
               viewPadding :(CGFloat)viewPadding{
    [self makeEqualHeightViews:views
                   LeftPadding:LRpadding
                  RightPadding:LRpadding
                    TopPadding:0
                 BottomPadding:0
                   viewPadding:viewPadding];
}

-(void)makeEqualHeightViews:(NSArray *)views
                  LRpadding:(CGFloat)LRpadding
                  TBpadding:(CGFloat)TBpadding
               viewPadding :(CGFloat)viewPadding{
    [self makeEqualHeightViews:views
                   LeftPadding:LRpadding
                  RightPadding:LRpadding
                    TopPadding:TBpadding
                 BottomPadding:TBpadding
                   viewPadding:viewPadding];
}

-(void)makeEqualHeightViews:(NSArray *)views
                LeftPadding:(CGFloat)leftPadding
               RightPadding:(CGFloat)rightPadding
                 TopPadding:(CGFloat)topPadding
              BottomPadding:(CGFloat)bottomPadding
                viewPadding:(CGFloat)viewPadding{
    UIView *lastView;
    for (UIView *view in views) {
        [self addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(lastView);
                make.top.greaterThanOrEqualTo(lastView.mas_bottom).offset(viewPadding);
                make.top.equalTo(lastView.mas_bottom).offset(viewPadding).priority(999);//用于防止高度过小时的约束错误
                make.height.equalTo(lastView);
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(self).insets(UIEdgeInsetsMake(topPadding, leftPadding, bottomPadding, rightPadding));
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(self).offset(-bottomPadding);
        make.bottom.equalTo(self).offset(-bottomPadding).priority(999);
    }];
}

@end


@implementation UIView (JWCoverConstraint)

- (void)jw_makeCoverOnView:(UIView *)superView{
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}

@end
