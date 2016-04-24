//
//  AppDelegate.h
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 23/11/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ContatoDao.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property ContatoDao *dao;



@end

