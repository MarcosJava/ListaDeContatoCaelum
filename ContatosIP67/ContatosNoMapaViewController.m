//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 15/01/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "ContatosNoMapaViewController.h"

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController

-(void) viewWillAppear:(BOOL)animated {
    [self.mapa addAnnotations:self.contatos];
}

-(void) viewWillDisappear:(BOOL)animated {
    [self.mapa removeAnnotations:self.contatos];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Adicionando o botao de navegacao na barra de cima
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.rightBarButtonItem = botaoLocalizacao;
    
    //Instancia o LocationManager e pede a permissao ao usuario
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(id) init {
    self = [super init];
    if (self) {
        
        //Adiciona a parte de baixo o menu que troca
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
        self.tabBarItem = tabItem;
        
        //Adiciona o titulo a barra de cima
        self.navigationItem.title = @"Localização";
        
        self.dao = [ContatoDao contatoDaoInstance];
        self.contatos = self.dao.contatos;
        
    }
    return self;
}


/***
    Funcao causada por causa do Delegate do Map.
    Inicia essa funcao sempre que o mapa for carregado
 **/
-(MKAnnotationView *) mapView: (MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"pino";
    MKPinAnnotationView *pino = (MKPinAnnotationView *) [self.mapa dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pino) {
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    } else {
        pino.annotation = annotation;
    }
    
    Contatos *contato = (Contatos *) annotation;
    pino.pinColor = MKPinAnnotationColorRed;
    pino.canShowCallout = YES;
    
    //Verifica se o contato tem foto e adiciona a foto dele no lado esquerdo do pop-up
    if (contato.foto) {
        
        //Cria uma imageView com o tamanho 30px , que eh o tamanho total
        UIImageView *imagemContato = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        imagemContato.image = contato.foto;
        pino.leftCalloutAccessoryView = imagemContato;
    }
    
    return pino;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
