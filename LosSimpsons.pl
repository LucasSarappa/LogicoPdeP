https://github.com/fedescarpa/prolog-los-simpsons/blob/master/familia.pl

padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).

madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge,maggie).
madreDe(selma, ling).

progenitorDe(Progenitor, Hijo) :-
  padreDe(Progenitor, Hijo).

progenitorDe(Progenitor, Hijo) :-
  madreDe(Progenitor, Hijo).

hijoDe(Hijo, Progenitor) :-
  progenitorDe(Progenitor, Hijo).

tieneHijo(Persona) :-
  progenitorDe(Persona, _).

hermanos(Hermano1, Hermano2) :-
  compartenPadre(Hermano1, Hermano2),
  compartenMadre(Hermano1, Hermano2).

compartenPadre(Hermano1, Hermano2) :-
  padreDe(Padre, Hermano1),
  padreDe(Padre, Hermano2),
  Hermano1 \= Hermano2.

compartenMadre(Hermano1, Hermano2) :-
  madreDe(Madre, Hermano1),
  madreDe(Madre, Hermano2),
  Hermano1 \= Hermano2.

medioHermanos(Hermano1, Hermano2) :-
  compartenPadre(Hermano1, Hermano2),
  not(compartenMadre(Hermano1, Hermano2)).

medioHermanos(Hermano1, Hermano2) :-
  compartenMadre(Hermano1, Hermano2),
  not(compartenPadre(Hermano1, Hermano2)).

% Las edades de los simpson se calculan como si la fecha actual fuese (18 de diciembre de 1989)

hoy(fecha(18, 12, 1989)).

personaje(abe, fecha(18, 12, 1927)).
personaje(edwina, fecha(15, 03, 1928)).
personaje(mona, fecha(14, 10, 1928)).
personaje(gaby, fecha(20, 05, 1932)).
personaje(homero, fecha(12, 05, 1956)).
personaje(abbie, fecha(13, 11, 1945)).
personaje(herbert, fecha(22, 08, 1953)).
personaje(jacqueline, fecha(09, 07, 1928)).
personaje(clancy, fecha(12, 08, 1927)).
personaje(marge, fecha(08, 12, 1955)).
personaje(patty, fecha(02, 02, 1953)).
personaje(selma, fecha(02, 02, 1953)).
personaje(bart, fecha(01, 04, 1979)).
personaje(hugo, fecha(01, 04, 1979)).
personaje(lisa, fecha(09, 05, 1981)).
personaje(maggie, fecha(16, 06, 1988)).
personaje(ling, fecha(03, 05, 1988)).

estaHarto(Personaje) :-
  tieneHijo(Personaje),
  forall(hijoDe(Hijo, Personaje), joven(Hijo)).

joven(Personaje) :-
  edad(Personaje, Edad),
  Edad < 12.

edad(Personaje, Edad) :-
  personaje(Personaje, FechaNacimiento),
  hoy(FechaActual),
  edadSegunFechas(FechaNacimiento, FechaActual, Edad).

edadSegunFechas(fecha(_, Mes1, Anio1), fecha(_, Mes2, Anio2), Edad) :-
  Anio2 >= Anio1,
  Mes1 > Mes2,
  Edad is Anio2 - Anio1.

edadSegunFechas(fecha(Dia1, Mes, Anio1), fecha(Dia2, Mes, Anio2), Edad) :-
  Anio2 >= Anio1,
  Dia1 >= Dia2,
  Edad is Anio2 - Anio1.

edadSegunFechas(fecha(Dia1, Mes, Anio1), fecha(Dia2, Mes, Anio2), Edad) :-
  Anio2 >= Anio1,
  Dia1 < Dia2,
  Edad is Anio2 - Anio1 - 1.

edadSegunFechas(fecha(_, Mes1, Anio1), fecha(_, Mes2, Anio2), Edad) :-
  Anio2 >= Anio1,
  Mes1 < Mes2,
  Edad is Anio2 - Anio1 - 1.