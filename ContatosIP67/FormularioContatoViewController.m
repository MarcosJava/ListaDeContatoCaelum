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
    

    // Verifica se o objeto contato esta instanciado, caso esteja é pq eh para edição e já preenche o formulario para o usuario
    if(self.contato){
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
        self.longitude.text = [self.contato.longitude stringValue];
        self.latitude.text = [self.contato.latitude stringValue];
        
        if (self.contato.foto) {
            [self.botaoFoto setBackgroundImage:self.contato.foto forState:UIControlStateNormal];
            [self.botaoFoto setTitle:nil forState:UIControlStateNormal];
        }
        
        self.navigationItem.title = @"Alteração";
        UIBarButtonItem *editar = [[UIBarButtonItem alloc] initWithTitle:@"Editar" style:UIBarButtonItemStylePlain target:self action:@selector(editarContato)];
        self.navigationItem.rightBarButtonItem = editar;
    
    } else {
        
        self.navigationItem.title = @"Cadastro";
        
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc] initWithTitle:@"Adicionar" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
        
        self.navigationItem.rightBarButtonItem = adiciona;
    }
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
    }
    
    return self;
}

-(void) criaContato {
    [self pegaDadosDoFormulario];
    [self.dao adicionarContato:self.contato];
    
    //retornando o delegador
    if(self.delegate) {
        [self.delegate contatoAdicionado:self.contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES]; //Atualiza a view
}

-(void) editarContato{
    
    [self.dao visualizarRegistros];
    [self pegaDadosDoFormulario];
    
    //retornando ao delegador
    if(self.delegate){
        [self.delegate contatoAtualizado: self.contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES]; //Atualiza a view
}




- (IBAction)pegaDadosDoFormulario{
    /***
     Verificação para instancia o objeto apenas quando for criação(poupar memoria)
     Alem de poupar a memoria o Objeto contato ja ta referenciado na ArrayMutable, 
     logo apenas alterar-lo , altera o do array sem a necessidade de fazer no DAO 
     um pegaIndex e alterarObjetoNoIndex
    ***/
    if(!self.contato){
        self.contato = [self.dao novoContato];
    }
    
    if ([self.botaoFoto backgroundImageForState:UIControlStateNormal]) {
        self.contato.foto = [self.botaoFoto backgroundImageForState:UIControlStateNormal];
    }
    
    self.contato.nome = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    self.contato.latitude = [NSNumber numberWithFloat: [self.latitude.text floatValue]];
    self.contato.longitude = [NSNumber numberWithFloat:[self.longitude.text floatValue]];

}

- (IBAction)selecionarFoto:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //Sheet deprecated, no ListaContatos tem um atual
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do Contato" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar foto", @"Escolher da biblioteca", nil];
        [sheet showInView:self.view];
       
    
    } else {
        
        //Nao tem camera, disponibiliza usar a galerias
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        
        
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}


//Depois que escolhe a imagem na galeria
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *imageSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.botaoFoto setBackgroundImage:imageSelecionada forState:UIControlStateNormal];
    [self.botaoFoto setTitle:nil forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



// Delegate do SheetAction que esta deprecated. no ListContatos tem um atual
-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            break;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
    
}


- (IBAction)buscaCoordenadas:(id)sender {
    [self.loading startAnimating];
    self.botaoMapa.hidden = YES;
    
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:self.endereco.text completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            CLPlacemark *resultado = placemarks[0];
            CLLocationCoordinate2D coordenada = resultado.location.coordinate;
            self.latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
            self.longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
        } else {
            
        }
        [self.loading stopAnimating];
        self.botaoMapa.hidden = NO;
        
        
    }];
    
}
@end
