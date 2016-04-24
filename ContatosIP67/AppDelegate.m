//
//  AppDelegate.m
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 23/11/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import "AppDelegate.h"
#import "ListaContatosViewController.h"
#import "ContatosNoMapaViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.dao = [ContatoDao contatoDaoInstance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    /*
     Cria as instancias dos controles que teram navegacoes
     */
    
    ListaContatosViewController *listaContatos = [ListaContatosViewController new];
    
    ContatosNoMapaViewController *contatosMapa = [ContatosNoMapaViewController new];
    
    /*
        Cria uma Navigation Controller para cada Controller <Barrinha de cima>
     */
    UINavigationController *navListaContatos = [[UINavigationController alloc] initWithRootViewController:listaContatos];
    
    UINavigationController *navContatosMapa = [[UINavigationController alloc] initWithRootViewController:contatosMapa];
    
    /*
     Cria uma Tab Bar e adiciona os Navigation Controller nela, <Barrinha de baixo>
     */
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.viewControllers = @[navListaContatos, navContatosMapa];
    
    
    /*
        Adiciona a Tab Bar na view e a coloca visivel. (o controller que aparece eh o primeiro do Tab Bar navListaContatos)
     */
    self.window.rootViewController = tabBarController; //informa o start
    
    [self.window makeKeyAndVisible]; //Coloca-o Visivel
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [self.dao saveContext];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    //[self saveContext];
}


@end
