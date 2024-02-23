/*
Parcial logico - Amigo invisible.

Enunciado: https://github.com/MaquedaPaul/parciales-logico/blob/main/AmigoInvisible/AmigoInvisible.md

Todos los predicados principales (los que contestan el requerimiento, no necesriamente los auxiliares) de cada punto deben ser inversibles respecto de todos sus parámetros a menos que se indique explícitamente que no es necesario.

Queremos programar un pequeño sistema en prolog para jugar al amigo invisible en la oficina. Esto significa que a cada persona se le asigna un amigo invisible, que es una persona encargada de regalarle algo para su cumpleaños.


Fechas de cumpleaños

De cada persona que participa en el amigo invisible sabemos cuándo nació:
- Juan nació el 9 de julio de 1994
- Aye el 26 de marzo de 1992
- Feche el 22 de diciembre de 1995

1. Y queremos saber:

a) si una fecha es antes que otra.

Por ejemplo, el 9 de julio de 2021 es antes que el 22 de diciembre de 2021; pero el 22 de diciembre de 2020 es antes que el 9 de julio de 2021.

b) si ya pasó el cumpleaños de alguien en cierta fecha.

Por ejemplo, el 20 de agosto de 2021 los cumpleaños de Aye y de Juan ya pasaron, pero el de Feche no.


No es necesario que estos predicados sean inversibles respecto de las fechas y podemos asumir que las fechas que le pasemos siempre van a ser válidas.


A quién puede regalar

Los amigos invisibles no necesariamente están todos definidos desde el principio, se pueden ir decidiendo en el tiempo para permitir que más gente se pueda sumar al mismo sobre la marcha.

2. Es por eso que queremos, dada una fecha, saber quien podría regalarle a quién, lo cual es posible si se cumplen las siguientes condiciones:
- El amigo invisible aún no le regaló nada a nadie ese año.
- El regalado todavía no cumplió años para esa fecha en ese año.
- El regalado aún no recibió un regalo ese año.

Y ya contamos con la siguiente información:

 Juan le regaló:
- un libro de fantasía de Terry pratchet a Feche en 2018
- un producto de Harry Potter a Aye en 2019
- una cerveza artesanal roja también a Aye en 2020
- una cerveza quilmes rubia a Feche en 2021
 Aye le regaló:
- un libro de fantasía de Terry Pratchet a Feche en 2019
- un libro de ciencia ficción de Stanislaw Lem en 2020 a Juan
- todavía no le regaló nada a nadie en 2021
Feche le regaló:
- una cerveza artesanal rubia a Juan en 2019
- un producto de Pokemon a Juan en 2020
- un libro de terror de Mary Shelley a Aye en 2021

Ejemplos:
 
-Si preguntamos para el 5 de enero de 2021, Aye le podría regalar a Juan porque es la única que no regaló en 2021 y Juan es el único que aún no recibió regalo, y además todavía no es el cumple de Juan.
 
-Si preguntásemos para el 10 de enero de 2020, nadie le podría regalar a Juan, porque aunque todavía no habría sido su cumpleaños, ya sabemos que en realidad hubo un regalo que se le hizo (Feche le regaló algo en 2020).

No es necesario que el predicado sea inversible respecto de la fecha.




Buenos regalos

Estos son algunos de los posibles regalos:
- productos de alguna temática, como por ej. pokemon o harry potter.
- cerveza, que puede ser artesanal o de alguna marca (quilmes, heineken, etc) y además puede ser roja, rubia o negra.
- libros, de los que conocemos el autor y el género.

3. Lo que necesitamos poder contestar es si un regalo de un amigo invisible fue un buen regalo para una persona. Esto se cumple si el regalo le gustaba a la persona que lo recibió. Y sobre gustos esto es lo que sabemos:
- A Aye le gusta la cerveza heineken rubia y los productos de harry potter.
- A Juan le gustan los libros de fantasía y los de ciencia ficción. También le gustan los regalos caros. Son caros los libros de ciencia ficción de Ray Bradbury, los libros de género novela de cualquier autor y también todas las cervezas artesanales.
- A Feche le gustan los productos de Monster Hunter y los libros de Terry Pratchet que no son caros.

Notas:
- No es necesario que el predicado principal de este punto sea inversible respecto del regalo.

Hábil regalador

4. Queremos saber quienes son hábiles regaladores, lo cual se cumple si siempre hicieron buenos regalos y además nunca hicieron 2 regalos parecidos en distintos años.

Son parecidos entre sí todas las cervezas, los libros que son del mismo género y los productos si son de la misma temática.

Ejemplo: aye es habil regaladora porque los 2 regalos que hizo (un libro de fantasía de Terry Pratchet para Feche y un libro de ciencia ficción de Stanislaw Lem para Juan) le gustaron a sus regalados. Además los 2 regalos no son parecidos entre sí porque son libros pero de diferentes géneros.

Monotemático

5. Decimos que alguien es monotemático cuando todos los regalos que recibió y le gustaron eran parecidos entre sí.

Por ejemplo: Feche es monotemático porque los regalos que le gustaron (libro de fantasía de Terry Pratchet en 2018 y libro de fantasía de Terry Pratchet en 2019) son parecidos porque son libros del mismo género.

Regalador Ninja

6. Un regalo ninja es aquel que se hace con la intención de uno mismo usar el regalo que se le hizo a la otra persona. Entonces, teniendo un regalador y un regalado, un regalo es regalo ninja si el regalador se lo regaló al regalado y además el regalo le gustaba al regalador (si le gustaba o no al regalado no importa).
Por ejemplo: la cerveza artesanal roja que le regalo Juan a Aye es un regalo ninja.

Queremos saber quien es regalador ninja: que es aquel que hizo tantos o más regalos ninja que buenos regalos.

Nota: Tener en cuenta que un mismo regalo que haya hecho podría contar tanto como regalo ninja y como buen regalo.

Ejemplo: juan es un regalador ninja porque hizo 2 regalos ninja (el libro de fantasía que le regaló a Feche en 2018 y la cerveza artesanal que le regaló a Aye en 2020) y 2 regalos buenos (el libro de fantasía que le regaló a Feche en 2018 y el producto de Harry Potter que le regaló a Aye en 2019).


*/

