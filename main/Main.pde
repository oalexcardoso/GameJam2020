//Importar e Definir classes
Personagem protagonista;
Inimigo inimigo;
Chefao chefao;
Mapa layerFundo, layerFrente, layerColisao;
Timer itemVisivel;
Timer semItem;
Menu botJogar;
//Itens item;
Timer npcTimer;
Timer difTimer;
Dialogo dialogo;

import processing.sound.*;
SoundFile file;

Tiro tiroMapa;

Timer tempoPassado;

int vezPassada=0;

PImage level1, gameover, venceu;

int passou1=0;

int clicou=0;

//Declarar variaveis
boolean chefe;
PImage imProtagonista, imChefao;
PImage imInimigoUm, imInimigoDois, imInimigoTres, imInimigoQuatro, imInimigoCinco, imInimigoSeis, imInimigoSete;
PImage tilemap;
PImage menuArq;
boolean[] teclas;
ArrayList<Personagem> npcs;
int estado;
boolean gameOver;
public boolean aranha;

int atirar=0;

int contInimigos;

int vidaInimigoUm = 1;
int vidaInimigoDois = 1;
int vidaInimigoTres = 2;
int vidaInimigoQuatro = 2;
int vidaInimigoCinco = 3;
int vidaInimigoSeis = 5;
int vidaInimigoSete = 15;

int nivel;
int verifica;

int contInimigoSurgiu;

Timer tempo;

boolean tocandoMusic=true;

void setup(){
   
  if(tocandoMusic){
    file = new SoundFile(this, "music.mp3");
    file.play();
  }

  //Definir tamanho tela
  size(1024,640);
  
  contInimigos=0;
  aranha=false;
  
  contInimigoSurgiu=0; 
  
  tempo = new Timer(4000);
  
  //Nomear classes
  botJogar = new Menu(370,440,256,40,"");
    //botInstrucoes = new Menu(x,y,lar,alt,"Instruções");
    //botCreditos = new Menu(x,y,lar,alt,"Créditos");
    //botSair = new Menu(x,y,lar,alt,"Sair");
    
    chefe=true;
    
    npcs = new ArrayList<Personagem>();
    //Quanto tempo o item vai ficar visivel na tela? 1,5seg
    itemVisivel = new Timer(1500);
    //Quando tempo o item vai ficar invisivel na tela? Aleatorio de 4seg a 6seg
    semItem = new Timer(random(4000,6000));
    teclas = new boolean[128];
    
    npcTimer = new Timer(1500);
    difTimer = new Timer(4000);
    
    imProtagonista = loadImage("Edgar.png");
    level1 = loadImage("Level1.png");
    venceu = loadImage("Venceu.png");
    gameover = loadImage("GameOver.png");
    
    menuArq = loadImage("MainMenu.png");
    
    setarInimigos();
      
    //menuArq = loadImage("nomeArquivo.png");       
    
    //Startar variaveis
    gameOver = false;
    estado = 0;
    verifica=0;
    
    nivel=0;        
    
    switch(nivel){
    
     case 0:     
        startUm();
      
     case 1:     
        startUm();        
        faseUm();
            
      break;
      
      case 2:
      
        startDois();  
        
        faseDois();
        
      break;
      
      case 3:
      
        startTres();
      
        faseTres();
        
      break;
      
      case 4:
      
        startQuatro();
        
        faseQuatro();
        
      break;
      
      case 5:
      
        startCinco();
        
        faseCinco();
        
      break;
    
    }
}

void setarInimigos(){
    imInimigoUm = loadImage("InimigoUm.png");
    imInimigoDois = loadImage("InimigoDois.png");
    imInimigoTres = loadImage("InimigoTres.png");
    imInimigoQuatro = loadImage("InimigoQuatro.png");
    imInimigoCinco = loadImage("InimigoCinco.png");
    imInimigoSeis = loadImage("InimigoSeis.png");
    imInimigoSete = loadImage("InimigoSete.png");
}

//O que fazer quando pressionar a tecla x
void keyPressed(){
  if(key<128 && key>=0){
    teclas[key]=true;
  }
}

//O que fazer quando soltar a tecla x
void keyReleased(){
  if(key<128 && key>=0){
    teclas[key]=false;
  }
}

