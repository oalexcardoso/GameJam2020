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