%Resolucion:

:-style_check(-discontiguous).

%nacio(Fecha, Persona).
nacio(fecha(9, 9, 1994), juan).
nacio(fecha(26, 3, 1992), aye).
nacio(fecha(22, 12, 1995), feche).

%Punto 1
anterior(fecha(_, _, AnioAnterior), fecha(_, _ , Anio)):- AnioAnterior < Anio.
anterior(fecha(_, MesAnterior, Anio), fecha(_, Mes, Anio)):- MesAnterior < Mes.
anterior(fecha(DiaAnterior, Mes, Anio), fecha(Dia, Mes, Anio)):- DiaAnterior < Dia.

anteriorEnUnAnio(fecha(_, MesAnterior), fecha(_, Mes)):- MesAnterior < Mes.

anteriorEnUnAnio(fecha(DiaAnterior, Mes), fecha(Dia, Mes)):- DiaAnterior < Dia.



hoyEs(fecha(29, 8, 2021)).

dia(fecha(Dia,_,_), Dia).
mes(fecha(_, Mes,_), Mes).

yaPaso(Persona):-
    nacio(fecha(Dia, Mes, _), Persona),
    hoyEs(fecha(OtroDia, OtroMes, _)),
    anteriorEnUnAnio(fecha(Dia, Mes), fecha(OtroDia, OtroMes)).


%podriaRegalarle(OtroPersona, Persona, Fecha).


%regalo(Regalador, Regalado, Regalo, Fecha).

leRegalo(juan, feche, libro(terryPratchet, fantasia), 2018).
leRegalo(juan, aye, producto(harryPotter), 2019).
leRegalo(juan, aye, cerveza(artesanal,roja), 2020).
leRegalo(juan, feche, cerveza(quilmes,rubia), 2021).

