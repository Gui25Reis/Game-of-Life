/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
// Globais
import class SpriteKit.UIViewController
import class SpriteKit.UITouch
import class SpriteKit.UIEvent
import class SpriteKit.SKView
import class SpriteKit.SKLabelNode

// Locais
import class Modules.GameScene
import class Modules.Cell
/**
    # Configurações da cena
 
    Configurações do que acontece na tela e como reagir às ações que ocorrem ao longo do programa.
 
    ## Atributos
    
    |     Atributos     |                     Descrição                     |
    |:------------------|:--------------------------------------------------|
    | scene             | Tela de jogo e as funcionalidades.                |
    |-------------------|---------------------------------------------------|
    
    ## Métodos
    
    |      Métodos      |                     Descrição                     |
    |:------------------|:--------------------------------------------------|
    | viewDidLoad       | Configurações de quando a cena é carregada.       |
    | touchesBegan      | Ação de quando clica na tela.                     |
    |-------------------|---------------------------------------------------|
*/
public class GameViewController: UIViewController {
    // Atributos da classe
    private let scene = GameScene()
    
    /**
        # Método [lifecycle]:
     
        Toda vez que a tela é carregada (inicializada) essas configuraçôes serão feitas.
    */
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()                                 // Chama a função original
        let view = SKView()                                 // Cria uma view
        scene.scaleMode = .resizeFill                       // Adapta a cena pra tela mostrada
        view.presentScene(scene)                            // Mostra a cena criada
        //view.showsFPS = true                                // Mostra o fps
        //view.showsNodeCount = true                          // Mostra a quantidade de nodes que tem
        self.view = view                                    // Define a cena
    }
    
    /**
        # Método:
     
        Ação de quando clica na tela.
    */
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        touches.forEach { touch in
            let location = touch.location(in: scene)
            
            // Verifica em que foi clicado
            if let touchNode = scene.nodes(at: location).first as? Cell {
                scene.clickedCell(touchNode)
            } else if let touchNode = scene.nodes(at: location).first as? SKLabelNode {
                scene.clickedLabel(touchNode)
            }
        }
    }
}