void startUm(){
        tilemap = loadImage("tileMapUm.png");
        layerFundo = new Mapa(16,10,"layerFundoUm",64,64,tilemap);
        layerColisao = new Mapa(16,10,"layerColisaoUm",64,64,tilemap);
        layerFrente = new Mapa(16,10,"layerFrenteUm",64,64,tilemap);
        
        protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(256,width-64),(layerColisao.posY)-64,'a','d','w',TAB,64,64);
        
        atirar=0;     
}

void startDois(){
        tilemap = loadImage("tileMapDois.png");
        layerFundo = new Mapa(16,10,"layerFundoDois",64,64,tilemap);
        layerColisao = new Mapa(16,10,"layerColisaoDois",64,64,tilemap);
        layerFrente = new Mapa(16,10,"layerFrenteDois",64,64,tilemap);
        
        protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(384,608),(layerColisao.posY)-64,'a','d','w',TAB,64,64);
        
        atirar=0;
}

void startTres(){
        tilemap = loadImage("tileMapTres.png");
        layerFundo = new Mapa(16,10,"layerFundoTres",64,64,tilemap);
        layerColisao = new Mapa(16,10,"layerColisaoTres",64,64,tilemap);
        layerFrente = new Mapa(16,10,"layerFrenteTres",64,64,tilemap);
        
        protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(320,640),(layerColisao.posY)+448,'a','d','w',TAB,64,64);
  
        atirar=0;
}

void startQuatro(){
        tilemap = loadImage("tileMapQuatro.png");
        layerFundo = new Mapa(16,10,"layerFundoQuatro",64,64,tilemap);
        layerColisao = new Mapa(16,10,"layerColisaoQuatro",64,64,tilemap);
        layerFrente = new Mapa(16,10,"layerFrenteQuatro",64,64,tilemap);
      
        protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(576,896),(layerColisao.posY)-192,'a','d','w',TAB,64,64);
        
        atirar=0;
}

void startCinco(){
        tilemap = loadImage("tileMapCinco.png");
        layerFundo = new Mapa(16,10,"layerFundoCinco",64,64,tilemap);
        layerColisao = new Mapa(16,10,"layerColisaoCinco",64,64,tilemap);
        layerFrente = new Mapa(16,10,"layerFrenteCinco",64,64,tilemap);
      
        protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(320,640),(layerColisao.posY)-256,'a','d','w',TAB,64,64);
        
        atirar=0;
}
  
void resetUm(){
  contInimigoSurgiu=0;
  npcs.clear();
  protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(256,width-64),(layerColisao.posY)-64,'a','d','w',TAB,64,64);
  itemVisivel.intervalo=1500;
  
  atirar=0;
}

void resetDois(){
  contInimigoSurgiu=0;
  npcs.clear();
  protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(384,608),(layerColisao.posY)-64,'a','d','w',TAB,64,64);
  itemVisivel.intervalo=1500;
  
  atirar=0;
}

void resetTres(){
  contInimigoSurgiu=0;
  npcs.clear();
  protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(320,640),(layerColisao.posY)+448,'a','d','w',TAB,64,64);
  itemVisivel.intervalo=1500;
  
  atirar=0;
}

void resetQuatro(){
  contInimigoSurgiu=0;
  npcs.clear();
  protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(576,896),(layerColisao.posY)-192,'a','d','w',TAB,64,64);
  itemVisivel.intervalo=1500;
  
  atirar=0;
}

