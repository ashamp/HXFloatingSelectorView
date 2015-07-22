//
//  HXFloatingSelectorView.m
//  HXFloatingSelectorView
//
//  Created by MacBook on 7/21/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "HXFloatingSelectorView.h"
#import <Masonry.h>
#import <UIView+JWMasonryConstraint.h>

@interface CellCoverButton : UIButton
@property (nonatomic,assign)NSInteger index;
@end

@implementation CellCoverButton
@end


@interface HXFloatingSelectorView ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,copy)HXFloatingSelectorViewCellViewCreationBlock creationBlock;
@property (nonatomic,copy)HXFloatingSelectorViewCellDidSelectBlock cellDidSelectBlock;
@property (nonatomic,strong)UIView *firstView;
@property (nonatomic,strong)UIImageView *arrowImageView;//箭头
@property (nonatomic,strong)UIView *bottomLineView;
@property (nonatomic,strong)UIView *floatSelectorContainerView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIButton *coverButton;
@end

@implementation HXFloatingSelectorView

- (instancetype)initWithDataSource:(NSArray *)dataSource
             cellViewCreationBlock:(HXFloatingSelectorViewCellViewCreationBlock)creationBlock
                cellDidSelectBlock:(HXFloatingSelectorViewCellDidSelectBlock)cellDidSelectBlock{
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        self.creationBlock = creationBlock;
        self.cellDidSelectBlock = cellDidSelectBlock;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    //生成自身视图
    id dataModel = [self.dataSource firstObject];
    UIView *firstView = self.creationBlock(dataModel);
    self.firstView = firstView;
    [self addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(firstView.superview);
    }];
    
    //箭头
    UIImageView *arrowImageView=[UIImageView new];
    self.arrowImageView=arrowImageView;
    [arrowImageView setImage:[UIImage imageNamed:@"CbbArrow"]];
    [arrowImageView setHighlightedImage:[UIImage imageNamed:@"CbbArrowUp"]];
    [firstView addSubview:arrowImageView];
    //约束,位于控件右侧偏左,垂直居中
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(arrowImageView.image.size);
        make.centerY.equalTo(arrowImageView.superview.mas_centerY);
        make.right.equalTo(arrowImageView.superview).offset(-10);
    }];

    //底边线
    UIView *bottomLineView =[UIView new];
    self.bottomLineView = bottomLineView;
    bottomLineView.backgroundColor = [UIColor orangeColor];
    [self addSubview:bottomLineView];
    //约束,位于底边
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(6);
        make.right.equalTo(self).offset(-8);
        make.height.equalTo(@1);
    }];
    
    //生成滚动选择视图
    UIView *floatSelectorContainerView = [UIView new];
    floatSelectorContainerView.backgroundColor = [UIColor whiteColor];
    self.floatSelectorContainerView = floatSelectorContainerView;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [floatSelectorContainerView addGestureRecognizer:tapGesture];
    
    UIScrollView *scrollView = [UIScrollView new];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [scrollView addGestureRecognizer:tapGesture1];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView = scrollView;
    
    [floatSelectorContainerView addSubview:scrollView];
    
    //生成cells
    NSMutableArray *views = [NSMutableArray new];
    for (NSInteger index = 1; index < self.dataSource.count; index++) {
        id dataModel = self.dataSource[index];
        UIView *cell = self.creationBlock(dataModel);
        //为cell增加点击按钮
        CellCoverButton *cellCoverButton = [CellCoverButton new];
        cellCoverButton.index = index;
        [cellCoverButton jw_makeCoverOnView:cell];
        
        [cellCoverButton addTarget:self action:@selector(cellDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        [views addObject:cell];
    }
    
    UIView *cellsContainerView = [UIView new];
    [scrollView addSubview:cellsContainerView];
    [cellsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(cellsContainerView.superview);
        make.height.equalTo(@(30*views.count));
    }];

    [cellsContainerView makeEqualHeightViews:views];
}

#pragma mark - Target

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesEnded");
    [self show];
}

