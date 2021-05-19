/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
// Globais
import class SpriteKit.SKShapeNode
import class SpriteKit.SKLabelNode
import class SpriteKit.SKScene
import class SpriteKit.SKView
import struct SpriteKit.CGFloat
import struct SpriteKit.CGPoint
import struct SpriteKit.CGSize
import struct SpriteKit.TimeInterval

// Locais
import class Modules.Cell


/**
    # Ação e funcionamento do jogo
 
    Toda a lógica e funcionamento do jogo está nessa classe.
    
    ## Atributos
    
    |     Atributos     |                  Descrição                   |
    |:------------------|:---------------------------------------------|
    | willAlive         | Células que foram verificadas                |
    | aliveNodes        | Céluas vivas.                                |
    | allLabels         | Todos as labels.                             |
    | genSpeed          | Velocidade que passa as gerações.            |
    | gameStart         | Incialização das sequências das gerações.    |
    | generation        | Número da geração.                           |
    | renderTime        | Tempo de renderização do fps                 |
    | nodeCompared      | Célula vizinha que foi verificada.           |
    | positions         | Posições dos vizinhos.                       |
    |:------------------|:---------------------------------------------|
    
    ## Métodos
    
    |      Métodos      |                  Descrição                   |
    |:------------------|:---------------------------------------------|
    | didMove           | Configurações de quando a cena é carregada.  |
    | didChangeSize     | Configurações da tela.                       |
    | update            | Configuração e ação de cada frame (fps).     |
    | clickedCell       | Ação de quando clica em uma célula.          |
    | clickedLabel      | Ação de quando clica em uma label.           |
    | nextAction        | Ação do botão "next".                        |
    | pauseAction       | Ação do botão "pause".                       |
    | setGenSpeed       | Define a label de velocidade.                |
    | isNeighbor        | Verifica os vizinhos.                        |
    | survive           | Verificação de quem vive, nasce ou morre.    |
    | createLabel       | Cria e onfigura uma label.                   |
    |-------------------|----------------------------------------------|
*/
public class GameScene: SKScene {
    // Atributos da classe
    private var willAlive:[Cell] = []
    private var aliveNodes:[Cell] = []
    private var labels:[SKLabelNode] = []
    private var genSpeed:Double = 0.6
    private var gameStart:Bool = false
    private var generation:Int = 0
    private var renderTime:TimeInterval = 0.0
    private var nodeCompared:Cell = Cell()
    private let positions:[[CGFloat]] = [[35, 35], [0, 35], [-35, 35], [35, 0], [35, -35], [0, -35], [-35, -35], [-35, 0]]
    

    /**
        # Método [lifecycle]:
     
        Toda vez que a tela é carregada (inicializada) essas configuraçôes serão feitas.
    */
    public override func didMove(to view: SKView) -> Void {
        super.didMove(to: view)
        self.backgroundColor = #colorLiteral(red: 0.1353607475757599, green: 0.1353607475757599, blue: 0.1353607475757599, alpha: 1.0)
    }

    /**
        # Método [lifecycle]:
     
        Configurações feitas quando tem alguma alteração no tamanho de tela.
    */
    public override func didChangeSize(_ oldSize: CGSize) -> Void {
        self.removeAllChildren()
        self.aliveNodes = []
        self.labels = []
        
        // Criando as labels e posicionando
        var half:CGFloat = self.size.width / 2
        var posY:CGFloat = 50
        var spaceLateral:CGFloat = self.size.width.truncatingRemainder(dividingBy: 44.72)/2
        var rightLateral:CGFloat = self.size.width-spaceLateral
        
        self.labels.append(self.setLabel(text: "Game of Life",       font: 80, pos:[half, self.size.height - 90]))
        self.labels.append(self.setLabel(text: "􀊃 Start",            font: 40, pos:[spaceLateral+90, posY]))
        self.labels.append(self.setLabel(text: "􀰞 Next",            font: 40, pos:[half/2+70, posY]))
        self.labels.append(self.setLabel(text: "\(self.generation)", font: 40, pos:[half, posY]))
        self.labels.append(self.setLabel(text: "􀅉 Clear",           font: 40, pos:[half + half/2 - 70 , posY]))
        self.labels.append(self.setLabel(text: "􀯶",                  font: 40, pos:[rightLateral-150, posY]))
        self.labels.append(self.setLabel(text: "05",                 font: 40, pos:[rightLateral-92, posY]))
        self.labels.append(self.setLabel(text: "􀯻",                  font: 40, pos:[rightLateral-35, posY]))
        
        // Criando os nodes e posicionando
        var cell:Cell
        var spaceX:CGFloat = spaceLateral+40
        var spaceY:CGFloat = 160
        while (true) {
            cell = Cell(40, 40, 4)
            cell.setPositions(self.size.width-spaceX, self.size.height - spaceY)
    
            self.addChild(cell)
            spaceX += 45
            if (self.size.width-spaceX <= spaceLateral) {
                spaceX = spaceLateral+40
                spaceY += 45
                if spaceY >= self.size.height-150 {break}
            }
        }
    }

