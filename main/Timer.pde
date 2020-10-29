//Estrutando a classe
class Timer{
  //Definir variaveis
  private long ultimoTempo;
  private int intervalo;
  
  //Parametros a serem passados
  public Timer(float intervalo){
    ultimoTempo = millis();
    this.intervalo = intervalo;
  }
  
  //Ver se x ação ocorreu a x tempo
  public boolean disparou(){
    long tempoAtual = millis();
    if(tempoAtual-ultimoTempo>=intervalo){
      ultimoTempo=tempoAtual;
      return true;
    }
    return false;
  }
  
  //Resetar a contagem
  public void reseta(){
      ultimoTempo = millis();
  }
  
}
