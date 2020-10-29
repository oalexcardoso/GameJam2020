//Estrutando a classe
class personagem{
  //Posição do personagem na tela
  public PVector pos;
  //Numero do quadro sendo exibido
  protected int quadro;
  //Referência pra imagem do personagem
  private PImage sprites;
  //Velocidade do personagem
  private float vel;
  //Teclas para controlar
  private char tEsq, tDir, tCim;
  //Largura e Altura de um sprite (64x64)
  protected int lar, alt; 
  protected time tAnimacao;
  ArrayList<tiro> tiros;
  time tTiro;
  int cadenciaTiro;
  int pontuacao;
  
  //Parametros a serem usados
  public personagem(PImage img, float posX, float posY, char tEsq, char tDir, char tCim, int lar, int alt){
    this.lar=lar;
    this.alt=alt;
    this.tEsq=tEsq;
    this.tDir=tDir;
    this.tCim=tCim;
    pos = new PVector(posX, posY);
    sprites = img;
    //Exibir quadro inicial
    quadro=7;
    //Setar velocidade do jogador
    vel=3.5;
    tAnimacao = new time(1000/6);
    tiros=new ArrayList<tiro>();
    cadenciaTiro=450;
    tTiro = new time(cadenciaTiro);
  }
  
  public void atira(){
    if(tTiro.disparou())
      tiros.add(new tiro(getCenterX(),getCenterY(),12,3));
  }
  
  public void desenhe() {
    for(tiro t: tiros){
      t.movimente();
      t.desenha();
    }
    
    //Atulizando posiçoes
    int px=(quadro%2)*lar;
    int py=(quadro/2)*alt;
    image(sprites.get(px,py,lar,alt),pos.x,pos.y);
    
  }
  
  //Definir quadro para a movimentação do personagem
  public void anime() {
    if(tAnimacao.disparou()){
      
      if(teclas[tCim]){
        if(quadro<4||quadro>5)
          quadro=4;
      }
      else if(teclas[tEsq]){
        if(quadro<2||quadro>3)
          quadro=2;
      }
      else if(teclas[tDir]){
        if(quadro<6||quadro>7)
          quadro=6;
      }
      
      quadro++;
      
      if(quadro%2==0)
        quadro=quadro-2;
    }
  }
  
  //Analide da movimentação do personagem na tela
  public void movimente(Mapa layer){
    if(teclas[tCim]){
      pos.y-=vel;
      
      if(layer.colidiu((int)pos.x,(int)pos.y,(int)pos.x+lar,(int)pos.y)){
        pos.y=pos.y+(layer.getTileAlt()-pos.y%layer.getTileAlt());
      }
    }
    
    if(teclas[tEsq]){
      pos.x=pos.x-vel;
      
      if(layer.colidiu((int)pos.x,(int)pos.y,(int)pos.x,(int)pos.y+alt)){
        pos.x=pos.x+(layer.getTileLar()-pos.x%layer.getTileLar());
      }
    }
    
    if(teclas[tDir]){    
      pos.x=pos.x+vel;
      
      if(layer.colidiu((int)pos.x+lar,(int)pos.y,(int)pos.x+lar,(int)pos.y+alt)){
        pos.x=pos.x-pos.x%layer.getTileLar();
      }
    }
  }
  
  public float getCenterX(){
    return pos.x+lar/2;
  }

  public float getCenterY(){
    return pos.y+alt/2;
  }
  
}
