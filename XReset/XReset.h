//
//  XReset.h
//  XReset
//
//  Created by Christian H. Roman Mendoza on 7/23/15.
//  Copyright (c) 2015 Christian Roman. All rights reserved.
//

#import <AppKit/AppKit.h>

@class XReset;

static XReset *sharedPlugin;

@interface XReset : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end