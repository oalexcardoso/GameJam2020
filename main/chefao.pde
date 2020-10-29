//Estrutando a classe
class chefao extends personagem{
  //Definir variaveis
  float dx,dy;
  int vida;
  time t;
  
  //Parametros a serem passados
  public chefao(PImage img, float posX, float posY, char tEsq, char tDir, char tCim, char tBai, int lar, int alt){
    //Quando definir vai funcionar sem erro
    super(img, posX, posY, tEsq, tDir, tCim, tBai, lar, alt);
    decideMovimento();
    vida=30;
    t = new time(500);
  }
  
  //Retirar vida apos tomar tiro
  void sofreDano(){
    vida--;
  }
  
  //Analisar se ainda tem vida
  boolean vivo(){
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
  }
  
}
