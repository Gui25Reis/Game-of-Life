/* Gui Reis     -    gui.sreis25@gmail.com */

// - Bibliotecas:
#include <stdio.h>      // standard in out  .head (padrão entrada saída .cabeça)
#include <stdlib.h>     // standard library .head (biblioteca padrão .cabeça)
#include <stdbool.h>    // standard boolean .head (padrão booleano .cabeça)

//      Funções:

// Criação da matriz
char **cria_matriz (int l, int c);
void insert_matriz (char **m, int l, int c);

// Funcionamento do jogo
void life_death (char **m, int l, int c);
void att_matriz (char **m, int l, int c);

// Validação das entradas
int verifica (int min, int max, int cond);

// Impressão do tabuleiro
void borda_lin (int);
void num_lin (int);
void pula_lin (int);
void print (char **, int, int);


int main(){
    int numL, numC;                                                                 // Tamanho do tabuleiro
    int cel_L, cel_C;                                                               // Posições das células
    int quant, cont = 0;                                                            // Quantidade de impressões

    printf("\n\t\tJogo da Vida - Crowler");                                         // Menu: regras e instruções
    printf("\n\n\n\tInstrucoes: \
\n-> Nesse programa voce faz a personalizacao, definindo: \
\n  - O tamanho do tabuleiros (10x10 - 25x25); \
\n  - As celulas iniciais; \
\n  - Numero de frames a ser mostrado; \
\
\n\n\n\tRegras do jogo: \
\n.Para um espaco preenchido: \
\n  - Cada celula com um ou nenhum vizinho morre, como se por solidao. \
\n  - Cada celula com quatro ou mais vizinhos morre, como se por superpopulacao. \
\n  - Cada celula com dois ou tres vizinhos sobrevive. \
\n\n.Para um espaco vazio ou não preenchido \
\n  - Cada celula com tres vizinhos fica preenchida. \n\n");

    system("pause");

    printf("\n\n\n\tConfiguracoes iniciais: ");                                    // Configuração: tamanho do tabuleiro 
    printf("\n\nDigite o tamanho do tabuleiro (min: 10x10 - max: 25x25) \n");
    printf("\n   **OBS: Digite o numero seguido pela tecla 'enter': \n\n");

    printf("Linha: ");  numL = verifica(10, 35, 10+1);
    printf("Coluna: "); numC = verifica(10, 35, 10+1);


    char **mat = cria_matriz(numL, numC);                                           // Criação da matriz (2d)

    insert_matriz(mat, numL, numC);                                                 // Coloca valores nela: " "

    system("cls");
    print(mat, numL, numC);                                                         // Imprime o tabuleiro
    

    while (true) {                                                                  // Loop: quant. de células a ser add
        printf("\n\nEscolha uma posicao para pressionar uma celula: ");
        printf("\nQuando termina: digite -1 \n");
        printf("\n   **OBS: Digite o numero seguido pela tecla 'enter': \n\n");

        printf("Linha: ");  cel_L = verifica(0, numL, -1);

        if (cel_L == -1) break;                                                     // -1: continua o porgrama (roda o programa)
        printf("Coluna: "); cel_C = verifica(0, numC, -1);

        mat[cel_L-1][cel_C-1] = 'O';                                                // Ao definir a cel: coloca "O" no lugar solicitado

        print(mat, numL, numC);                                                     // Mostra o tabuleiro
    }

    printf("\nQuantas impressoes deseja ver ? (min: 5 - max: 50): ");               // Pede a quant de impressões
    quant = verifica(5, 50, 5+1);    

    system("cls");
    print(mat, numL, numC);

    while (cont != quant) {                                                         // Loop: mostra o jogo (rodando)
        life_death (mat, numL, numC);                                               // verifica quem vive/nasce/morre
        att_matriz (mat, numL, numC);                                               // atualiza a matriz
        print(mat, numL, numC);                                                     // mostra ela
        cont ++;
    }
    
    for(int i;i < numL;i++) free(mat[i]);                                           // Desaloca (da memória) as "colunas"
    free(mat);                                                                      // Desaloca (da memória)as "linhas"

    printf("\n\n");
    system("pause");
    return 0;
}

// Função: cria uma matriz 2b (alocação dinâmica)
char **cria_matriz (int l, int c){                                                  
    char **mat = (char **) malloc(l * sizeof(char *));                                  // Cria um vetor que guarda X vetores tipo CHAR
    int i;
    
    for (i = 0; i < l; i++)
        mat[i] = (char *) malloc (c * sizeof(char));                                    // Define que cada vetor gurada X tipo CHAR
    return mat;
}

