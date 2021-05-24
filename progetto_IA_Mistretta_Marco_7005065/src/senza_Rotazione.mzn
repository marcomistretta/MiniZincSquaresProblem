%%%%%%%%% PARAMETRI %%%%%%%%%
int: n;  % numero di righe
int: m; % numero di colonne
int: k; % numero di colori a disposizione


% CONTROLLO IMMISSIONE PARAMETRI
constraint assert(n >= 0,"Invalid datafile: "++"number of rows must be non-negative");
constraint assert(m >= 0,"Invalid datafile: "++"number of columns must be non-negative");
constraint assert(k >= 0,"Invalid datafile: "++"number of colors must be non-negative");

array[1..n*m, 1..4] of int: colors;
%%%%%%%%% VARIABILI %%%%%%%%% 
%    N
%  W   E
%    S
% solution[i, j] = "il numero identificativo (1-nm) del quadrato che dovrà prendere la 
% posizione i-j-esima nella matrice ai fini di risolvere tale problema
array[1..n, 1..m] of var int: solution;

%%%%%%%%% VINCOLI %%%%%%%%%  
% vincolo di dominio di solution[i, j] :: [1, nm]
constraint
  forall (i in 1..n, j in 1..m) (
    solution[i, j] >= 1 /\ solution[i,j] <= n*m
  );
 
include "alldifferent.mzn";
constraint alldifferent(solution);   

% vincolo di tipo matematico aggiuntivo
constraint
  sum (i in 1..n, j in 1..m)(solution[i, j]) = m*n*(m*n+1)/2;
  
% se un quadrato presenta il lato destro di un colore ->
% il quadrato alla sua destra (se presente) dovrà avere il lato sinistro dello stesso colore
constraint
  forall (i in 1..n, j in 1..m-1) (
      colors[solution[i, j], 2] = colors[solution[i, j+1], 4]
  );


% se un quadrato presenta il lato inferiore di un colore ->
% il quadrato sottostante (se presente) dovrà avere il lato superiore dello stesso colore
constraint
  forall (i in 1..n-1, j in 1..m) (
      colors[solution[i, j], 3] = colors[solution[i+1, j], 1]
  );

% risolve il problema di risoluzione di vincoli:
% si ferma alla prima istanza di soluzione trovata in caso di esito positivo
% ritorna "INSODDISFACIBILE" in caso in cui la particolare istanza, assegnatagli da risolvere, 
% non ammetta soluzione
solve satisfy;     

output [ show(solution[i,j]) ++ if ((j mod m) = 0) then "\n" else " " endif | i in 1..n, j in 1..m ]

