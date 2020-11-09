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
  
  void desenhaDialogo()
  {                
    //Corta a imagem com o get(x que comeca, y que comeca, comprimento, altura)
    image(dialogoX,0,0);
  }    
}
