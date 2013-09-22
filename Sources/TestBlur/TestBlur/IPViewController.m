//
//  IPViewController.m
//  TestBlur
//
//  Created by Igor on 22.09.13.
//  Copyright (c) 2013 igorpro. All rights reserved.
//

#import "IPViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "FXBlurView.h"

@interface IPViewController () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UILabel *_placeholderLabel;
    IBOutlet UITableView *_tableView;
    UIView *_blurView;
    
    CADisplayLink *_link;
    CFTimeInterval _lastInterval;
    CFTimeInterval _secondCount;
    int _secondTicks;
    CFTimeInterval _totalCount;
    int _totalTicks;
}

@end

@implementation IPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _placeholderLabel.hidden = YES;
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(didTick:)];
    _lastInterval = CACurrentMediaTime();
    
    [self setupFXBlurView];
}

- (void)didTick:(id)sender
{
    CFTimeInterval delta = _link.timestamp - _lastInterval;
    
    
}

#pragma mark - Blur views

- (void)setupFXBlurView
{
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:_placeholderLabel.frame];
    _blurView = blurView;
    blurView.blurEnabled = YES;
    blurView.blurRadius = 10;
    blurView.tintColor = [UIColor clearColor];
    blurView.dynamic = YES;
    [self.view addSubview:blurView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = @"Some long text string bla-bla-bla one two three";
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Section some-number";
}

#pragma mark - UITableViewDelegate

@end