leRegalo(aye, feche, libro(terryPratchet, fantasia), 2019).
leRegalo(aye, juan, libro(stanislawLem, scifi), 2020).

leRegalo(feche, juan, cerveza(artesanal, rubia), 2019).
leRegalo(feche, juan, producto(pokemon), 2020).
leRegalo(feche, aye, libro(maryShelley, terror), 2021).

podriaRegalarle(OtraPersona, Persona, Fecha):-
    nacio(_,OtraPersona),
    nacio(_,Persona),
    OtraPersona \= Persona,
    not(leRegalo(Persona, _, _, Fecha)),
    not(yaPaso(OtraPersona)),
    not(recibioRegaloEn(OtraPersona, Fecha)).


recibioRegaloEn(Persona, Fecha):-
    leRegalo(_,Persona,_,Fecha).


%Punto 3

esBuenRegalo(Persona, Regalo):-
    leRegalo(_,Persona,Regalo,_),
    leGusta(Persona, Regalo).

leGusta(aye, cerveza(heneiken, rubia)).
leGusta(aye, producto(harryPotter)).
leGusta(juan, libro(_, scifi)).
leGusta(juan, libro(_, terror)).
leGusta(juan, Regalo):-
    esCaro(Regalo).

autor(libro(Autor,_),Autor).

leGusta(feche, producto(monsterHunster)).

leGusta(feche, libro(terryPratchet,_)):-
    not(esCaro(libro(terryPratchet,_))).

esCaro(libro(rayBradbury, scifi)).
esCaro(libro(_, novela)).
esCaro(cerveza(artesanal, _)).


habilRegalador(Persona):-
    leRegalo(Persona, _, Regalo, _),
    forall((leRegalo(Persona,OtraPersona,Regalo,_), Persona \= OtraPersona),
    esBuenRegalo(OtraPersona, Regalo)),
    nuncaHizoDosRegalosParecidos(Persona).


nuncaHizoDosRegalosParecidos(Persona):-
    forall(regaloDosRegalosDistintos(Persona, Regalo, OtroRegalo),
    not(esParecido(Regalo, OtroRegalo))).

regaloDosRegalosDistintos(Persona, Regalo, OtroRegalo):-
    leRegalo(Persona,_,Regalo,_),
    leRegalo(Persona,_,OtroRegalo,_),
    Regalo \= OtroRegalo.

esParecido(cerveza(_,_),cerveza(_,_)).
esParecido(libro(_, Genero), libro(_, Genero)).

recibioRegaloYLeGusto(Persona, Regalo):-
    leRegalo(_, Persona, Regalo, _),
    leGusta(Persona, Regalo).



esMonotematico(Persona):-
    nacio(_,Persona),
    forall((recibioRegaloYLeGusto(Persona,Regalo),
    recibioRegaloYLeGusto(Persona, OtroRegalo),
    Regalo \= OtroRegalo),
    esParecido(Regalo, OtroRegalo)).

regaladorNinja(Persona):-
    leRegalo(Persona,_,_,_),
    buenosRegalos(Persona, BuenosRegalos),
    regalosNinja(Persona, RegalosNinja),
    length(RegalosNinja, TotalNinja),
    length(BuenosRegalos, TotalBuenos),
    TotalNinja >= TotalBuenos.

buenosRegalos(Persona, BuenosRegalos):-
    findall(BuenRegalo, (leRegalo(Persona, Regalado, BuenRegalo, _),
    esBuenRegalo(Regalado, BuenRegalo)), BuenosRegalos).

regalosNinja(Persona, RegalosNinja):-
    findall(Regalo, esRegaloNinja(Regalo, Persona, _), RegalosNinja).


esRegaloNinja(Regalo, Regalador, Regalado):-
    leRegalo(Regalador, Regalado, Regalo,_),
    leGusta(Regalador, Regalo).


%esBuenRegalo no da la respuesta esperada, en su mayoría diría que es un parcial bien resuelto pero posiblemente se pueda mejorar.