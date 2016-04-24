//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 01/12/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import "ListaContatosViewController.h"




@implementation ListaContatosViewController

- (void)viewDidAppear:(BOOL)animated{
    
    
    [self.tableView reloadData];
    animated = true;
    
    if(self.linhaDestaque > 0){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.linhaDestaque inSection:0];
        
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        self.linhaDestaque = -1;
    }
    
    
    
    //configurando para pressionar o botao
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibirMaisAcoes:)];
    [self.tableView addGestureRecognizer:longPress];
    
    
   
    
    
}


-(id) init{
    self = [super init];
    if(self){
        
        
        //UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
        
        
        UIImage *image = [UIImage imageNamed:@"contat.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Contatos" image:image tag:0];
        self.tabBarItem = tabItem;
        
        self.navigationItem.title = @"Contatos";
        
        // Cria o botao na navegacao
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
        
        //Coloca o botao no navegation view
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
        
        self.editButtonItem.title = @"Editar";
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        
        
        self.linhaDestaque = -1;
        
        self.dao = [ContatoDao contatoDaoInstance];
    }
    return self;
}

/*
 ** Traduz os botões ( editar e feito )
 **/
-(void) setEditing:(BOOL)editing animated:(BOOL)animated{
    
    //chama do super
    [super setEditing:editing animated:animated];
    
    //verifica se esta editando e muda pra feito =)
    if (editing){
        self.editButtonItem.title = NSLocalizedString(@"Feito", @"Feito");
    
    } else {
        self.editButtonItem.title = NSLocalizedString(@"Editar", @"Editar");
    }
}

-(void) exibeFormulario {
    
    NSLog(@"Aqui nos iremos exibir o formulario");
    //[self exibirAlert:@"Atencao" eComMensagem:@"Exibira um Formulario"];
    
    //Instancia a StoryBoard Main
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Instancia o form com a storyboard que tenha o ID Storyboard Form-Contato
    FormularioContatoViewController *form = [storyboard instantiateViewControllerWithIdentifier:@"Form-Contato"];
    
    form.delegate = self;
    
    if (self.contatoSelecionado) {
        form.contato = self.contatoSelecionado;
    }
    
    //Inicia o form na Storyboard
    [self.navigationController pushViewController:form animated:YES];
}

/**
 **** Exibe Alerta
 */
-(void) exibirAlert:(NSString*) titulo eComMensagem:(NSString *) mensagem {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:titulo
                                                                   message:mensagem
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//Agrupamento na tableView, como nao iremos agrupar valores , retornamos 1
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{ return 1;}


//Retorna a quantidade de linha que sera exibida
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dao.contatos count];
}




//Editar como vai ser cada celula na TableView , adicionando Reciclagem.
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSLog(@"Linha de numero : %ld" , (long)indexPath.row);
    
    
    
    //Busca o contato naquela posicao
    Contatos *contato = [self.dao buscaContatoDaPosicao:indexPath.row];
    
    NSLog(@"O nome para essa linha : %@", contato.nome);
    
    
    cell.textLabel.text = contato.nome;
    
    return cell;
}


// Remover , padrão iOS
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Contatos *contato = [self.dao buscaContatoDaPosicao:indexPath.row];
        NSString *message =  @"Você deseja realmente excluir o contatdo: ";
        message = [message stringByAppendingString:contato.nome];
        message = [message stringByAppendingString:@" ?"];
        
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Atenção"
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Deletar" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
            
            [self.dao removerContato:indexPath.row]; //remove no dao
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade]; // efeito + reloadData
                                                                
        }];
        
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
        
        [alert addAction:yesAction];
        [alert addAction:noAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        //[self.tableView reloadData];
    }
}

//Alterando o DELETE quando Exclui com Swip
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Vai excluir ?";
}


/*
    Linha que recebeu o tap
 */
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     self.contatoSelecionado = [self.dao buscaContatoDaPosicao:indexPath.row];
    NSLog(@"Clicou no contato : %@", self.contatoSelecionado.nome);
    [self exibeFormulario];
    self.contatoSelecionado = nil;
}


/****
 
 DELEGATE que nos criamos
 **/
-(void) contatoAdicionado:(Contatos *)contato{
    NSLog(@"O Adicionando Contato eh : %@", contato.nome);
    self.linhaDestaque = [self.dao buscaPosicaoDoObjeto:contato];
}

-(void) contatoAtualizado:(Contatos *)contato{
    NSLog(@"O Atualizando Contato eh : %@", contato.nome);
    self.linhaDestaque = [self.dao buscaPosicaoDoObjeto:contato];
}



/**
  Usado pelo GestureRecognizer do LongPress
  Usado pelo UIActionSheet
 */
-(void) exibirMaisAcoes:(UIGestureRecognizer *)gesture {
    
    //Verifica se eh o inicio
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        
        if (index) {
            self.contatoSelecionado = [self.dao buscaContatoDaPosicao:index.row];
            _gerenciador = [[GerenciadorDeAcoes alloc] initWithContato:self.contatoSelecionado];
            [self.gerenciador acoesDoController:self];
        }
        

    }
}





@end
