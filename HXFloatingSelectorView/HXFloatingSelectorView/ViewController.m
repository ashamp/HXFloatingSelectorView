//
//  ViewController.m
//  HXFloatingSelectorView
//
//  Created by MacBook on 7/21/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "ViewController.h"

#import "HXFloatingSelectorView.h"

#import "SampleCellView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *dataSource = @[ @"数据1",@"数据2",@"数据3",@"数据4",@"数据5",@"数据6",];
    HXFloatingSelectorView *floatingSelectorView = [[HXFloatingSelectorView alloc]initWithDataSource:dataSource cellViewCreationBlock:^UIView *(id dataModel) {
        SampleCellView *cell = [[SampleCellView alloc] initWithDataModel:dataModel];
        return cell;
    } cellDidSelectBlock:^(id dataModel) {
        NSLog(@"%@",dataModel);
    }];
    
    floatingSelectorView.frame = CGRectMake(100, 100, 200, 30);
    [self.view addSubview:floatingSelectorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
