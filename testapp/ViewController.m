//
//  ViewController.m
//  testapp
//
//  Created by Ralph Shane on 10/14/15.
//  Copyright © 2015 Ralph Shane. All rights reserved.
//

#import "ViewController.h"
#import "ColorProgressView.h"

@interface ViewController ()

@end

@implementation ViewController {
    __weak ColorProgressView *_progress;
    __weak ColorProgressView *_progress2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    ColorProgressView *progress = [[ColorProgressView alloc]
                                   initWithFrame:CGRectMake(18, 260, 284, 16)];
    [self.view addSubview:progress];
    _progress = progress;

    ColorProgressView *progress2 = [[ColorProgressView alloc]
                                   initWithFrame:CGRectMake(18, 300, 284, 16)];
    progress2.singleColor = YES;
    [self.view addSubview:progress2];
    _progress2 = progress2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChanged:(UISlider *)sender {
    _progress.progress = sender.value;
    _progress2.progress = sender.value;
}

@end
