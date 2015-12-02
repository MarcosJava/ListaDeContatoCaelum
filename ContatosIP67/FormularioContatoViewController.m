//
//  ViewController.m
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 23/11/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import "FormularioContatoViewController.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/******************************************************************
 Modifica a criacao do objeto, pois nao será instanciado o metodo init.
 Pois eh a Storyboard que ativa essa classe
 ********************************************************************/

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        self.dao = [ContatoDao contatoDaoInstance];
        self.navigationItem.title = @"Cadastro";
        
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc] initWithTitle:@"Adicionar" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
        
        self.navigationItem.rightBarButtonItem = adiciona;
    }
    
    return self;
}

-(void) criaContato {
    [self pegaDadosDoFormulario];
    [self.dao adicionarContato:self.contato];
    
    [self.navigationController popViewControllerAnimated:YES]; //Atualiza a view
}

- (IBAction)pegaDadosDoFormulario{
    NSLog(@"Botao foi clicado");
    
    //DOT NOTATION
    self.contato = [Contatos new];
    self.contato.nome = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    
}

@end
