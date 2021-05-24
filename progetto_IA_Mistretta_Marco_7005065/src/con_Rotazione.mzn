include "alldifferent.mzn";

%%%%%%%%% PARAMETRI %%%%%%%%%
int: n;  % numero di righe
int: m; % numero di colonne
int: k; % numero di colori a disposizione

% CONTROLLO IMMISSIONE PARAMETRI
constraint assert(n >= 0,"Invalid datafile: "++"number of rows must be non-negative");
constraint assert(m >= 0,"Invalid datafile: "++"number of columns must be non-negative");
constraint assert(k >= 0,"Invalid datafile: "++"number of colors must be non-negative");

array[1..n*m, 1..4] of int: colors;

%%%%%%%%% VARIABILE %%%%%%%%% 
%    N
%  W   E
%    S
% solution[i, j] :: "il numero identificativo (1-nm) del quadrato che dovrà prendere la 
% posizione i-j-esima nella matrice ai fini di risolvere tale problema
array[1..n, 1..m] of var int: solution;
% array[i, j] :: la rotazione che dovrà presentare il quadrato che prenderà la
% posizione i-j-esima nella matrice ai fini di risolvere tale problema
array[1..n, 1..m] of var int: rotation;

%%%%%%%%% CONSTRAINTS %%%%%%%%%  
% vincolo di dominio di solution[i, j] :: [1, nm]
constraint
  forall (i in 1..n, j in 1..m) (
    solution[i, j] >= 1 /\ solution[i,j] <= n*m
  );

% vincolo di dominio di rotation[i, j] :: [0, 3]
% 0 -> nessuna rotazione
% 1 -> rotazione di pi/2 antioraria
% 2 -> rotaione di pi antioraria
% 3 -> rotazione di 3*pi/2 antioraria
constraint
  forall (i in 1..n, j in 1..m) (
    rotation[i, j] >= 0 /\ rotation[i,j] <= 3
  );
  
constraint alldifferent(solution);   

% vincolo di tipo matematico aggiuntivo
constraint
  sum (i in 1..n, j in 1..m)(solution[i, j]) = m*n*(m*n+1)/2;

% se un quadrato presenta il lato destro di un colore ->
% il quadrato alla sua destra (se presente) dovrà avere il lato sinistro dello stesso colore
% notare l'aggiunta di "+rotation" & "mod 4"
% questo vincolo lega in modo diretto un particolare quadrato "che risolve una posizione"
% alla rotazione stessa che il quadrato dovrà presentare in tale posizione  
constraint
  forall (i in 1..n, j in 1..m-1) (
      colors[solution[i, j],(1+rotation[i, j]) mod 4 + 1] = colors[solution[i, j+1],(3+rotation[i, j+1]) mod 4 + 1]     
      );
     

% se un quadrato presenta il lato inferiore di un colore ->
% il quadrato sottostante (se presente) dovrà avere il lato superiore dello stesso colore
% notare l'aggiunta di "+rotation" & "mod 4"
% questo vincolo lega in modo diretto un particolare quadrato "che risolve una posizione"
% alla rotazione stessa che il quadrato dovrà presentare in tale posizione
constraint
  forall (i in 1..n-1, j in 1..m) (
      colors[solution[i, j],(2 +rotation[i, j]) mod 4 + 1] = colors[solution[i+1, j],(rotation[i+1, j]) mod 4 + 1]
      );  

% risolve il problema di risoluzione di vincoli:
% si ferma alla prima istanza di soluzione trovata in caso di esito positivo
% ritorna "INSODDISFACIBILE" in caso in cui la particolare istanza, assegnatagli da risolvere, 
% non ammetta soluzione      
solve satisfy;    

 
output[ show(solution[i,j]) ++ "(" ++ show(rotation[i, j]) ++ ")" ++ if ((j mod m) = 0) then "\n" else " " endif | i in 1..n, j in 1..m  ] 
% output []


