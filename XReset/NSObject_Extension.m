//
//  NSObject_Extension.m
//  XReset
//
//  Created by Christian H. Roman Mendoza on 7/23/15.
//  Copyright (c) 2015 Christian Roman. All rights reserved.
//


#import "NSObject_Extension.h"
#import "XReset.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
  static dispatch_once_t onceToken;
  NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
  if ([currentApplicationName isEqual:@"Xcode"]) {
    dispatch_once(&onceToken, ^{
      sharedPlugin = [[XReset alloc] initWithBundle:plugin];
    });
  }
}
@end
