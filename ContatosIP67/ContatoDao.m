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
    if(defaultDao == nil){
        NSLog(@"Instanciou o DAO");
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
        [self inserirDadosInicias];
        [self carregaTodosContatosInicias];
    }
    return self;
}


-( Contatos *) buscaContatoDaPosicao:(NSInteger) posicao{
    return self.contatos[posicao];
}

-(void) adicionarContato:(Contatos *)contato {
    [self.contatos addObject:contato];
    NSLog(@"Contatos no DAO: %@", self.contatos);
}

-(BOOL) removerContato:(NSInteger)posicao {
    
    if (posicao >= 0 ){
        [self.contatos removeObjectAtIndex:posicao];
        return true;
    }
    return false;
    
}

-(NSInteger) buscaPosicaoDoObjeto:(Contatos*) contato{
    return [self.contatos indexOfObject:contato];
}

-(NSInteger) quantidadeRegistro {
    return _contatos.count;
}

-(void) visualizarRegistros {
    NSLog(@"A lista do DAO = %@" , _contatos);
}

-(Contatos *) novoContato {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.managedObjectContext];
}


-(void) inserirDadosInicias {
    
    //Configuracoes do usuario
    NSUserDefaults *configuracoes = [NSUserDefaults standardUserDefaults];
    
    //Verifica se tem dados na configuracao Dados_inseridos
    BOOL dadosInseridos = [configuracoes boolForKey:@"dados_inseridos"];
    
    if (!dadosInseridos) {
        
        Contatos *marcos = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.managedObjectContext];
        
        marcos.nome = @"Marcos Felipe";
        marcos.email = @"mfelipesp@gmail.com";
        marcos.endereco = @"Rua cinco rios, 36 RJ";
        marcos.telefone = @"98416-0813";
        marcos.site = @"www";
        marcos.latitude = [NSNumber numberWithDouble:-22.819187];
        marcos.longitude = [NSNumber numberWithDouble:-43.295153];
        
        [self saveContext];
        [configuracoes setBool:YES forKey:@"dados_inseridos"];
        [configuracoes synchronize];
        
    }
}


-(void) carregaTodosContatosInicias {
    
    //Cria uma busca
    NSFetchRequest *buscaContatos = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    
    //Cria uma ordenacao
    NSSortDescriptor *ordenarPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    
    //Coloca a ordenacao na busca
    buscaContatos.sortDescriptors = @[ordenarPorNome];
    
    //Joga o resultado no Array
    NSArray *contatosImutaveis = [self.managedObjectContext executeFetchRequest:buscaContatos error:nil];
    
    //joga o Array nos contatos
    _contatos = [contatosImutaveis mutableCopy];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "br.com.marcos.ContatosIP67" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ContatosIP67" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ContatosIP67.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
