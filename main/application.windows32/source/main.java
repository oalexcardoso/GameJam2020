import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

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

public void setup(){
   
  if(tocandoMusic){
    file = new SoundFile(this, "music.mp3");
    file.play();
  }

  //Definir tamanho tela
  
  
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

public void setarInimigos(){
    imInimigoUm = loadImage("InimigoUm.png");
    imInimigoDois = loadImage("InimigoDois.png");
    imInimigoTres = loadImage("InimigoTres.png");
    imInimigoQuatro = loadImage("InimigoQuatro.png");
    imInimigoCinco = loadImage("InimigoCinco.png");
    imInimigoSeis = loadImage("InimigoSeis.png");
    imInimigoSete = loadImage("InimigoSete.png");
}

//O que fazer quando pressionar a tecla x
public void keyPressed(){
  if(key<128 && key>=0){
    teclas[key]=true;
  }
}

//O que fazer quando soltar a tecla x
public void keyReleased(){
  if(key<128 && key>=0){
    teclas[key]=false;
  }
}

public void startUm(){
        tilemap = loadImage("tileMapUm.png");
        layerFundo = new Mapa(16,10,"layerFundoUm",64,64,tilemap);
        layerColisao = new Mapa(16,10,"layerColisaoUm",64,64,tilemap);
        layerFrente = new Mapa(16,10,"layerFrenteUm",64,64,tilemap);
        
        protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(256,width-64),(layerColisao.posY)-64,'a','d','w',TAB,64,64);
        
        atirar=0;     
}

public void startDois(){
        tilemap = loadImage("tileMapDois.png");
        layerFundo = new Mapa(16,10,"layerFundoDois",64,64,tilemap);
        layerColisao = new Mapa(16,10,"layerColisaoDois",64,64,tilemap);
        layerFrente = new Mapa(16,10,"layerFrenteDois",64,64,tilemap);
        
        protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(384,608),(layerColisao.posY)-64,'a','d','w',TAB,64,64);
        
        atirar=0;
}

public void startTres(){
        tilemap = loadImage("tileMapTres.png");
        layerFundo = new Mapa(16,10,"layerFundoTres",64,64,tilemap);
        layerColisao = new Mapa(16,10,"layerColisaoTres",64,64,tilemap);
        layerFrente = new Mapa(16,10,"layerFrenteTres",64,64,tilemap);
        
        protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(320,640),(layerColisao.posY)+448,'a','d','w',TAB,64,64);
  
        atirar=0;
}

public void startQuatro(){
        tilemap = loadImage("tileMapQuatro.png");
        layerFundo = new Mapa(16,10,"layerFundoQuatro",64,64,tilemap);
        layerColisao = new Mapa(16,10,"layerColisaoQuatro",64,64,tilemap);
        layerFrente = new Mapa(16,10,"layerFrenteQuatro",64,64,tilemap);
      
        protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(576,896),(layerColisao.posY)-192,'a','d','w',TAB,64,64);
        
        atirar=0;
}

public void startCinco(){
        tilemap = loadImage("tileMapCinco.png");
        layerFundo = new Mapa(16,10,"layerFundoCinco",64,64,tilemap);
        layerColisao = new Mapa(16,10,"layerColisaoCinco",64,64,tilemap);
        layerFrente = new Mapa(16,10,"layerFrenteCinco",64,64,tilemap);
      
        protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(320,640),(layerColisao.posY)-256,'a','d','w',TAB,64,64);
        
        atirar=0;
}
  
public void resetUm(){
  contInimigoSurgiu=0;
  npcs.clear();
  protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(256,width-64),(layerColisao.posY)-64,'a','d','w',TAB,64,64);
  itemVisivel.intervalo=1500;
  
  atirar=0;
}

public void resetDois(){
  contInimigoSurgiu=0;
  npcs.clear();
  protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(384,608),(layerColisao.posY)-64,'a','d','w',TAB,64,64);
  itemVisivel.intervalo=1500;
  
  atirar=0;
}

