//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 01/12/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FormularioContatoViewController.h"
#import "ContatoDao.h"
#import "GerenciadorDeAcoes.h"

@interface ListaContatosViewController : UITableViewController <FormularioContatoViewControllerDelegate>

@property ContatoDao *dao;
@property Contatos *contatoSelecionado;
@property NSInteger linhaDestaque;

@property (readonly) GerenciadorDeAcoes *gerenciador;
-(void) exibirMaisAcoes: (UIGestureRecognizer *) gesture;

@end
