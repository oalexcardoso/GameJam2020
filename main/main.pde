//Importar e Definir classes
Personagem protagonista;
Inimigo inimigo;
Chefao chefao;
Mapa layerFundo, layerFrente, layerColisao;
Timer itemVisivel;
Timer semItem;
Menu botJogar, botInstrucoes, botSair, botCreditos;
//Itens item;
Dialogo dialogo;

//Declarar variaveis
PImage imProtagonista, imInimigo, imChefao;
PImage tilemap;
PImage menuArq;
boolean[] teclas;
ArrayList<Personagem> npcs;
int estado;
boolean gameOver;
boolean inimigosOn;

void setup(){

  //Definir tamanho tela
  size(1024,640);
  
  //Nomear classes
    //botJogar = new Menu(x,y,lar,alt,"Jogar");
    //botInstrucoes = new Menu(x,y,lar,alt,"Instruções");
    //botCreditos = new Menu(x,y,lar,alt,"Créditos");
    //botSair = new Menu(x,y,lar,alt,"Sair");
    
    npcs = new ArrayList<Personagem>();
    //Quanto tempo o item vai ficar visivel na tela? 1,5seg
    itemVisivel = new Timer(1500);
    //Quando tempo o item vai ficar invisivel na tela? Aleatorio de 4seg a 6seg
    semItem = new Timer(random(4000,6000));
    teclas = new boolean[128];
    
    tilemap = loadImage("nomeArquivo.png");
    layerFundo = new Mapa(16,10,"layerFundo",64,64,tilemap);
    layerColisao = new Mapa(16,10,"layerColisao",64,64,tilemap);
    layerFrente = new Mapa(16,10,"layerFrente",64,64,tilemap);
    
    imProtagonista = loadImage("nomeArquivo.png");
    protagonista = new Personagem(imProtagonista,width/2,height/2,'a','d','w',TAB,64,128);
    
    imInimigo = loadImage("nomeArquivo.png");
    inimigo = new Inimigo(imInimigo,width/2,height/2,'H','J','K','L',64,128);
    
    imChefao = loadImage("nomeArquivo.png");
    chefao = new Chefao(imChefao,width/2,height/2,'Y','U','I','O',128,128);
  
    menuArq = loadImage("nomeArquivo.png");       
    
    //Startar variaveis
    gameOver = false;
    estado = 1;
    inimigosOn = true;
}

//O que fazer quando pressionar a tecla x
void keyPressed(){
  if(key<128 && key>=0)
    teclas[key]=true;
}

//O que fazer quando soltar a tecla x
void keyReleased(){
  if(key<128 && key>=0)
    teclas[key]=false;
}

void reset(){
  npcs.clear();
  protagonista = new Personagem(imProtagonista,width/2,height/2,'a','d','w',TAB,64,128);
  itemVisivel.intervalo=1500;
  inimigosOn=true;
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseUm(){
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseDois(){
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseTres(){
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseQuatro(){
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseCinco(){
}

//Definindo funcionalidades, dano da arma e vida dos inimigos
void faseChefao(){
}

//Chamar a classe menu (contem layout e botoes) e exibir botoes
void menu(){
  
  image(menuArq, 0, 0);
  textSize(32);
  
  //Inicio do jogo
  if(estado==0){
    //Desenha botoes do menu principal
    botJogar.desenhe();
    botInstrucoes.desenhe();
    botCreditos.desenhe();
    botSair.desenhe();
  }
  
  //Menu do reiniciar
  if(estado==2){
    //Botao recomeçar
  }
  //Imagem que ele passou de nivel
  if(estado==3){
    //Botao proximo nivel
  }
  //Imagem das instrucoes
  if(estado==4){
    //Botao Menu
  }
  
}

//O que fazer quando pressionar o mouse
void mousePressed(){  
}

//O que fazer quando soltar o mouse
void mouseReleased(){
}

//Executar a maquina de estado
void draw(){
  
  //Dependendo do estado
  dialogo = new Dialogo(0,0,"nomeArquivo"); 
  dialogo.desenhaDialogo();
}
