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
  
  void sofreDano(){
    vida--;
  }
  
  boolean vivo(){
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