    /**
        # Método [lifecycle]:
     
        Ação de cada frame que acontece (fps).
    */
    public override func update(_ currentTime: TimeInterval) -> Void {
        if (gameStart) {
            if (currentTime > self.renderTime) {
                self.nextAction()
                self.renderTime = currentTime + self.genSpeed
            }
        }
    }
    
    /**
        # Método:
     
        Ação de quando clica em uma célula, alterna entre dar a "vida" ou matar ela.
        
        ## Parâmetro:
     
        `Cell` s: célula clicada
    */
    func clickedCell (_ c:Cell) -> Void {
        if (c.isAlive()) {
            c.setAlive(false)
            for i in 0..<self.aliveNodes.count {
                if (c == self.aliveNodes[i]) {
                    self.aliveNodes.remove(at: i)
                    break
                }
            }
        } else {
            c.setAlive(true)
            self.aliveNodes.append(c)
        }
    }
    
    /**
        # Método:
     
        Ação de quando clica em uma label.
        
        ## Parâmetro:
     
        `SKLabelNode` l: label clicada.
    */
    public func clickedLabel (_ l:SKLabelNode) -> Void {
        switch l {
            case self.labels[1]:
                if (!self.gameStart) {
                    self.gameStart = true
                    self.labels[1].text = "􀊅 Pause"
                }else{self.pauseAction()}
                
            case self.labels[2]: self.nextAction()
            case self.labels[4]:
                for s in self.aliveNodes {self.clickedCell(s)}
                self.pauseAction()
                
            case self.labels[5]: self.setGenSpeed(speed: 0.1)
            case self.labels[7]: self.setGenSpeed(speed: -0.1)
            default: return
        }
    }
    
    /**
        # Método:
     
        Ação do botão `next`, resposável por avançar uma geração.
    */
    private func nextAction() -> Void {
        self.generation += 1
        self.labels[3].text = "\(self.generation)"
        self.survive()
    }
    
    /**
        # Método:
     
        Ação do botão `pause`, resposável por pausar a reprodução contínua de gerações.
    */
    private func pauseAction() -> Void {
        self.gameStart = false
        self.labels[1].text = "􀊃 Start"
    }
    
    /**
        # Método:
     
        Define a velocidade que passa as sequências.

    */
    private func setGenSpeed(speed:Double) -> Void {
        if (self.genSpeed + speed < 0.1 || self.genSpeed + speed > 1){return}
        self.genSpeed += speed
        var newSpeed:Int = Int(11-(self.genSpeed*10))
        if (newSpeed < 10) {self.labels[6].text = "0\(newSpeed)"}
        else {self.labels[6].text = "\(newSpeed)"}
    }
    
    /**
        # Método:
     
        Verifica os vizinhos ao redor.

        ## Retorno:
     
        `Bool`: `true`- tem vizinho ou `false`- não tem vizinho.
    */
    private func isNeighbor(_ l:CGPoint) -> Bool {
        guard let neighNode = self.nodes(at:l).first as? Cell else {return false}
        self.nodeCompared = neighNode
        return true
    }
    
    /**
        # Método:
     
        Verifica e define quem vai continuar vivo, quem vai nascer e quem vai morrer
    */
    private func survive() -> Void {
        var pos:[CGFloat]
        var vizi:Bool = false
        
        // Verifica os vizinhos das células vivas
        for s in self.aliveNodes {
            pos = s.getPositions()
            for p in positions {
                if (self.isNeighbor(CGPoint(x: pos[0] + p[0], y: pos[1] + p[1]))) {
                    if(self.nodeCompared.isChecked() != true) {
                        self.nodeCompared.setChecked(true)
                        self.willAlive.append((self.nodeCompared))
                    }
                    self.nodeCompared.setNeighbors(1)
                    if (self.nodeCompared.isAlive()){vizi=true}
                }
            }
            // Caso para uma célula viva sozinha
            if (!vizi) {self.willAlive.append(s)}
            else {vizi = false}
        }
        
        // Verifica quem vive e quem morre
        for s in self.willAlive {
            // Condição do jogo
            if (s.isAlive() && (s.getNeighbors() < 2 || s.getNeighbors() > 3)) || (!s.isAlive() && s.getNeighbors() == 3) {
                self.clickedCell(s)
            }
            s.setChecked(false)
            s.setNeighbors(-s.getNeighbors())
        }
        self.willAlive = []
    }
    
    /**
        # Método:
     
        Configura as labels

        ## Retorno:
     
        ``SKLabelNode`: label configurada.
    */
    private func setLabel(text:String, font:CGFloat, pos:[CGFloat]) -> SKLabelNode {
        var lbl:SKLabelNode = SKLabelNode()
        lbl.text = text
        lbl.fontSize = font
        lbl.color = #colorLiteral(red: 0.9999018311500549, green: 1.0000687837600708, blue: 0.9998798966407776, alpha: 1.0)
        
        lbl.position.x = pos[0]
        lbl.position.y = pos[1]
        self.addChild(lbl)
        return lbl
    }
}
