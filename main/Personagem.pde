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
    g = 1.2;
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
