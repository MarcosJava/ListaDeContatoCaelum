//
//  ViewController.h
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 23/11/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contatos.h"
#import "ContatoDao.h"

@interface FormularioContatoViewController : UIViewController

@property (strong) ContatoDao *dao;
@property (strong) Contatos *contato;

@property IBOutlet UITextField *nome;
@property IBOutlet UITextField *telefone;
@property IBOutlet UITextField *email;
@property IBOutlet UITextField *endereco;
@property IBOutlet UITextField *site;

@end

