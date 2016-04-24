//
//  ViewController.h
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 23/11/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Contatos.h"
#import "ContatoDao.h"

@protocol FormularioContatoViewControllerDelegate <NSObject>
    @required
    -(void) contatoAtualizado: (Contatos *) contato;
    -(void) contatoAdicionado: (Contatos *) contato;
//    @optional

@end

@interface FormularioContatoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (strong) ContatoDao *dao;
@property (strong) Contatos *contato;
@property (weak) id<FormularioContatoViewControllerDelegate> delegate;

- (IBAction)selecionarFoto:(id)sender;
@property IBOutlet UITextField *nome;
@property IBOutlet UITextField *telefone;
@property IBOutlet UITextField *email;
@property IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property (weak, nonatomic) IBOutlet UIButton *botaoMapa;
@property IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;
- (IBAction)buscaCoordenadas:(id)sender;

@end

