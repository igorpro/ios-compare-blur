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
    IBOutlet UILabel *_fpsLabel;
    IBOutlet UITableView *_tableView;
    UIView *_blurView;
    
    CADisplayLink *_link;
    CFTimeInterval _lastInterval;
    CFTimeInterval _secondCount;
    int _secondTicks;
    CFTimeInterval _totalCount;
    int _totalTicks;
    UIImage *_thumbImage;
}

@end

@implementation IPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _placeholderLabel.hidden = YES;
    
    _thumbImage = [UIImage imageNamed:@"1.jpg"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(didTick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _lastInterval = _link.timestamp;
    
    _secondTicks = 0;
    _secondCount = 0;
    _totalCount = 0;
    _totalTicks = 0;
    
    [self setupFXBlurView];
}

- (void)didTick:(id)sender
{
    CFTimeInterval new = _link.timestamp;
    CFTimeInterval delta = new - _lastInterval;
    _lastInterval = new;
    
    _secondCount += delta;
    _secondTicks ++;
    
    _totalCount += delta;
    _totalTicks ++;
    
    if (_secondCount >= 0.25 || _secondTicks >= 15)
    {
        CGFloat fps = _secondTicks / _secondCount;
        
        _fpsLabel.text = [NSString stringWithFormat:@"FPS: %0.1f", fps];
        
        _secondTicks = 0;
        _secondCount = 0;
    }
}

#pragma mark - Blur views

- (void)setupFXBlurView
{
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:_placeholderLabel.frame];
    blurView.autoresizingMask = _placeholderLabel.autoresizingMask;
    _blurView = blurView;
    blurView.blurEnabled = YES;
    blurView.blurRadius = 10;
    blurView.tintColor = [UIColor clearColor];
    blurView.dynamic = !NO;
    [self.view addSubview:blurView];
}

- (void)stopBlurView
{
    [_blurView removeFromSuperview];
    _blurView = nil;
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
    
    cell.imageView.image = _thumbImage;
    cell.textLabel.text = @"Some long text string bla-bla-bla one two three";
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Section some-number";
}

#pragma mark - UITableViewDelegate

@end
