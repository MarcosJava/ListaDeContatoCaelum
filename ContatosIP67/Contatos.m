//
//  Contatos.m
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 27/11/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import "Contatos.h"

@implementation Contatos

@dynamic nome, telefone, email, endereco, site, latitude, longitude, foto;

-(CLLocationCoordinate2D)coordinate{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}


//Colocando Titulo no Pin do Mapa
- (NSString *) title {
    return self.nome;
}


//Colocando Subtitulo no Pin do Mapa
-(NSString *) subtitle {
    return self.email;
}


/********************
    TO STRING do JAVA
 ************************/
-(NSString *)description {
    return [NSString stringWithFormat:@"Nome : %@, Telefone: %@, Email: %@, Endereco: %@, Site: %@",
            self.nome, self.telefone, self.email, self.endereco, self.site];
}

@end
