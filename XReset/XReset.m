//
//  XReset.m
//  XReset
//
//  Created by Christian H. Roman Mendoza on 7/23/15.
//  Copyright (c) 2015 Christian Roman. All rights reserved.
//

#import "XReset.h"
#import "DVTBezelAlertPanel.h"

@interface XReset()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation XReset

+ (instancetype)sharedPlugin {
  return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin {
  if (self = [super init]) {
    self.bundle = plugin;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didApplicationFinishLaunchingNotification:)
                                                 name:NSApplicationDidFinishLaunchingNotification
                                               object:nil];
  }
  return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification *)notification {
  //removeObserver
  [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
  
  // Create menu items, initialize UI, etc.
  NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
  if (menuItem) {
    [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Reset iOS Simulators Content and Settings..." action:@selector(promptResetSimulators) keyEquivalent:@""];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
  }
}

- (void)promptResetSimulators {
  NSAlert *alert = [NSAlert new];
  [alert addButtonWithTitle:@"Reset"];
  [alert addButtonWithTitle:@"Cancel"];
  [alert setMessageText:@"Are you sure you want to reset the iOS Simulators content and settings?"];
  [alert setInformativeText:@"All installed applications, content, and settings will be moved to trash."];
  [alert setAlertStyle:NSWarningAlertStyle];
  
  [alert beginSheetModalForWindow:[[NSApplication sharedApplication] keyWindow] completionHandler:^(NSModalResponse returnCode) {
    if (returnCode == NSAlertFirstButtonReturn) {
      [self resetSimulators];
    }
  }];
}

- (void)resetSimulators {
  NSString *launchPath = @"/usr/bin/xcrun";
  
  NSTask *shutdownTask = [NSTask new];
  shutdownTask.launchPath = launchPath;
  shutdownTask.arguments = @[@"simctl", @"shutdown", @"booted"];
  [shutdownTask launch];
  [shutdownTask waitUntilExit];
  
  NSTask *resetTask = [NSTask new];
  resetTask.launchPath = launchPath;
  resetTask.arguments = @[@"simctl", @"erase", @"all"];
  [resetTask launch];
  [resetTask waitUntilExit];
  
  NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.chroman.XReset"];
  NSImage *newImage = [bundle imageForResource:@"AlertImage"];
  id alertPanel = [[DVTBezelAlertPanel alloc] initWithIcon:newImage
                                                   message:@"Success!"
                                              parentWindow:nil
                                                  duration:2.0];
  [alertPanel orderFront:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
