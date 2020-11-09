class Mapa{
  //Largura e Altura Mapa (16x10)
  int lar,alt; 
  //Arquivo Mapa
  PImage tImage; 
  //Largura e Altura de um tile em pixels (64x64)
  int tLar, tAlt; 
  byte[] b;
  byte[][] layer;
  
  //Variavel de varredura de colisao
  public int posY, posX;
  
  //Parametros a serem passados
  public Mapa(int l, int a, String nomeArquivo, int tLar, int tAlt, PImage tImage){
    lar=l;
    alt=a;
    this.tAlt=tAlt;
    this.tLar=tLar;
    this.tImage=tImage;
    b = loadBytes(nomeArquivo);
    
    layer = new byte[alt][lar];
    
    for(int i=0;i<b.length;i++){
      layer[i/lar][i%lar]=b[i];
    }
    
    //Faz a varredura no eixo Y até que encontre uma camada de colisao    
    int i;
    
    for(i=0;i<alt;i++){
        if(layer[i][0]!=-1){
            posY=i*64;
            break;
        }
     }
    
    //Faz a varredura do eixo X até que encontre o final do eixo de colisao
      for(int j=0;j<lar;j++){        
        if(layer[(posY/64)][j]!=1){
            posX=j*64;
            break;
        }
      }
      
      print("\nposX: ", posX);
      print("\nposY: ", posY);
      
  } 
  
  //Varrer a matriz do mapa e desenhar
  public void desenhe(){
    for(int i=0; i<alt;i++){
      for(int j=0; j<lar; j++){
        if(layer[i][j]!=-1)
          image(tImage.get(layer[i][j]*tLar,0,tLar,tAlt),j*tLar,i*tAlt);
      }
    }
  }
  
  //Tratar a camada de colisao e analisar
  boolean colidiu(int xi, int yi, int xf, int yf){
    xi=xi/tLar;
    xf=(xf-1)/tLar;
    yi=yi/tAlt;
    yf=(yf-1)/tAlt;
    
    if(xi<0)
      xi=0;
      
    if(yi<0)
      yi=0;
    
    if(xf<0)
      xf=0;
    
    if(yf<0)
      yf=0;
    
    if(xi>lar-1)
      xi=lar-1;
    
    if(xf>lar-1)
      xf=lar-1;
    
    if(yi>alt-1)
      yi=alt-1;
    
    if(yf>alt-1)
      yf=alt-1;
   
    for(int i=xi;i<=xf;i++){
      for(int j=yi;j<=yf;j++){
        if(layer[j][i]!=-1){
          return true;
        }
      }
    }
    return false;
  }
  
  //Pegar alt do tile
  public int getTileAlt(){
    return tAlt;
  }
  
  //Pegar lar do tile
  public int getTileLar(){
    return tLar;
  }
  
}
