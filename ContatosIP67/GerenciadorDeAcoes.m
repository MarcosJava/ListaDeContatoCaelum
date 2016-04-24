//
//  GerenciadorDeAcoes.m
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 10/01/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "GerenciadorDeAcoes.h"

@implementation GerenciadorDeAcoes

-(id) initWithContato:(Contatos *)contato {
    
    self = [super init];
    if (self) {
        self.contato = contato;
    }
    return self;
}

-(void)acoesDoController:(UIViewController *)controller {

    self.controller = controller;
    UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:self.contato.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar Email", @"Visualizar site", @"Abrir Mapa", nil];
    
    [opcoes showInView:controller.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostraMapa];
            break;
        default:
            break;
    }
    
}

-(void) abrirAplicativoComURL:(NSString *)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


-(void) ligar {
    UIDevice *device = [UIDevice currentDevice];
    
    if([device.model isEqualToString:@"Iphone"]){
        
        NSString *numero = [NSString stringWithFormat:@"tel:%@", self.contato.telefone];
        [self abrirAplicativoComURL:numero];
    } else {
        
        [[[UIAlertView alloc] initWithTitle:@"Impossível fazer ligação" message:@"Seu dispositivo nao é um iphone" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

-(void) abrirSite {
    NSString *url = self.contato.site;
    [self abrirAplicativoComURL:url];
}


-(void) mostraMapa {
    NSString *url = [NSString stringWithFormat:@"http://maps.apple.com/maps?q=%@", self.contato.endereco];
    [self abrirAplicativoComURL:url];
}

-(void) enviarEmail{
    
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *enviadorEmail = [MFMailComposeViewController new];
        enviadorEmail.mailComposeDelegate = self;
        [enviadorEmail setToRecipients:@[self.contato.email]];
        [enviadorEmail setSubject:@"Assunto"];
        
        [self.controller presentViewController:enviadorEmail animated:YES completion:nil];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Opss!"
                                                        message:@"Nao eh possivel enviar email"
                                                       delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil, nil];
        
        alert.show;
    }
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

@end
