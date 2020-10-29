//Estrutando a classe
class time{
  //Definir variaveis
  private long ultimoTempo;
  private int intervalo;
  
  //Parametros a serem passados
  public time(int intervalo){
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
