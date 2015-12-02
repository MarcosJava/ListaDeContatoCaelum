//
//  Contatos.m
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 27/11/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import "Contatos.h"

@implementation Contatos



/********************
    TO STRING do JAVA
 ************************/
-(NSString *)description {
    return [NSString stringWithFormat:@"Nome : %@, Telefone: %@, Email: %@, Endereco: %@, Site: %@",
            self.nome, self.telefone, self.email, self.endereco, self.site];
}

@end
