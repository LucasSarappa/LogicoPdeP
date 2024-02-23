/*
ENUNCIADO: https://github.com/frcenturion/PdeP-2022/blob/main/Parciales%20-%20L%C3%B3gico/11%20-%20Parcial%20L%C3%B3gico%20-%20Previaje/11%20-%20Parcial%20L%C3%B3gico%20-%20Previaje.pdf
Resolucion: https://github.com/FedericoEncinazSayago/Enciclopedia-De-Pdep/blob/main/Prolog/Parciales/Previaje.pl
Otra resolucion (9): https://www.utnianos.com.ar/foro/attachment.php?aid=22366
¡Llegó el previaje!

La Secretaría de Turismo planea lanzar una nueva edición de previaje, el programa que reintegra al turista parte de sus costos para fomentar que se mueva por el país. 
La anterior edición fue gestionada utilizando un programa en C escrito en una enorme sala por una cantidad infinita de monos1, pero esta vuelta decidieron probar suerte con Prolog.

La forma de funcionamiento del programa es que las personas cargan facturas en el sistema, indicando a qué ciudad corresponde y la información necesaria para validar esa transacción. 
En caso de que esté ok, a esa persona se le devuelve parte del dinero gastado en su cuenta bancaria.

Se conocen los comercios adheridos en cada destino que entran en el programa.
    comercioAdherido (iguazu, grandHotelIguazu).
    comercioAdherido (iguazu, gargantaDelDiabloTour). comercioAdherido (bariloche, aerolineas).
    comercioAdherido (iguazu, aerolineas).

También, se conoce de cada persona las facturas que presentó y el monto máximo reconocido para una habitacion de hotel: 

    %factura (Persona, DetalleFactura).
    % hotel (ComercioAdherido, Importe Pagado)
    % excursion (ComercioAdherido, ImportePagadoTotal,
    CantidadPersonas)

    % vuelo (NroVuelo, NombreCompleto)

    factura (estanislao, hotel (grandHotelIguazu, 2000)).
    factura (antonieta, excursion (gargantaDelDiabloTour, 5000, 4)). factura (antonieta,
    vuelo(1515, antonietaPerez)).

    valorMaximoHotel (5000).

Y los vuelos que efectivamente se hicieron:

    %registroVuelo (NroVuelo, Destino, ComercioAdherido, Pasajeros, Precio)
    registroVuelo (1515, buenosAires, aerolineas, [estanislaoGarcia, antonietaPerez, danielIto], 10000).

El dinero que se le devuelve a una persona se calcula sumando la devolución correspondiente a cada una de las facturas válidas (que no sean truchas), más un adicional de 
$1000 por cada ciudad diferente en la que se alojó (con factura válida). Hay una penalidad de $15000 si entre todas las facturas presentadas hay alguna que sea trucha. 
Además, el monto máximo a devolver es de $100000.

De las facturas válidas se devuelve:

    -En caso de hoteles: un 50% del monto pagado
    -En caso de vuelos: un 30% del monto, excepto que el destino sea Buenos Aires en cuyo caso no se devuelve nada.
    -En caso de excursiones: un 80% del monto por persona (dividir por la cantidad de personas que participó).

Aquellas facturas que son para un comercio que no está adherido al programa se consideran truchas. También son truchas las facturas de hotel por un monto superior al precio 
por habitación máximo establecido. Si una factura corresponde a un vuelo en el que no hay una persona con su nombre completo en el registro del vuelo, se considera trucha.

Se desea saber:

1. El monto a devolver a cada persona que presentó facturas.

2. Qué destinos son sólo de trabajo. Son aquellos destinos que si bien tuvieron vuelos hacia ellos, no tuvieron ningún turista que se alojen allí o tienen un único hotel adherido.

3. Saber quiénes son estafadores, que son aquellas personas que sólo presentaron facturas truchas o facturas de monto 0.

4. Inventar un nuevo tipo de comercio adherido no trivial pero que no implique escribir mucho código nuevo, y que todo siga funcionando correctamente. Explicar el concepto que nos 
permite hacer eso sin reescribir otros predicados.

5. Agregar algunos hechos de ejemplo.


*/



% Otra resolucion: https://github.com/frcenturion/PdeP-2022/blob/main/Parciales%20-%20L%C3%B3gico/11%20-%20Parcial%20L%C3%B3gico%20-%20Previaje/programa.pl


