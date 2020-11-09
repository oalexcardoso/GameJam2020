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
  boolean clicado(){
    //Retornando verificacoes
    return (mouseX>x && mouseX<x+lar && mouseY>y && mouseY<y+alt);
  }
  
  //Deixa botao com cor diferente
  void destaque(){
    //Mudando estado do botao
    pressionado=true;
  }
    
  //Tira a cor diferente do botao
  void removeDestaque(){
    //Mudando estado do botao
    pressionado=false;
  }
    
  //Desenhar botoes
  void desenhe(){
      //Preenchimento do botao
      fill(255,0,0,255);
  }
  
}
