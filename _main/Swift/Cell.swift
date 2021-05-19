/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
// Globais
import class SpriteKit.SKShapeNode
import struct SpriteKit.CGFloat
import struct SpriteKit.CGSize

/**
    # Criação das células.
 
    Criação e configuração das células.
    
    ## Atributos
    
    |     Atributos     |             Descrição             |
    |:------------------|:----------------------------------|
    | alive             | Estado de vida: viva ou morta.    |
    | checked           | Se foi verificada.                |
    | neighbors         | Quantidade de vizinhos vivod.     |
    |-------------------|-----------------------------------|
    
    ## Métodos
    
    |      Métodos      |             Descrição             |
    |:------------------|:----------------------------------|
    | setPositions      | Define a posição da célula.       |
    | getPositions      | Retorna a posição da célula.      |
    | setAlive          | Define se está viva ou morta.     |
    | isAlive           | Verifica se está viva ou morta.   |
    | setChecked        | Define se foi verificada.         |
    | isChecked         | Verifica se se foi verificada.    |
    | setNeighbors      | Define a quantidade de vizinhos.  |
    | getNeighbors      | Verifica quantos vizinhos têm.    |
    |-------------------|-----------------------------------|
*/
class Cell:SKShapeNode {
    // Atributos da classe
    private var alive:Bool = false
    private var checked:Bool = false
    private var neighbors :Int = 0
    
    /**
        # Construtor:
     
            Configurações inicais da célula:
            - Define o tamanho do quadrado;
            - Tira a borda;
            - Coloca a cor de estado inicial (cinza);
    */
    public convenience init(_ w: CGFloat, _ h: CGFloat, _ r: CGFloat) {
        self.init(rectOf: CGSize(width: w, height: h), cornerRadius:r)
        self.lineWidth = 0
        self.fillColor = #colorLiteral(red: 0.37470948696136475, green: 0.37477749586105347, blue: 0.3747006058692932, alpha: 1.0)
    }
    
    /**
        # Destrutor:
     
        Limpa os atributos da classe.
    */
    deinit {
        self.alive = false
        self.checked = false
        self.neighbors  = 0
    }
    
    /**
        # Método especial:
     
        Define as posições de x e y.
        
        ## Parâmetros:
     
        `CGFloat` x_: posição em x.
        `CGFloat` y_: posição em y.
    */
    public func setPositions(_ x:CGFloat, _ y:CGFloat) -> Void {
        self.position.x = x
        self.position.y = y
    }
    
    /**
        # Método especial:
     
        Rotorna uma a posição da célula.

        ## Retorno:
     
        `List`: [posição de x, posição de y]
    */
    public func getPositions() -> [CGFloat] {return [self.position.x, self.position.y]}
    
    /**
        # Método especial:
     
        Define se está viva o morta.
        
        ## Parâmetros:
     
        `Bool` b: `true` pra viva ou `false` para morta.
    */
    public func setAlive(_ b:Bool) -> Void {
        if (b) {
            self.alive = true
            self.fillColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0.0, alpha: 1.0)
        }else{
            self.alive = false
            self.fillColor = #colorLiteral(red: 0.3747495114803314, green: 0.3747495114803314, blue: 0.3747495114803314, alpha: 1.0)
        }
    }
    
    /**
        # Método especial:
     
        Mostra se está viva o morta.
        
        ## Retorno:
     
        `Bool`: `true` pra viva ou `false` para morta.
    */
    public func isAlive() -> Bool {return self.alive}
    
    /**
        # Método especial:
     
        Define se foi verificada.
        
        ## Parâmetros:
     
        `Bool` b: `true` pra sim ou `false` para não.
    */
    public func setChecked(_ b:Bool) -> Void {self.checked = b}

    /**
        # Método especial:
     
        Mostra se foi verificada.
        
        ## Retorno:
     
        `Bool` b: `true` pra sim ou `false` para não.
    */
    public func isChecked() -> Bool {return self.checked}
    
    /**
        # Método especial:
     
        Define a quantidade de vizinhos.
        
        ## Parâmetros:
     
        `Int` n: número que vai ser somado com o que já tem.
    */
    public func setNeighbors(_ n:Int) -> Void {self.neighbors += n}

    /**
        # Método especial:
     
        Mostra a quantidade de vizinhos.
        
        ## Retorno:
     
        `Int`: quantidade de vizinhos
    */
    public func getNeighbors() -> Int {return self.neighbors }
}