- (void)show{
    //显示时,将firstView add到floatSelectorContainerView上,
    
    //取相对屏幕位置
    CGRect frame = [self convertRect:self.bounds toView:nil];
    self.floatSelectorContainerView.frame = CGRectMake(frame.origin.x, frame.origin.y , frame.size.width, 30*3 + frame.size.height);
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    [self.coverButton jw_makeCoverOnView:window];
    
    [window addSubview:self.floatSelectorContainerView];
    //加阴影
    [self setupShadowInLeftRightBottom:self.floatSelectorContainerView];
    
    [self.floatSelectorContainerView addSubview:self.firstView];
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.firstView.superview);
        make.height.equalTo(@30);
    }];
    self.arrowImageView.highlighted = YES;
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.scrollView.superview);
        make.top.equalTo(self.firstView.mas_bottom);
    }];
}

- (void)hide{
    //隐藏时,将firstView归位
    
    self.arrowImageView.highlighted = NO;
    [self.firstView jw_makeCoverOnView:self];
    [self bringSubviewToFront:self.bottomLineView];

    //从屏幕移除
    [self clearShadow:self.floatSelectorContainerView];
    [self.floatSelectorContainerView removeFromSuperview];
    [self.coverButton removeFromSuperview];
}

- (IBAction)cellDidSelect:(id)sender{
    if ([sender isKindOfClass:[CellCoverButton class]]) {
        NSInteger index = ((CellCoverButton *)sender).index;
        id dataModel = self.dataSource[index];
        self.cellDidSelectBlock(dataModel);
    }
}

#pragma mark - Private

#pragma mark - Shadow

/**
 *  给一个视图的左右下3面设置阴影
 *
 *  @param view 要加3面阴影的视图
 */
-(void)setupShadowInLeftRightBottom:(UIView *)view{
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 2;
    view.layer.shadowOpacity = 0.7;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // Start at the Top Left Corner上左
    [path moveToPoint:CGPointMake(0.0, 1.0)];
    
    // Move to the Bottom Left Corner//下左
    [path addLineToPoint:CGPointMake(0.0, CGRectGetHeight(view.frame))];
    
    // Move to the Bottom Right Corner下右
    [path addLineToPoint:CGPointMake(CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    
    // Move to the Top Right Corner上右
    [path addLineToPoint:CGPointMake(CGRectGetWidth(view.frame), 1.0)];
    
    
    // This is the extra point in the middle :) Its the secret sauce.中点
    [path addLineToPoint:CGPointMake(CGRectGetWidth(view.frame) / 2.0, CGRectGetHeight(view.frame) / 2.0)];
    
    
    // Move to the Close the Path
    [path closePath];
    
    view.layer.shadowPath = path.CGPath;
}

/**
 *  给一个视图的左右上3面设置阴影
 *
 *  @param view 要加3面阴影的视图
 */
-(void)setupShadowInLeftRightTop:(UIView *)view{
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 2;
    view.layer.shadowOpacity = 0.7;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // Start at the Top Left Corner上左
    [path moveToPoint:CGPointMake(0.0, 0.0)];
    
    // Move to the Top Right Corner上右
    [path addLineToPoint:CGPointMake(CGRectGetWidth(view.frame), 0.0)];
    
    // Move to the Bottom Right Corner下右
    [path addLineToPoint:CGPointMake(CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)-1)];
    
    // This is the extra point in the middle :) Its the secret sauce.中点
    [path addLineToPoint:CGPointMake(CGRectGetWidth(view.frame) / 2.0, CGRectGetHeight(view.frame) / 2.0)];
    
    // Move to the Bottom Left Corner//下左
    [path addLineToPoint:CGPointMake(0.0, CGRectGetHeight(view.frame)-1)];
    
    // Move to the Close the Path
    [path closePath];
    
    view.layer.shadowPath = path.CGPath;
}

-(void)clearShadow:(UIView *)view{
    [[view layer] setShadowOpacity:0.0];
    [[view layer] setShadowRadius:0.0];
    [[view layer] setShadowColor:nil];
}

#pragma mark - Getter Setter

- (UIButton *)coverButton{
    if (!_coverButton) {
        _coverButton = [UIButton new];
        [_coverButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