// Função: insere "dados limpos" na matriz
void insert_matriz (char **m, int l, int c){                                        
    int i, j;
    for (i = 0; i < l; i++){
        for (j = 0; j < c; j++)
        m[i][j] = ' ';                                                                 // Cada cel da matriz = " " (espaço em branco)
    }
}


// Função: valida (parcialmente) a entrada
int verifica (int min, int max, int cond) {                                         
    int ent;
    while (true) {
        scanf("%d", &ent);                                                              // Pede a entrada
        if (ent >= min && ent <= max && ent != 0 || ent == cond) return ent;            // Validação: se ela estiver dentro do intervalo pedido
        else {
            printf("\nValor invalido; \nDigite entre %d - %d: ", min, max);             // Pede de novo, caso não seja a correta
        } 
    }
}

/* Funções: Funcionamento do jogo: */

// Função: verifica quem morre/vive/nasce
void life_death (char **m, int l, int c){                                           
    int lin, col;                                                                       // linha e coluna
    int i, j;                                                                           // posição da linha e da coluna
    int aux_I, aux_J;                                                                   // posições da linha e da coluna (vizinhas)
    int viz = 0;                                                                        // quant. de vizinhos

    for (lin = 0; lin < l; lin++){                                                      // For: entra na linha
        for (col = 0; col < c; col++) {                                                 // For: entra na coluna
            for (i = -1; i < 2; i++){                                                   // For: pega a posição da linha
                for (j = -1; j < 2; j++){                                               // For: pega a posição da coluna
                    aux_I = lin + i;
                    aux_J = col + j;
                    if (aux_I >= 0 && aux_I < l && aux_J >= 0 && aux_J < c) {           // Tira as bordas que não existem
                        if (aux_I != lin || aux_J != col) {                             // Não pode ser a mesma posição
                            if (m[aux_I][aux_J] != ' ' && m[aux_I][aux_J] != 'V') viz++;// Verifica se tem vizinhos (já "vivos")
                        }
                    }
                }
            }
            if (m[lin][col] != ' ' && m[lin][col] != 'V') {
				if (viz != 2 && viz != 3) m[lin][col] = 'M'; }     					    // Cel já viva : Verifica se a cel viva vai morrer
            else { if (viz == 3) m[lin][col] = 'V'; }                                   // Cel não viva: Verifica se alguma cel vai nascer
            viz = 0;                                                                    // Zera a variável
        }
    }
}

// Função: cria a nova geração
void att_matriz (char **m, int l, int c){
    int i, j;                                                                           
    for (i = 0; i < l; i++){                                                            // For: acessa a linha
        for (j = 0; j < c; j++)                                                         // For: acessa a coluna
            if (m[i][j] == 'M') m[i][j] = ' ';                                          // Cel morreu: deixa vazia
            else if (m[i][j] == 'V') m[i][j] = 'O';                                     // Cel nasceu: sinaliza ("O");
    }
}

/* Funções: Impressão do tabuleiro: */

// Função: printa o tabuleiro
void print (char **m, int lin_, int col_) {
    printf("\n\n\n");
    num_lin(col_);                                                                      // Função: números da coluna
    borda_lin(col_);                                                                    // Função: monta a borda horizontal (inicial)

    for (int L = 0; L < lin_; L++) {                                                    // For: monta as linhas
        if (L < 9) printf ("\n\t %d |   ", L+1);                                        // Números < 9 tem um espaço diferente
        else printf ("\n\t%d |   ", L+1);

        for (int C = 0; C < col_; C++) {                                                // For: print dos valores da matriz
            printf("%c", m[L][C]);                                                      // Printa o valor da matriz
            if (C != col_ - 1) printf (" | ");                                          // Acrescenta as divisões
        }
        printf ("   |");                                                                // Borda vertical
        if (L != lin_-1) {pula_lin(col_);};                                             // Entre linhas pontilhadas
    };
    borda_lin(col_);                                                                    // Função: monta a borda horizontal (final)
}

/* Funções auxiliares para o tabuleiro */

// Função: imprimi o indice da coluna
void num_lin (int col_) {                                                           
    printf ("\t       ");
    for (int i = 0; i < col_ ; i++) {
        if (i < 8) printf ("%d   ", i+1);                                           // Números < 8 tem um espaçamento diferente
        else printf ("%d  ", i+1);
    }
}

// Função: imprime as bordas (horizontais)
void borda_lin (int col_){ printf ("\n\t    ");   for (int i = 0; i < (4*col_)+3 ; i++) printf ("-"); }

// Função: imprime as divisões das linhas
void pula_lin (int col_) { printf ("\n\t      "); for (int i = 0; i < col_; i++) printf("--- "); }