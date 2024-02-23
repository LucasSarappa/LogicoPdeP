/*
RECU LOGICO 2019

Buscando a Dory: https://docs.google.com/document/d/1fMgoxp56-eSFndfyP1n0dH9H8TBHm8E_ep4chiufBSU/edit


Luego de más de 13 años de haber encontrado a Nemo, llega el turno de encontrar a Dory. Por suerte para nosotros, tenemos la tecnología de punta del paradigma lógico para ayudarnos en esta difícil tarea.



Contamos información sobre cada zona del océano y sus lugares:
zona(pacifico,[anemona,fosa, arrecife]).
zona(atlantico,[bahia]).

Los habitantes del mar son numerosos y cada uno se encuentra en una zona. Entre ellos hay peces, pajaros, pulpos y ballenas. 
De un pez se conoce el nombre, la especie y su lugar de nacimiento
habitante(pacifico, pez(nemo, payaso, anemona)).
habitante(pacifico, pez(marlin, payaso, anemona)).
habitante(pacifico, pez(dory, cirujano, fosa)).

De los pajaros se sabe el nombre y las cosas que llevan en el pico
habitante(pacifico, pajaro(becky,[pochoclo, balde, brujula])).
De los pulpos, el nombre y la cantidad de tentáculos que perdieron
habitante(atlantico, pulpo(hank,1)).

De las ballenas y tortugas se sabe el nombre
habitante(atlantico, ballena(bailey)).
habitante(atlantico, ballena(destiny)).
habitante(pacifico, tortuga(crush)).

Queremos saber los lugares donde puede estar Dory, que son todos los lugares de la zona del mar donde habita ella y su lugar de nacimiento.
Averiguar los vecinos de cualquier animal, que son los que habitan la misma zona. 
Queremos saber si una especie de peces es unida, lo que sucede cuando todos sus miembros viven en la misma zona.
Obtener los nombres de los animales que hablan cetáceo, sabiendo que tanto Dory como las ballenas son capaces de hacerlo.
Los animales pueden buscar peces pero no todos buscan la misma cantidad. 
Las tortugas buscan tantos peces como haya en su zona del océano.
Los pulpos pueden buscar tantos peces como tentáculos tengan (ocho menos la cantidad que hayan perdido). 
Los pájaros pueden buscar un pez si tienen una brújula
Las ballenas pueden buscar el doble de peces que las tortugas, pero sólo si no hay tortugas en su zona. 
Los peces pueden buscar a un solo pez.
Se necesita saber la cantidad total de peces que podría ser buscados por todos los habitantes de una zona del mar.
Se quiere averiguar quiénes pueden buscar a Dory, que son aquellos animales que son vecinos, que no hablan cetáceo y que pueden buscar al menos un pez. Mostrar ejemplos de consulta.  

*/

