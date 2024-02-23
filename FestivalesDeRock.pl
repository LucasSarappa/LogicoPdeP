Resolucion: https://www.youtube.com/watch?v=ioQZbTLnS_s&list=PL7wy4vA6RpN51gkoPaU6xmtg7KkZy2aHG&index=16

/*
Festivales de Rock: https://docs.google.com/document/d/17rWNL8rdNc-eu7VTuCPgptLhSnRD6FyBZNhYNZ7Hekc/edit
Otro enunciado parecido pero algunos puntos diferentes: https://docs.google.com/document/d/1oI9h01XcMibkybltiItrLfSaEapdUxvv-MTnV6QqGvQ/pub
PdeP JN - Práctica Lógico

Tenemos que organizar un sistema para analizar festivales de rock porque… Bueno, porque sí. Nadie lee esta parte del enunciado de todos modos.

Cuestión que partimos de una base de conocimiento con algunos predicados (completamente inversible) predefinidos que modelan la información que 
fuimos recopilando de los diversos festivales:

    % festival(NombreDelFestival, Bandas, Lugar).
    % Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
    festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipódromoSanIsidro).

    % lugar(nombre, capacidad, precioBase).
    % Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
    lugar(hipódromoSanIsidro, 85000, 3000).

    % banda(nombre, nacionalidad, popularidad).
    % Relaciona una banda con su nacionalidad y su popularidad.
    banda(gunsAndRoses, eeuu, 69420).

    % entradaVendida(NombreDelFestival, TipoDeEntrada).
    % Indica la venta de una entrada de cierto tipo para el festival 
    % indicado.
    % Los tipos de entrada pueden ser alguno de los siguientes: 
    %     - campo
    %     - plateaNumerada(Fila)
    %     - plateaGeneral(Zona).
    entradaVendida(lollapalooza, campo).
    entradaVendida(lollapalooza, plateaNumerada(1)).
    entradaVendida(lollapalooza, plateaGeneral(zona2)).

    % plusZona(Lugar, Zona, Recargo)
    % Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
    plusZona(hipódromoSanIsidro, zona1, 1500).



Se pide definir los siguientes predicados:

1. Itinerante/1: Se cumple para los festivales que ocurren en más de un lugar, pero con el mismo nombre y las mismas bandas en el mismo orden.


2. careta/1: Decimos que un festival es careta si no tiene campo o si es el personalFest.


3. nacAndPop/1: Un festival es nac&pop si no es careta y todas las bandas que tocan en él son de nacionalidad argentina y tienen popularidad mayor a 1000.


4. sobrevendido/1: Se cumple para los festivales que vendieron más entradas que la capacidad del lugar donde se realizan. Nota: no hace falta contemplar si es un festival itinerante.


5. recaudaciónTotal/2: Relaciona un festival con el total recaudado con la venta de entradas. Cada tipo de entrada se vende a un precio diferente:
   - El precio del campo es el precio base del lugar donde se realiza el festival.
   - La platea general es el precio base del lugar más el plus que se p aplica a la zona. 
   - Las plateas numeradas salen el triple del precio base para las filas de atrás (>10) y 6 veces el precio base para las 10 primeras filas.

Nota: no hace falta contemplar si es un festival itinerante.
  
6. delMismoPalo/2: Relaciona dos bandas si tocaron juntas en algún recital o si una de ellas tocó con una banda del mismo palo que la otra, pero más popular.




*/