public void resetTres(){
  contInimigoSurgiu=0;
  npcs.clear();
  protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(320,640),(layerColisao.posY)+448,'a','d','w',TAB,64,64);
  itemVisivel.intervalo=1500;
  
  atirar=0;
}

public void resetQuatro(){
  contInimigoSurgiu=0;
  npcs.clear();
  protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(576,896),(layerColisao.posY)-192,'a','d','w',TAB,64,64);
  itemVisivel.intervalo=1500;
  
  atirar=0;
}

public void resetCinco(){
  contInimigoSurgiu=0;
  npcs.clear();
  protagonista = new Personagem(imProtagonista,(layerColisao.posX)+random(576,896),(layerColisao.posY)-192,'a','d','w',TAB,64,64);
  itemVisivel.intervalo=1500;
  
  atirar=0;
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
public void faseUm(){
  
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
public void faseDois(){    
  
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
public void faseTres(){
  
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
public void faseQuatro(){
  
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
public void faseCinco(){
  
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
public void menu(){  
  
  image(menuArq, 0, 0);
  textSize(32);
  
  //Inicio do jogo
  if(estado==0){
    //Desenha botoes do menu principal
    botJogar.desenhe();
  } 
}

//O que fazer quando pressionar o mouse
public void mousePressed(){
  
  if(estado==0){
      if(botJogar.clicado()) 
        botJogar.destaque();
        clicou=1;
  }
  
  atirar=1;  
}

//O que fazer quando soltar o mouse
public void mouseReleased(){
  
  if(botJogar.clicado()){
      nivel=0;
    }
  
  atirar=0;
}

//Executar a maquina de estado
public void draw(){
   
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
//Estrutando a classe
class Chefao extends Personagem{
  //Definir variaveis
  float dx,dy;
  PVector desl;
  int vida;
  Timer t;
  
  //Parametros a serem passados
  public Chefao(PImage img, float posX, float posY, char tEsq, char tDir, char tCim, char tPula, int lar, int alt){
    //Quando definir vai funcionar sem erro
    super(img, posX, posY, tEsq, tDir, tCim, tPula, lar, alt);
    decideMovimento();
    vida=30;
    t = new Timer(500);
  }
  
  //Retirar vida apos tomar tiro
  public void sofreDano(){
    vida--;
  }
  
  //Analisar se ainda tem vida
  public boolean vivo(){
    return vida>0;
  }
  
  //Decide movimento, vai atras do protagonista
  private void decideMovimento(){
    
    if(protagonista.getCenterX()>getCenterX()){
      dx=1;
    }
    else{
       dx=-1;
    }
    
    if(protagonista.getCenterY()>getCenterY()){
      dy=1;
    }
    else{
       dy=-1;
    }
    
    //Direção aleatoria
    float dir = random(2);
    
    if(dir<1){
      
      if(dx==1){ 
        quadro=2;
      }
      else{
        quadro=6;
      }
      
      if(dy==1){ 
        quadro=0;
      }
      else{ 
        quadro=4;
      }
    }
    else{      
      
      if(dy==1){
        quadro=0;
      }
      else{ 
        quadro=4;
      }
      
      if(dx==1){
        quadro=2;
      }
      else{ 
        quadro=6;
      } 
    }
  }
  
  //Movimentar com base no tiro disparado
  public void movimente(Mapa layer) {
    if(t.disparou())
    {
      decideMovimento();
    }
    pos.y=pos.y+desl.x;
    if(desl.x>0){
      if(layer.colidiu((int)pos.y+lar,(int)pos.x,(int)pos.y+lar,(int)pos.x+alt))
      pos.y=pos.y-desl.x;
    }
    else if(desl.x<0){
      if(layer.colidiu((int)pos.y,(int)pos.x,(int)pos.y,(int)pos.x+alt))
      pos.y=pos.y-desl.x;
    }

    pos.x=pos.x+dy;
    if(dy>0){
      if(layer.colidiu((int)pos.y,(int)pos.x+alt,(int)pos.y+lar,(int)pos.x+alt))
      pos.x=pos.x-dy;
    }
    else if(dy<0){
      if(layer.colidiu((int)pos.y,(int)pos.x,(int)pos.y+lar,(int)pos.x))
      pos.x=pos.x-dy;
    }
  }
  
}
//Estrutando a classe
class Dialogo{
  float bAlt,bComp;
  float x,y;
  int tam;
  PImage dialogoX;
  
  public Dialogo(float posx, float posy, String nomeArquivo){
    //Importanto a imagem PNG
    dialogoX = loadImage(nomeArquivo+".png");
    
    x=posx;
    y=posy;
  }
  
  public void desenhaDialogo()
  {                
    //Corta a imagem com o get(x que comeca, y que comeca, comprimento, altura)
    image(dialogoX,0,0);
  }    
}
//Estrutando a classe
class Inimigo extends Personagem{
  float dx,dy;
  Timer t;
  int vida;
  
  //Parametros a serem passados
  public Inimigo(PImage img, float posX, float posY, char tEsq, char tDir, char tCim, char tSpace, int lar, int alt, int vida){
    super(img, posX, posY, tEsq, tDir, tCim, tSpace, lar, alt);
    decideMovimento();
    this.vida=vida;
    t = new Timer(500);
  }
  
  public void sofreDano(){
    vida--;
  }
  
  public boolean vivo(){
    return vida>0;
  }
  
  private void decideMovimento(){
    
    if(protagonista.getCenterX()>getCenterX()){
      dx=1;
      //quadro=6;
    }
    else{
       dx=-1;
      //quadro=2;
    }
    
    if(protagonista.getCenterY()>getCenterY()){
      dy=1;
      //quadro=0;
    }
    else{
       dy=-1;
      //quadro=4;
    }
    float dir = random(2);
    if(dir<1){
      if(dx==1) quadro=1;
      else quadro=0;
      if(dy==1) quadro=1;
      else quadro=0;
    }
    else{      
      if(dy==1) quadro=1;
      else quadro=0;
      if(dx==1) quadro=1;
      else quadro=0;
    }
  }
  
  public void movimente(Mapa layer) {
    if(t.disparou())
    {
      decideMovimento();
      
    }
    
    if(aranha==false){    
      pos.x=pos.x+dx;
      if(dx>0){
        if(layer.colidiu((int)pos.x+lar,(int)pos.y,(int)pos.x+lar,(int)pos.y+alt))
        pos.x=pos.x-dx;
      }
      else if(dx<0){
        if(layer.colidiu((int)pos.x,(int)pos.y,(int)pos.x,(int)pos.y+alt))
        pos.x=pos.x-dx;
      }
  
      pos.y=pos.y+dy;
      if(dy>0){
        if(layer.colidiu((int)pos.x,(int)pos.y+alt,(int)pos.x+lar,(int)pos.y+alt))
        pos.y=pos.y-dy;
      }
      else if(dy<0){
        if(layer.colidiu((int)pos.x,(int)pos.y,(int)pos.x+lar,(int)pos.y))
        pos.y=pos.y-dy;
      }
    }else{
      pos.x=pos.x+dx; 
      pos.y=pos.y;      
    }
  }
}

class Mapa{
  //Largura e Altura Mapa (16x10)
  int lar,alt; 
  //Arquivo Mapa
  PImage tImage; 
  //Largura e Altura de um tile em pixels (64x64)
  int tLar, tAlt; 
  byte[] b;
  byte[][] layer;
  
  //Variavel de varredura de colisao
  public int posY, posX;
  
  //Parametros a serem passados
  public Mapa(int l, int a, String nomeArquivo, int tLar, int tAlt, PImage tImage){
    lar=l;
    alt=a;
    this.tAlt=tAlt;
    this.tLar=tLar;
    this.tImage=tImage;
    b = loadBytes(nomeArquivo);
    
    layer = new byte[alt][lar];
    
    for(int i=0;i<b.length;i++){
      layer[i/lar][i%lar]=b[i];
    }
    
    //Faz a varredura no eixo Y até que encontre uma camada de colisao    
    int i;
    
    for(i=0;i<alt;i++){
        if(layer[i][0]!=-1){
            posY=i*64;
            break;
        }
     }
    
    //Faz a varredura do eixo X até que encontre o final do eixo de colisao
      for(int j=0;j<lar;j++){        
        if(layer[(posY/64)][j]!=1){
            posX=j*64;
            break;
        }
      }
      
      print("\nposX: ", posX);
      print("\nposY: ", posY);
      
  } 
  
  //Varrer a matriz do mapa e desenhar
  public void desenhe(){
    for(int i=0; i<alt;i++){
      for(int j=0; j<lar; j++){
        if(layer[i][j]!=-1)
          image(tImage.get(layer[i][j]*tLar,0,tLar,tAlt),j*tLar,i*tAlt);
      }
    }
  }
  
  //Tratar a camada de colisao e analisar
  public boolean colidiu(int xi, int yi, int xf, int yf){
    xi=xi/tLar;
    xf=(xf-1)/tLar;
    yi=yi/tAlt;
    yf=(yf-1)/tAlt;
    
    if(xi<0)
      xi=0;
      
    if(yi<0)
      yi=0;
    
    if(xf<0)
      xf=0;
    
    if(yf<0)
      yf=0;
    
    if(xi>lar-1)
      xi=lar-1;
    
    if(xf>lar-1)
      xf=lar-1;
    
    if(yi>alt-1)
      yi=alt-1;
    
    if(yf>alt-1)
      yf=alt-1;
   
    for(int i=xi;i<=xf;i++){
      for(int j=yi;j<=yf;j++){
        if(layer[j][i]!=-1){
          return true;
        }
      }
    }
    return false;
  }
  
  //Pegar alt do tile
  public int getTileAlt(){
    return tAlt;
  }
  
  //Pegar lar do tile
  public int getTileLar(){
    return tLar;
  }
  
}
//Estrutando a classe
class Menu{
  //Orientação
  int x, y;
  //Conteudo do texto
  String texto;
  //Medidas botoes
  int lar, alt;
  //Estado do botao
  boolean pressionado;
  
  //Parametros a serem passados
  public Menu(int x, int y, int lar, int alt, String texto){
    //Definir variaves
    this.x=x;
    this.y=y;
    this.lar=lar;
    this.alt=alt;
    this.texto=texto;
    pressionado=false;
  }
  
  //Ver se ponteiro do mouse esta dentro do botao
  public boolean clicado(){
    //Retornando verificacoes
    return (mouseX>x && mouseX<x+lar && mouseY>y && mouseY<y+alt);
  }
  
  //Deixa botao com cor diferente
  public void destaque(){
    //Mudando estado do botao
    pressionado=true;
  }
    
  //Tira a cor diferente do botao
  public void removeDestaque(){
    //Mudando estado do botao
    pressionado=false;
  }
    
  //Desenhar botoes
  public void desenhe(){
      //Preenchimento do botao
      fill(255,0,0,255);
  }
  
}
//Estrutando a classe
class Personagem{
  public PVector pos;
  //Posição do personagem na tela
  //public float pos.x;
  //public float pos.y;
  //Numero do quadro sendo exibido
  protected int quadro;
  //Referência pra imagem do personagem
  private PImage sprites;
  //Velocidade do personagem
  private float vel;
  //Teclas para controlar
  private char tEsq, tDir, tCim, tSpace;
  //Largura e Altura de um sprite (64x64)
  protected int lar, alt; 
  protected Timer tAnimacao;
  ArrayList<Tiro> tiros;
  Timer tTiro;
  int cadenciaTiro;
  public int pontuacao;
  
  Tiro tiro;
  
  float g;
  float velYMax;
  float dy;
  
  float controle;
  float controleAcao;
  
  int pulando;
  
  //Parametros a serem usados
  public Personagem(PImage img, float posX, float posY, char tEsq, char tDir, char tCim, char tSpace, int lar, int alt){
    this.lar=lar;
    this.alt=alt;
    this.tEsq=tEsq;
    this.tDir=tDir;
    this.tCim=tCim;
    this.tSpace=tSpace;
    sprites = img;
    
    pos = new PVector(posX, posY);
    
    //Exibir quadro inicial
    quadro=3;
    //Setar velocidade do jogador
    vel=4;
    tAnimacao = new Timer(1000/6);
    tiros=new ArrayList<Tiro>();
    cadenciaTiro=500;
    tTiro = new Timer(cadenciaTiro);
    controleAcao=0;
    pulando=0;
    
    setarValores();
    
  }
  
  public void setarValores(){
    //Depois de pular, ficar pronto para novo salto
    g = 1.2f;
    velYMax = 56;
    dy = -28;  
  
  }
  
  public void atira(){
    if(tTiro.disparou())
      tiros.add(new Tiro(getCenterX(),getCenterY(),12,3));
  }
  
  public void anime(){
    if(teclas[tCim]){
    if(quadro<0||quadro>1)
      quadro=0;
  }
  else if(teclas[tEsq]){
    if(quadro<2||quadro>3)
      quadro=2;
  }
  else if(teclas[tDir]){
    if(quadro<0||quadro>1)
      quadro=0;
  }
  quadro++;
  if(quadro%2==0)quadro=quadro-2;
     
  }
  
  public void animeInimigo(){
    if(teclas[tCim]){
        quadro=4;
    }
    
    if(teclas[tEsq]){
        quadro=2;
    }
   
    if(teclas[tDir]){
        quadro=6;
    }
  }
  
  public void desenhe() {
    for(Tiro t: tiros){
      t.movimente();
      t.desenha();
    }
    
    int px=(quadro%2)*lar;
    int py=(quadro/2)*alt;
    image(sprites.get(px,py,lar,alt),pos.x,pos.y);
    
  }
  
  //Analise da movimentação do personagem na tela
  public void movimente(Mapa layer){
    
    print("\n", verifica);
    
    if(teclas[tCim]){
      
      verifica=1;      
      
      if(verifica==1){
      
        pos.y=pos.y+dy;
        pulando=1;
        
          if(dy<velYMax){              
            dy=dy+g;
            pulando=1;           
          }
          else{ 
            dy=velYMax;
            pulando=1;
          }
        
          //Colisao com o teto e plataforma por baixo
          if(layer.colidiu((int)pos.x,(int)pos.y,(int)pos.x+lar,(int)pos.y)){
            pos.y=pos.y+(layer.getTileAlt()-pos.y%layer.getTileAlt());
            
            pulando=0;
            
            verifica=2;
          }
          
          //Colisao com o chao ou plataforma por cima
          if(layer.colidiu((int)pos.x,(int)pos.y+alt,(int)pos.x+lar,(int)pos.y+alt)){
            pos.y=pos.y-(pos.y%layer.getTileAlt());
            
            pulando=0;
                        
            verifica=2;
          }
        }
    }
   
    if(teclas[tEsq]){
      
      if(pulando==1){
        pos.x=pos.x-vel;
      }else{  
        pos.x=pos.x-vel;
        
          if(layer.colidiu((int)pos.x,(int)pos.y,(int)pos.x,(int)pos.y+alt)){
            pos.x=pos.x+(layer.getTileLar()-pos.x%layer.getTileLar());
          }
          
          if((layer.colidiu((int)pos.x,(int)pos.y+alt,(int)pos.x+lar,(int)pos.y+alt))){
            print("Acabou");          
          }
          
          verifica=1;
            
            controle=25;
          
            pos.y=(pos.y)+(controle);
            
              if((controle)<velYMax){
                  controle=(controle)+g;            
              }
              else{ 
                controle=velYMax;
              }
              
              //Colisao com o chao ou plataforma por cima
              if(layer.colidiu((int)pos.x,(int)pos.y+alt,(int)pos.x+lar,(int)pos.y+alt)){
                pos.y=pos.y-(pos.y%layer.getTileAlt());
                verifica=2;
              } 
      }
    }
    
    if(teclas[tDir]){   
      if(pulando==1){
        pos.x=pos.x+vel;
      }else{  
        pos.x=pos.x+vel;
          if(layer.colidiu((int)pos.x+lar,(int)pos.y,(int)pos.x+lar,(int)pos.y+alt)){
            pos.x=pos.x-pos.x%layer.getTileLar();
          }
          verifica=1;
            
              controle=25;
            
              pos.y=(pos.y)+(controle);
              
                if((controle)<velYMax){
                    controle=(controle)+g;            
                }
                else{ 
                  controle=velYMax;
                }
                
                //Colisao com o chao ou plataforma por cima
                if(layer.colidiu((int)pos.x,(int)pos.y+alt,(int)pos.x+lar,(int)pos.y+alt)){
                  pos.y=pos.y-(pos.y%layer.getTileAlt());
                  
                  verifica=2;
                }
      }
    }
  }
  
  public float getCenterX(){
    return pos.x+lar/2;
  }

  public float getCenterY(){
    return pos.y+alt/2;
  }
  
  public float getRadius(){
    return lar/2; //podemos usar um atributo raio como parametro
  }
  
  public boolean verificaColisao(Personagem p){
    return ((getCenterX()-p.getCenterX())*(getCenterX()-p.getCenterX())+(getCenterY()-p.getCenterY())*(getCenterY()-p.getCenterY()))<((getRadius()+p.getRadius())*(getRadius()+p.getRadius()));
  }

  public boolean verificaColisaoTiro(Tiro tiro){
    return (sq(getCenterX()-tiro.posX)+sq(getCenterY()-tiro.posY)<(sq(getRadius()+tiro.raio)));
  }
  
}
//Estrutando a classe
class Timer{
  //Definir variaveis
  private long ultimoTempo;
  private float intervalo;
  
  //Parametros a serem passados
  public Timer(float intervalo){
    ultimoTempo = millis();
    this.intervalo = intervalo;
  }
  
  //Ver se x ação ocorreu a x tempo
  public boolean disparou(){
    long tempoAtual = millis();
    if(tempoAtual-ultimoTempo>=intervalo){
      ultimoTempo=tempoAtual;
      return true;
    }
    return false;
  }
  
  //Resetar a contagem
  public void reseta(){
      ultimoTempo = millis();
  }
  
}
//Estrutando a classe
class Tiro{
  //Definir variaveis
  float velocidade;
  float posX, posY;
  float dx,dy;
  public float raio;
  
  //Parametros a serem passados
  public Tiro(float posX, float posY, float v, float r){
    this.posX=posX;
    this.posY=posY;
    velocidade=v;
    raio=r;
    
    dx=mouseX-posX;
    dy=mouseY-posY;
    float dist = sqrt(sq(mouseX-posX)+sq(mouseY-posY));
    dx=dx/dist*velocidade;
    dy=dy/dist*velocidade;
  }
  
  //Deslocamento da bala
  public void movimente(){
    posX+=dx;
    posY+=dy;
  }
  
  //Desenhar o tiro na tela
  public void desenha(){
    fill(255,204,0);
    stroke(255,204,0);
    ellipse(posX,posY,raio*2,raio*2);
  }
}
  public void settings() {  size(1024,640); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
