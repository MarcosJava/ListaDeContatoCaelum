//
//  ContatoDao.m
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 01/12/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import "ContatoDao.h"

@implementation ContatoDao


/******************
 
 Implementando o Singleton
 ************************/

static ContatoDao *defaultDao = nil;

+(id) contatoDaoInstance {
    if(!defaultDao){
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}



/******************
 
 Construtor
 ************************/

-(id)init {
    self = [super init];
    if(self){
        _contatos = [NSMutableArray new];
    }
    return self;
}




-(void) adicionarContato:(Contatos *)contato {
    [self.contatos addObject:contato];
    NSLog(@"Contatos no DAO: %@", self.contatos);
}

@end
