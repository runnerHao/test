//
//  ViewController.m
//  07scrollView封装
//
//  Created by 郝帅 on 16/1/28.
//  Copyright © 2016年 All rights reserved.
//

#import "ViewController.h"
#import "HSScrollImages.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HSScrollImages *scrollImages = [HSScrollImages scrollImages];
    scrollImages.imageNames = @[@"img_01",@"img_02",@"img_03",@"img_04"];
    scrollImages.frame = CGRectMake(20, 20, 350, 300);
    
    [self.view addSubview:scrollImages];
}

@end