% Se conocen los comercios adheridos en cada destino que entran en el pograma

comercioAdherido(iguazu, grandHotelIguazu).
comercioAdherido(iguazu, gargantaDelDiabloTour).
comercioAdherido(bariloche, aerolineas).
comercioAdherido(buenosAires, aerolineas).

% También, se conoce de cada persona las facturas que presentó y el monto máximo reconocido para una habitacion de hotel

factura(estanislao, hotel(grandHotelIguazu, 2000)).
factura(antonieta, excursion(gargantaDelDiabloTour, 5000, 4)).
factura(antonieta, vuelo(1515, antonietaPerez)).

valorMaximoHotel(5000).

% Y los vuelos que efectivamente se hicieron:

registroVuelo(1515, buenosAires, aerolineas, [estanislaoGarcia, antonietaPerez, danielIto], 10000).

% Punto 1: El monto a devolver a cada persona que presentó facturas.

comercio(hotel(Comercio, _), Comercio).

comercio(excursion(Comercio, _, _), Comercio).

comercio(vuelo(NroDeVuelo, _), Comercio) :-
    comercioAdherido(_, Comercio),
    registroVuelo(NroDeVuelo, _, Comercio, _, _).

facturaTrucha(DetalleDeFactura) :-
    comercio(DetalleDeFactura, Comercio),
    not(comercioAdherido(_, Comercio)).

facturaTrucha(hotel(_, ImportePagado)) :-
    valorMaximoHotel(ValorMaximo),
    ValorMaximo >= ImportePagado.

facturaTrucha(vuelo(NroDeVuelo, NombreCompleto)) :-
    registroVuelo(NroDeVuelo, _, _, ListaPasajeros, _),
    not(member(NombreCompleto, ListaPasajeros)).

monto(hotel(_, _, Monto), Monto).

monto(excursion(_, ImportePagado, CantDePersonas), Monto) :-
    Monto is (ImportePagado / CantDePersonas).

monto(vuelo(NroDeVuelo, _), Monto) :-
    registroVuelo(NroDeVuelo, _, _, _,Monto).

porcentajeDevolucion(hotel(_, _), 0.5).

porcentajeDevolucion(excursion(_, _, _), 0.8).

porcentajeDevolucion(vuelo(NroDeVuelo, _), 0) :-
    registroVuelo(NroDeVuelo, buenosAires, _, _, _).

porcentajeDevolucion(vuelo(NroDeVuelo, _), 0.3) :-
    registroVuelo(NroDeVuelo, LugarDestino, _, _, _),
    LugarDestino \= buenosAires.

montoADevolverDeUnaFactura(Turista, Monto) :-
    factura(Turista, DetalleDeFactura),
    not(facturaTrucha(DetalleDeFactura)),
    monto(DetalleDeFactura, MontoSinPorcentaje),
    porcentajeDevolucion(DetalleDeFactura, Porcentaje),
    Monto is MontoSinPorcentaje * Porcentaje.

montoDePenalidad(Turista, 0) :-
    factura(Turista, DetalleDeFactura),
    not(facturaTrucha(DetalleDeFactura)).

montoDePenalidad(Turista, 15000) :-
    factura(Turista, DetalleDeFactura),
    facturaTrucha(DetalleDeFactura).

esUnaFacturaValidadDeHotel(Turista, Cuidad) :-
    factura(Turista, hotel(Cuidad, Comercio, ImportePagado)),
    comercioAdherido(Cuidad, Comercio),
    valorMaximoHotel(ValorMaximo),
    ImportePagado =< ValorMaximo.

montoAdicional(Turista, MontoAdicional) :-
    setof(Cuidad, esUnaFacturaValidadDeHotel(Turista, Cuidad), Cuidades),
    length(Cuidades, CantDeElementos),
    MontoAdicional is (1000 * CantDeElementos).

montoDeFacturas(Turista, MontoDeFacturas) :-
    findall(Monto, montoADevolverDeUnaFactura(Turista, Monto), ListaDeMontos),
    sum_list(ListaDeMontos, MontoDeFacturas).

montoADevolverTotal(Turista, MontoTotal) :-
    factura(Turista, _),
    montoDeFacturas(Turista, MontoDeFacturas),
    montoAdicional(Turista, MontoAdicional),
    montoDePenalidad(Turista, MontoDePenalidad),
    MontoTotal is (MontoDeFacturas + MontoAdicional - MontoDePenalidad).
    