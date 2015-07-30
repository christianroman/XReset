//
//  DVTBezelAlertPanel.h
//  XReset
//
//  Created by Christian H. Roman Mendoza on 7/25/15.
//  Copyright (c) 2015 Christian Roman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DVTBezelAlertPanel : NSPanel

- (void)orderFront:(id)arg1;
- (id)initWithIcon:(id)arg1 message:(id)arg2 controlView:(id)arg3 duration:(double)arg4;
- (id)initWithIcon:(id)arg1 message:(id)arg2 parentWindow:(id)arg3 duration:(double)arg4;

@end