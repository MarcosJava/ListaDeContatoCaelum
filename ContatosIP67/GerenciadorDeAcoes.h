//
//  GerenciadorDeAcoes.h
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 10/01/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Contatos.h"
@interface GerenciadorDeAcoes : NSObject <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property Contatos *contato;
@property UIViewController *controller;

-(id) initWithContato:(Contatos *)contato;
-(void) acoesDoController:(UIViewController *)controller;
@end
