//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 01/12/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import "ListaContatosViewController.h"

@implementation ListaContatosViewController


-(id) init{
    self = [super init];
    if(self){
        
        self.navigationItem.title = @"Contatos";
        
        // Cria o botao na navegacao
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
        
        //Coloca o botao no navegation view
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
    }
    return self;
}

-(void) exibeFormulario {
    
    NSLog(@"Aqui nos iremos exibir o formulario");
    //[self exibirAlert:@"Atencao" eComMensagem:@"Exibira um Formulario"];
    
    //Instancia a StoryBoard Main
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Instancia o form com a storyboard que tenha o ID Storyboard Form-Contato
    FormularioContatoViewController *form = [storyboard instantiateViewControllerWithIdentifier:@"Form-Contato"];
    
    //Inicia o form na Storyboard
    [self.navigationController pushViewController:form animated:YES];
}



-(void) exibirAlert:(NSString*) titulo eComMensagem:(NSString *) mensagem {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:titulo
                                                                   message:mensagem
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
