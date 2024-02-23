/*
El mundo de la música: https://github.com/Prolog-Uqbar/Integrador-Mundo-de-la-musica
Ejercicio integrador
Los Hermanos Guarner, empresarios del mundo de la música nos contratan para mejorar su sistema de información. Nuestro ingeniero, que tenía ganas de aprender un lenguaje nuevo hace rato, les vendió un sistema hecho en Prolog. La primera versión, con deadline hoy a las 12:30, incluye unas cuantas funcionalidades que tienen que ver con el pago a los artistas y saber qué discos fueron exitosos.



De cada disco sabemos en qué año salió y cuántas copias vendió

% disco(artista, nombreDelDisco, cantidad, año).
disco(floydRosa, elLadoBrillanteDeLaLuna, 1000000, 1973).
disco(tablasDeCanada, autopistaTransargentina, 500, 2006).
disco(rodrigoMalo, elCaballo, 5000000, 1999).
disco(rodrigoMalo, loPeorDelAmor, 50000000, 1996).
disco(rodrigoMalo, loMejorDe, 50000000, 2018).
disco(losOportunistasDelConurbano, ginobili, 5, 2018).
disco(losOportunistasDelConurbano, messiMessiMessi, 5, 2018).
disco(losOportunistasDelConurbano, marthaArgerich, 15, 2019).
De los artistas conocemos a su manager y sus característica:

%manager(artista, manager).
manager(floydRosa, normal(15)).
manager(tablasDeCanada, buenaOnda(cachito, canada)).
manager(rodrigoMalo, estafador).

% normal(porcentajeComision) 
% buenaOnda(nombre, lugar)
% estafador     
Para desarrollar
clasico/1 Deducir si un artista tiene un disco llamado loMejorDe o con más de 1000000 de copias vendidas.
totalVentas/2 Obtener la cantidad total de ventas que cada artista tuvo en la historia.
gananciaArtista/2 Saber cuánto ganó en total un artista considerando que cada venta aporta 10 centavos al artista, descontando la parte que se cobra su manager, en caso de contar con uno:
Un manager normal se queda con un porcentaje de las ganancias de cada artista.
Un manager buena onda sólo cobra un porcentaje de las ganancias, que depende de su lugar de residencia. (Por ejemplo, para Canadá es un 5%, para México un 15%, etc.)
Un manager estafador se queda con todo.
namberuan/2 Encontrar al artista autogestionado número 1 del año, que es el artista sin manager con el disco que tuvo más unidades vendidas en dicho año.
En todos los puntos, hacer que el predicado principal sea inversible. Si algún parámetro no lo es, especificar por qué.

Para pensar
¿Cómo especificamos que un artista no tiene manager? ¿Qué concepto es el que se aplica en el paradigma lógico para explicar esto?
Si se agrega un nuevo tipo de manager, ¿qué hay que hacer? ¿Qué concepto nos ayuda?

*/

% disco(artista, nombreDelDisco, cantidad, año).
disco(floydRosa, elLadoBrillanteDeLaLuna, 1000000, 1973).
disco(tablasDeCanada, autopistaTransargentina, 500, 2006).
disco(rodrigoMalo, elCaballo, 5000000, 1999).
disco(rodrigoMalo, loPeorDelAmor, 50000000, 1996).
disco(rodrigoMalo, loMejorDe, 50000000, 2018).
disco(losOportunistasDelConurbano, ginobili, 5, 2018).
disco(losOportunistasDelConurbano, messiMessiMessi, 5, 2018).
disco(losOportunistasDelConurbano, marthaArgerich, 15, 2019).

%manager(artista, manager).
manager(floydRosa, normal(15)).
manager(tablasDeCanada, buenaOnda(cachito, canada)).
manager(rodrigoMalo, estafador).

% normal(porcentajeComision) 
% buenaOnda(nombre, lugar)
% estafador     


porcentaje(canada, 5).
porcentaje(mexico,1.5).

clasico(Artista) :-
  disco(Artista, loMejorDe, _, _).
clasico(Artista) :-
  disco(Artista, _, Ventas, _),
  Ventas > 1000000.

ventasTotales(Artista, Ventas) :-
	disco(Artista, _, _, _),
	findall(Ventas, disco(Artista, _, Ventas, _), ListaDeVentas),
	sum_list(ListaDeVentas, Ventas).

ventasBrutas(Artista, Bruto) :-
  ventasTotales(Artista, Total),
  Bruto is Total/10.

ventasNetas(Artista, Neto) :-
  ventasBrutas(Artista, Bruto),
  manager(Artista, Manager),
  descuento(Manager,Descuento),
  porcentaje(Descuento, Bruto, Neto).

ventasNetas(Artista, Bruto) :-
    ventasBrutas(Artista, Bruto),
    not(manager(Artista, _)).

descuento(buenaOnda(_,Pais), Descuento) :-
	porcentaje(Pais, Descuento).
descuento(estafador,100).
descuento(normal(Descuento), Descuento). 

porcentaje(Porcentaje, Bruto, Neto):-
	Neto is Bruto*(100-Porcentaje).

numberUan(Anio, Artista) :-
  artistaAutogestionado(Artista),
  disco(Artista, _, Cantidad, Anio),
  not((disco(OtroArtista, _, OtraCantidad, Anio),
	artistaAutogestionado(OtroArtista),
	Cantidad < OtraCantidad)).

artistaAutogestionado(Artista) :-
  disco(Artista, _, _, _),
  not(manager(Artista, _)).