//
//  AppDelegate.h
//  Service_App
//
//  Created by Ocs Dev on 08/02/17.
//  Copyright © 2017 Ocs Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentStore *persistentContainer;

- (void)saveContext;


@end