void resetCinco(){
  contInimigoSurgiu=0;
  npcs.clear();
  protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(576,896),(layerColisao.posY)-192,'a','d','w',TAB,64,64);
  itemVisivel.intervalo=1500;
  
  atirar=0;
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseUm(){
  
  //if(tempoPassado.disparou()==false){
        //image(level1,0,0);
  //}else{  
    
    gameOver=false;
  
    ArrayList<Personagem> remover = new ArrayList<Personagem>();
    ArrayList<Tiro> removert = new ArrayList<Tiro>();
    
    if(difTimer.disparou()){ 
      npcTimer.intervalo -=50;
    }
    
    if(npcTimer.disparou()){
    
      float npcx;
      float npcy; 
      
      do{
        npcx=random(64,576);
      } while(abs(protagonista.getCenterX()-npcx)<64 || abs(protagonista.getCenterY()-height-100)<64);
      
      aranha=true;
      
      if(contInimigoSurgiu<11){
        npcs.add(new Inimigo(imInimigoUm,npcx,height-100,'j','l','i','k',64,64,vidaInimigoUm));
        contInimigoSurgiu++;
      }
      
    }
    
    protagonista.anime();
    protagonista.movimente(layerColisao);
    
    if(atirar==1)  
      protagonista.atira();
      atirar=0;
    
    background(0);
    layerFundo.desenhe();
    
    protagonista.desenhe();
    
    for(Personagem n: npcs){
      n.animeInimigo();
      n.movimente(layerColisao);
      n.desenhe();
      
      if(protagonista.verificaColisao(n)){
        gameOver = true;
      }
      
      if(protagonista.getCenterX()<=0 || protagonista.getCenterX()>=width || protagonista.getCenterY()>=height){
        gameOver = true;
      }
      
      for(Tiro t : protagonista.tiros)
      {      
        
        if(n.verificaColisaoTiro(t))
        {
          
          if(n instanceof Inimigo){
            
            removert.add(t);  
            
            Inimigo ch = (Inimigo)n;
            ch.sofreDano();
            if(!ch.vivo()){
              remover.add(n);
              
              contInimigos++;
              
              if(contInimigos==10){           
                  
                  //nivel++;
                  
                  passou1=1;
                  
                  startDois();
                  
                  aranha=false;
                  
                  contInimigos=0;
                  contInimigoSurgiu=0;                
              }
            }
          }
       }
      }
    }
    
    layerColisao.desenhe();
    npcs.removeAll(remover);
    protagonista.tiros.removeAll(removert);
    if(gameOver)
    {      
      gameOver = false;
      nivel=20; 
    } 
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseDois(){    
  
  gameOver=false;
  
  ArrayList<Personagem> remover = new ArrayList<Personagem>();
  ArrayList<Tiro> removert = new ArrayList<Tiro>();
  
  if(difTimer.disparou()){ 
    npcTimer.intervalo -=50;
  }
  
  if(npcTimer.disparou()){
  
    float npcx;
    float npcy;
    
    do{
      npcx=random(352,640);
      npcy=random(height-64,height-32);
    } while(abs(protagonista.getCenterX()-npcx)<64 || abs(protagonista.getCenterY()-npcy)<64);
    
    if(contInimigoSurgiu<5){
      npcs.add(new Inimigo(imInimigoDois,npcx,npcy,'j','l','i','k',64,64,vidaInimigoDois));
      contInimigoSurgiu++;
    }else if((contInimigoSurgiu>4) && (contInimigoSurgiu<9)){
      npcs.add(new Inimigo(imInimigoTres,npcx,npcy,'j','l','i','k',64,64,vidaInimigoTres));
      contInimigoSurgiu++;
    }
  }
  
  protagonista.anime();
  protagonista.movimente(layerColisao);
  if(atirar==1)  
    protagonista.atira();
    atirar=0;
  
  background(0);
  layerFundo.desenhe();
  
  protagonista.desenhe();
  
  for(Personagem n: npcs){
    n.animeInimigo();
    n.movimente(layerColisao);
    n.desenhe();
    
    if(protagonista.verificaColisao(n)){
      gameOver = true;
    }
    
    if(protagonista.getCenterX()<=0 || protagonista.getCenterX()>=width || protagonista.getCenterY()>=height){
      gameOver = true;
    }
    
    for(Tiro t : protagonista.tiros)
    {
      if(n.verificaColisaoTiro(t))
      {
        
        if(n instanceof Inimigo){
          
          removert.add(t);  
          
          Inimigo ch = (Inimigo)n;
          ch.sofreDano();
          if(!ch.vivo()){
            remover.add(n); 
            
            contInimigos++;
            
            if(contInimigos==9){
              contInimigos=0;
              
              contInimigoSurgiu=0;
              nivel++;
              
              startTres();
            }   
          }
        }
     }
    }
  }
  
  layerColisao.desenhe();
  npcs.removeAll(remover);
  protagonista.tiros.removeAll(removert);
  if(gameOver)
  {
    gameOver = false;
    //resetDois();
    nivel=20; 
  }  
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseTres(){
  
  gameOver = false;
  
  ArrayList<Personagem> remover = new ArrayList<Personagem>();
  ArrayList<Tiro> removert = new ArrayList<Tiro>();
  
  if(difTimer.disparou()){ 
    npcTimer.intervalo -=50;
  }
  
  if(npcTimer.disparou()){
  
    float npcx;
    float npcy;
    
    do{
      npcx=random(0,256);
      npcy=random(height-64,height-32);
    } while(abs(protagonista.getCenterX()-npcx)<60 || abs(protagonista.getCenterY()-npcy)<60);
      
    if(contInimigoSurgiu<4){
      npcs.add(new Inimigo(imInimigoTres,random(0,256),npcy,'j','l','i','k',64,64,vidaInimigoTres));
      contInimigoSurgiu++;
    }else if((contInimigoSurgiu>3) && (contInimigoSurgiu<8)){
      npcs.add(new Inimigo(imInimigoQuatro,random(width-256,width),npcy,'j','l','i','k',64,64,vidaInimigoQuatro));
      contInimigoSurgiu++;
    }
  }
  
  protagonista.anime();
  protagonista.movimente(layerColisao);
  if(atirar==1)  
    protagonista.atira();
    atirar=0;
  
  background(0);
  layerFundo.desenhe();
  
  protagonista.desenhe();
  
  for(Personagem n: npcs){
    n.animeInimigo();
    n.movimente(layerColisao);
    n.desenhe();
    
    if(protagonista.verificaColisao(n)){
      gameOver = true;
    }
    
    if(protagonista.getCenterX()<=0 || protagonista.getCenterX()>=width || protagonista.getCenterY()>=height){
      gameOver = true;
    }
    
    for(Tiro t : protagonista.tiros)
    {
      if(n.verificaColisaoTiro(t))
      {
        
        if(n instanceof Inimigo){
          
          removert.add(t);  
          
          Inimigo ch = (Inimigo)n;
          ch.sofreDano();
          if(!ch.vivo()){
            remover.add(n);
            
            contInimigos++;
            
            if(contInimigos==8){
              contInimigos=0;
              
              contInimigoSurgiu=0;
              nivel++;
              
              startQuatro();
            }   
          }
        }
     }
    }
  }
  
  layerColisao.desenhe();
  npcs.removeAll(remover);
  protagonista.tiros.removeAll(removert);
  if(gameOver)
  {
    gameOver = false;
    //resetTres();
    nivel=20;
  }
     
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseQuatro(){
  
  gameOver=false;
  
  ArrayList<Personagem> remover = new ArrayList<Personagem>();
  ArrayList<Tiro> removert = new ArrayList<Tiro>();
  
  if(difTimer.disparou()){ 
    npcTimer.intervalo -=50;
  }
  
  if(npcTimer.disparou()){
  
    float npcx;
    float npcy;
    
    do{
      npcx=random(704,width-64);
      npcy=random(height-128,height-64);
    } while(abs(protagonista.getCenterX()-npcx)<64 || abs(protagonista.getCenterY()-npcy)<64);
    
    if(contInimigoSurgiu<3){
      npcs.add(new Inimigo(imInimigoCinco,npcx,npcy,'j','l','i','k',64,64,vidaInimigoCinco));
      contInimigoSurgiu++;
    }else if((contInimigoSurgiu>2) && (contInimigoSurgiu<5)){
      npcs.add(new Inimigo(imInimigoSeis,random(384,512),npcy,'j','l','i','k',90,96,vidaInimigoSeis));
      contInimigoSurgiu++;
    }
  }
  
  protagonista.anime();
  protagonista.movimente(layerColisao);
  if(atirar==1)  
    protagonista.atira();
    atirar=0;
  
  background(0);
  layerFundo.desenhe();
  
  protagonista.desenhe();
  
  for(Personagem n: npcs){
    n.animeInimigo();
    n.movimente(layerColisao);
    n.desenhe();
    
    if(protagonista.verificaColisao(n)){
      gameOver = true;
    }
    
    if(protagonista.getCenterX()<=0 || protagonista.getCenterX()>=width || protagonista.getCenterY()>=height){
      gameOver = true;
    }
    
    for(Tiro t : protagonista.tiros)
    {
      if(n.verificaColisaoTiro(t))
      {
        
        if(n instanceof Inimigo){
          
          removert.add(t);  
          
          Inimigo ch = (Inimigo)n;
          ch.sofreDano();
          
          if(!ch.vivo()){
            remover.add(n);
            
            contInimigos++;
            
            if(contInimigos==5){
              contInimigos=0;
              
              contInimigoSurgiu=0;
              nivel++;
              
              startCinco();
            }                                     
          }       
          
        }
     }
    }
  }
  
  layerColisao.desenhe();
  npcs.removeAll(remover);
  protagonista.tiros.removeAll(removert);
  if(gameOver)
  {
    gameOver = false;
    //resetQuatro();
    nivel=20; 
  }
  
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseCinco(){
  
  gameOver=false;
  
  ArrayList<Personagem> remover = new ArrayList<Personagem>();
  ArrayList<Tiro> removert = new ArrayList<Tiro>();
  
  if(difTimer.disparou()){ 
    npcTimer.intervalo -=50;
  }
  
  if(npcTimer.disparou()){
  
    float npcx;
    float npcy;
    
    do{
      npcx=random(704,width-64);
      npcy=random(height-128,height-64);
    } while(abs(protagonista.getCenterX()-npcx)<64 || abs(protagonista.getCenterY()-npcy)<64);
    
    if(contInimigoSurgiu<1){
      npcs.add(new Inimigo(imInimigoSete,npcx,npcy,'j','l','i','k',64,128,vidaInimigoSete));
      contInimigoSurgiu++;
    }
  }
  
  protagonista.anime();
  protagonista.movimente(layerColisao);
  if(atirar==1)  
    protagonista.atira();
    atirar=0;
  
  background(0);
  layerFundo.desenhe();
  
  protagonista.desenhe();
  
  for(Personagem n: npcs){
    n.animeInimigo();
    n.movimente(layerColisao);
    n.desenhe();
    
    if(protagonista.verificaColisao(n)){
      gameOver = true;
    }
    
    if(protagonista.getCenterX()<=0 || protagonista.getCenterX()>=width || protagonista.getCenterY()>=height){
      gameOver = true;
    }
    
    for(Tiro t : protagonista.tiros)
    {
      if(n.verificaColisaoTiro(t))
      {
        
        if(n instanceof Inimigo){
          
          removert.add(t);  
          
          Inimigo ch = (Inimigo)n;
          ch.sofreDano();
          
          if(!ch.vivo()){
            remover.add(n);
            
            contInimigos++;                                     
          }       
        }
     }
    }
  }
  
  layerColisao.desenhe();
  npcs.removeAll(remover);
  protagonista.tiros.removeAll(removert);
  if(gameOver)
  {
    gameOver = false;
    //resetQuatro();
    nivel=20; 
  }
  
  if(contInimigos==1){
     image(venceu,0,0);
  }
}

//Chamar a classe menu (contem layout e botoes) e exibir botoes
void menu(){  
  
  image(menuArq, 0, 0);
  textSize(32);
  
  //Inicio do jogo
  if(estado==0){
    //Desenha botoes do menu principal
    botJogar.desenhe();
  } 
}

//O que fazer quando pressionar o mouse
void mousePressed(){
  
  if(estado==0){
      if(botJogar.clicado()) 
        botJogar.destaque();
        clicou=1;
  }
  
  atirar=1;  
}

//O que fazer quando soltar o mouse
void mouseReleased(){
  
  if(botJogar.clicado()){
      nivel=0;
    }
  
  atirar=0;
}

//Executar a maquina de estado
void draw(){
   
  switch(nivel){
    
    //case -1:
      //menu();
    //break;
    
    case 0:
    
    menu();
    
    if(clicou==1){
    
      //Mostra o leve 1 por 5seg
      image(level1,0,0);
      
      gameOver=false;
      
      if(tempo.disparou()){
        nivel=1;
      }
    }
    
    break;
    
    case 1:     
        faseUm();
        
        gameOver=false;
        
        if(gameOver) 
          nivel=20;
        if(passou1==1)
          nivel=2;
        
    break;
    
    case 2:
      faseDois();
      if(gameOver) 
          nivel=20;
    break;
    
    case 3:
      faseTres();
      if(gameOver) 
          nivel=20;
    break;
    
    case 4:
      faseQuatro();
      if(gameOver) 
          nivel=20;
    break;
    
    case 5:
      faseCinco();
      if(gameOver) 
          nivel=20;
    break;
    
    
    case 20:
    image(gameover,0,0);
    if(mousePressed){  
      tocandoMusic=false;
      nivel=0;
      setup();
      tempo = new Timer(4000);
    }
    
    break;
  
  }
 
  switch(verifica){
  
    case 0: 
      protagonista.setarValores();
      teclas['w']=false;    
    break;
    
    case 1:
      teclas['w']=true;
    break;
    
    case 2:
      teclas['w']=false;
      verifica=0;
    break;
  }
  
  //Dependendo do estado
  //dialogo = new Dialogo(0,0,"nomeArquivo"); 
  //dialogo.desenhaDialogo();
}
