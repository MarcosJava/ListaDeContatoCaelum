//
//  ContatoDao.h
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 01/12/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Contatos.h"

@interface ContatoDao : NSObject



@property (strong, readonly) NSMutableArray *contatos;

-(void) adicionarContato:(Contatos *) contato;

-( Contatos *) buscaContatoDaPosicao:(NSInteger) posicao;

-(BOOL) removerContato:(NSInteger) posicao;

-(NSInteger) buscaPosicaoDoObjeto: (Contatos *) contato;

-(NSInteger) quantidadeRegistro;

-(void) visualizarRegistros;

+(id) contatoDaoInstance;

-(Contatos *) novoContato;


//PARTE DO CORE DATA
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
