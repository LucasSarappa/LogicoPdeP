/*

MUNDIAL 2014

Resolucion:  https://github.com/RonanCamargo/UTN-PdP/blob/master/L%C3%B3gico/Parciales/Mundial2014.pl

Enunciado:
Se dispone de una base de conocimientos con información sobre los partidos de fútbol de los mundiales.
Se pide definir los siguientes predicados:

1. esPais/1: relaciona un país con la base de conocimientos. Debe ser verdadero para todos los países que participaron en algún partido.

2. fueAAlargue/1: relaciona un país con la base de conocimientos. Debe ser verdadero para los países que alguna vez jugaron un partido que se definió en alargue.

3. algunaVezGanoCon6GolesDeDiferenciaSinAlargue/1: relaciona un país con la base de conocimientos. Debe ser verdadero para los países que alguna vez ganaron un partido por 6 goles de diferencia sin necesidad de alargue.

4. hizoUnPapelon/1: relaciona un país con la base de conocimientos. Debe ser verdadero para los países que alguna vez perdieron un partido por 7 goles de diferencia o más, o que alguna vez empataron un partido 0 a 0 y luego perdieron por penales en una final.

5. juegoBonito/1: relaciona un país con la base de conocimientos. Debe ser verdadero para los países que alguna vez ganaron un partido por 6 goles de diferencia sin necesidad de alargue, y que nunca hicieron un papelón.

6. ganoMundial/2: relaciona un país con un mundial con la base de conocimientos. Debe ser verdadero para los países que ganaron un mundial.

7. cantidadDeMundialesGanados/2: relaciona un país con la cantidad de mundiales que ganó.

8. mejorDeTodosLosTiempos/2: relaciona un país con la cantidad de mundiales que ganó. Debe ser verdadero para los países que ganaron al menos un mundial, que jugaron siempre lindo, y que ganaron más mundiales que cualquier otro país.



*/

partido(2006, serbia, argentina, normal(0,6), primeraRonda).
partido(2014, argentina, suiza, alargamiento(0,0,1,0), octavosDeFinal).
partido(1954, hungria, alemania, normal(8,3), primeraRonda).
partido(2014, alemania, brasil, normal(7,1), semifinal).
partido(1994, italia, brasil, penales(0,0,0,0,3,2), final).
partido(2014, argentina, alemania, normal(2,0), final).

%partido(año,pais1,pais2,resultado,ronda)

esPais(Pais):-partido(_,Pais,_,_,_).
esPais(Pais):-partido(_,_,Pais,_,_).

fueAAlargue(Pais):-partido(_,Pais,_,alargamiento(_,_,_,_),_).
fueAAlargue(Pais):-partido(_,_,Pais, alargamiento(_,_,_,_),_).

algunaVezGanoCon6GolesDeDiferenciaSinAlargue(Pais):-partido(_,Pais,_,normal(GolesPais,GolesContrario),_),GolesPais-GolesContrario>=6.
algunaVezGanoCon6GolesDeDiferenciaSinAlargue(Pais):-partido(_,_,Pais,normal(GolesContrario,GolesPais),_),GolesPais-GolesContrario>=6.

hizoUnPapelon(Pais):-partido(_,Pais,_,normal(_,GolesContrario),_),GolesContrario>=7.
hizoUnPapelon(Pais):-partido(_,_,Pais,normal(GolesContrario,_),_),GolesContrario>=7.
hizoUnPapelon(Pais):-empataSinGoles(Pais).

empataSinGoles(Pais):-partido(_,Pais,_,penales(0,0,0,0,_,_),final).
empataSinGoles(Pais):-partido(_,_,Pais,normal(0,0,0,0,_,_),final).

juegoBonito(Pais):-
	algunaVezGanoCon6GolesDeDiferenciaSinAlargue(Pais),
	forall(partido(_,Pais,_,_,_),not(hizoUnPapelon(Pais))).
juegoBonito(Pais):-
	algunaVezGanoCon6GolesDeDiferenciaSinAlargue(Pais),
	forall(partido(_,_,Pais,_,_),not(hizoUnPapelon(Pais))).
	
	
ganoMundial(Mundial,Pais):-
	partido(Mundial,Pais,_,normal(GolesPais,GolesContrario),final),GolesPais>GolesContrario.
ganoMundial(Mundial,Pais):-
	partido(Mundial,Pais,_,alargamiento(_,_,GolesPais,GolesContrario),final),GolesPais>GolesContrario.
ganoMundial(Mundial,Pais):-
	partido(Mundial,Pais,_,penales(_,_,_,_,GolesPais,GolesContrario),final),GolesPais>GolesContrario.
ganoMundial(Mundial,Pais):-
	partido(Mundial,_,Pais,normal(GolesContrario,GolesPais),final),GolesPais>GolesContrario.
ganoMundial(Mundial,Pais):-
	partido(Mundial,_,Pais,alargamiento(_,_,GolesContrario,GolesPais),final),GolesPais>GolesContrario.
ganoMundial(Mundial,Pais):-
	partido(Mundial,_,Pais,penales(_,_,_,_,GolesContrario,GolesPais),final),GolesPais>GolesContrario.
	
	
cantidadDeMundialesGanados(Pais,Cantidad):-
	esPais(Pais),
	findall(Mundial,ganoMundial(Mundial,Pais),Mundiales),
	length(Mundiales,Cantidad),
	Cantidad>=0.
	
mejorDeTodosLosTiempos(Pais,CantidadDeMundialesGanados):-
	cantidadDeMundialesGanados(Pais,CantidadDeMundialesGanados),
	juegoBonito(Pais),
	esPais(OtroPais),
	forall(cantidadDeMundialesGanados(OtroPais,CantidadDeMundialesGanadosOtroPais),CantidadDeMundialesGanados>CantidadDeMundialesGanadosOtroPais).
	


maximo([X|Xs],Max):-
	Max is X,
	hallarMaximo(Xs,Max).
hallarMaximo([X|Xs],Max):-
	X >= Max,
	maximo(Xs,Max).
hallarMaximo([X|Xs],Max):-
	X < Max,
	hallarMaximo(Xs,Max).
	
max([X],X).
max([X|Xs],X):- max(Xs,Y), X >=Y.
max([X|Xs],Y):- max(Xs,Y), X < Y.