//
//  ContatoDao.h
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 01/12/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contatos.h"

@interface ContatoDao : NSObject

@property (strong, readonly) NSMutableArray *contatos;

-(void) adicionarContato:(Contatos *) contato;
+(id) contatoDaoInstance;

@end
