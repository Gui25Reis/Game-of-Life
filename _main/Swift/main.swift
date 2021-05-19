//#-hidden-code
/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
// Globais
import class PlaygroundSupport.PlaygroundPage

// Locais
import class Modules.GameViewController

PlaygroundPage.current.setLiveView(GameViewController())
//#-end-hidden-code
/*:
 # John Conway’s Game of Life
 ## A cellular automaton.

 This game consists of a collection of cells which, based on a few mathematical rules, can live, die or multiply.

 ___
 ## Rules
 - For a living cell (yellow): if it has two or three living neighboring cells, it will live.
 - For a non-living cell (grey): if it has three living neighboring cells, it will live.

 ___
 ## Buttons
 - "Start/Pause": Start/pause the sequence of generations.
 - "Next": go to the next generation.
 - "Clear": Pauses and kill all the living cells
 - "<": Slows down
 - ">": Increases speed
 
 ___
 ## References
 [Play game of life](https://playgameoflife.com/info)
 
 # About me
 On my [GitHub](https://github.com/Gui25Reis), the [code](https://github.com/Gui25Reis/Game-of-Life) and its documentation are available, as well as a little about me. Feel free to fork or give a star.
*/
