# Quadrati colorati
***
In questo esercizio si costruisce un modello **MiniZinc** per risolvere il seguente puzzle:
- Sono dati nm quadrati con lati colorati (con colori scelti da un insieme di dimensione k). Il problema consiste nel disporre i quadrati su una griglia n per m in modo tale che i lati adiacenti
siano sempre dello stesso colore. 
***
Sono state sviluppate due varianti:
- una nella quale i quadrati possono essere ruotati
- l’altra dove le rotazioni non sono ammesse

## Guida all'utilizzo
Si consiglia l'utilizzo del risolutore Geocode 6.3.0 sia nel caso in cui si voglia eseguire il programma tramite interfaccia IDE, sia nel caso in cui si voglia farlo da linea di comando.

### Da MiniZincIDE

Nella cartella ***src\dataset*** sono presenti i file *.dzn* da eseguire/compilare
assieme al file ***src\con_Rotazione.mzn*** oppure al file ***src\senza_Rotazione.mzn*** 
a seconda che si voglia risolvere il **Problema de I Quadrati Colorati** con o senza l'ausilio di rotazione dei 
quadrati stessi.

### Avvio da terminale
Da terminale è possibile eseguire il programma con l'ausilio del comando:
```sh
$ minizinc --solver Gecode con_Rotazione.mzn dataset.dzn
```
## Guida all'interpretazione dei risultati stampati su schermo
La variante che non permette rotazioni stampa a schermo la matrice n per  m che presenta in posizione i-j-esima il numero identificativo del quadrato che deve assumere tale posizione ai fini della risoluzione.
La variante che permette le rotazioni affianca a tale numero un identificativo della rotazione che tale quadrato dovrà assumere in tale posizione.

Per maggiori informazioni vedi la Relazione dell'elaborato

#### Link Utili

[MiniZinc Websites](https://www.minizinc.org/)
[MiniZinc Book](https://www.minizinc.org/downloads/doc-latest/minizinc-tute.pdf)

#### Todos

 - Aggiungre la generazione casuale delle istanze
 - Migliorare le performance aggiungendo vincoli

