/*
 The MIT License
 
 Copyright (c) 2009 Free Time Studios and Nathan Eror
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

#import "StyleProperties.h"


@implementation StyleProperties

+ (NSString *)friendlyName {
  return @"Style Properties";
}

#pragma mark init and dealloc

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    self.title = [[self class] friendlyName];
  }
  return self;
}

- (void)dealloc {
  [simpleLayer_ release], simpleLayer_ = nil;
  [maskLayer_ release], maskLayer_ = nil;
  [roundCornersButton_ release], roundCornersButton_ = nil;
  [toggleBorderButton_ release], toggleBorderButton_ = nil;
  [toggleOpacityButton_ release], toggleOpacityButton_ = nil;
  [toggleMaskButton_ release], toggleMaskButton_ = nil;
  [super dealloc];
}

#pragma mark Load and unload the view

- (void)loadView {
  UIView *myView = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  myView.backgroundColor = [UIColor whiteColor];
  
  roundCornersButton_ = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
  roundCornersButton_.frame = CGRectMake(10., 10., 145., 44.);
  [roundCornersButton_ setTitle:@"Round Corners" forState:UIControlStateNormal];
  [roundCornersButton_ addTarget:self action:@selector(roundCorners:) forControlEvents:UIControlEventTouchUpInside];
  [myView addSubview:roundCornersButton_];

  toggleBorderButton_ = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
  toggleBorderButton_.frame = CGRectMake(165., 10., 145., 44.);
  [toggleBorderButton_ setTitle:@"Toggle Border" forState:UIControlStateNormal];
  [toggleBorderButton_ addTarget:self action:@selector(toggleBorder:) forControlEvents:UIControlEventTouchUpInside];
  [myView addSubview:toggleBorderButton_];

  toggleOpacityButton_ = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
  toggleOpacityButton_.frame = CGRectMake(10., 60., 145., 44.);
  [toggleOpacityButton_ setTitle:@"Toggle Opacity" forState:UIControlStateNormal];
  [toggleOpacityButton_ addTarget:self action:@selector(toggleOpacity:) forControlEvents:UIControlEventTouchUpInside];
  [myView addSubview:toggleOpacityButton_];
  
  toggleMaskButton_ = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
  toggleMaskButton_.frame = CGRectMake(165., 60., 145., 44.);
  [toggleMaskButton_ setTitle:@"Toggle Mask Layer" forState:UIControlStateNormal];
  [toggleMaskButton_ addTarget:self action:@selector(toggleMaskLayer:) forControlEvents:UIControlEventTouchUpInside];
  [myView addSubview:toggleMaskButton_];
  
  simpleLayer_ = [[CALayer layer] retain];
  maskLayer_ = [[CALayer layer] retain];
  [myView.layer addSublayer:simpleLayer_];
  self.view = myView;
}

#pragma mark View drawing

- (void)viewWillAppear:(BOOL)animated {
  simpleLayer_.backgroundColor = [[UIColor greenColor] CGColor];
  simpleLayer_.bounds = CGRectMake(0., 0., 200., 200.);
  simpleLayer_.position = CGPointMake(160., 250.);
  [simpleLayer_ setNeedsDisplay];
  
  maskLayer_.bounds = simpleLayer_.bounds;
  maskLayer_.anchorPoint = CGPointZero;
  maskLayer_.contents = (id)[[UIImage imageNamed:@"StarMask.png"] CGImage];
}

- (void)viewWillDisappear:(BOOL)animated {
}

#pragma mark Event Handlers

- (void)roundCorners:(id)sender {
  if(simpleLayer_.cornerRadius > 0.) {
    simpleLayer_.cornerRadius = 0.;
  } else {
    simpleLayer_.cornerRadius = 25.;
  }
}

- (void)toggleBorder:(id)sender {
  if(simpleLayer_.borderWidth > 0.) {
    simpleLayer_.borderWidth = 0.;
  } else {
    simpleLayer_.borderWidth = 4.;
    simpleLayer_.borderColor = [[UIColor redColor] CGColor];
  }
}

- (void)toggleOpacity:(id)sender {
  if(simpleLayer_.opacity < 1.) {
    simpleLayer_.opacity = 1.;
  } else {
    simpleLayer_.opacity = .25;
  }
}

- (void)toggleMaskLayer:(id)sender {
  CALayer *mask = (simpleLayer_.mask == nil) ? maskLayer_ : nil;
  [simpleLayer_ removeFromSuperlayer];
  simpleLayer_.mask = mask;
  [self.view.layer addSublayer:simpleLayer_];
}

@end
