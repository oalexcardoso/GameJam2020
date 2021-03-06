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
