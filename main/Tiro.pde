//Estrutando a classe
class Tiro{
  //Definir variaveis
  float velocidade;
  float posX, posY;
  float dx,dy;
  float raio;
  
  //Parametros a serem passados
  public Tiro(float posX, float posY, float v, float r){
    this.posX=posX;
    this.posY=posY;
    velocidade=v;
    raio=r;
    
    //Ver para que lado o personagem esta virado e lançar tiro reto
  }
  
  //Deslocamento da bala
  public void movimente(){
    posX+=dx;
    posY+=dy;
  }
  
  //Desenhar o tiro na tela
  public void desenha(){
    ellipse(posX,posY,raio*2,raio*2);
  }
  
}
