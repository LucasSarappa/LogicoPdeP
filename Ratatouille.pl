/*
RATATOUILLE
https://github.com/Chabelamas/Prolog/tree/main/11.Ratatouille
Enunciado: https://github.com/pdep-utn/EjercicioIntegradorRatatouille-consigna

Ratatouille
Ejercicio integrador. Paradigma Lógico.


"No cualquiera puede convertirse en un gran artista, pero un gran artista puede provenir de cualquier lado"

¡Bonjour! En una ciudad donde ratas y humanos saben cocinar, tenemos la siguiente información en nuestra base de conocimiento:

    rata(remy, gusteaus).
    rata(emile, bar).
    rata(django, pizzeria).

    cocina(linguini, ratatouille, 3).
    cocina(linguini, sopa, 5). 
    cocina(colette, salmonAsado, 9).
    cocina(horst, ensaladaRusa, 8).

De las ratas sabemos su nombre y dónde viven. De los humanos, además de su nombre, qué platos saben cocinar y cuánta experiencia (del 1 al 10) tienen preparándolos. 
También tenemos información acerca de quién trabaja en cada restaurante:

    trabajaEn(gusteaus, linguini).
    trabajaEn(gusteaus, colette).
    trabajaEn(gusteaus, skinner).
    trabajaEn(gusteaus, horst).
    trabajaEn(cafeDes2Moulins, amelie).

1. Desarrollá los siguientes predicados, asegurando que sean completamente inversibles:

2. inspeccionSatisfactoria/1: se cumple para un restaurante cuando no viven ratas allí.

3. chef/2: relaciona un empleado con un restaurante si el empleado trabaja allí y sabe cocinar algún plato.

4. chefcito/1: se cumple para una rata si vive en el mismo restaurante donde trabaja linguini.

5. cocinaBien/2: es verdadero para una persona si su experiencia preparando ese plato es mayor a 7. Además, remy cocina bien cualquier plato que exista.

6. encargadoDe/3: nos dice el encargado de cocinar un plato en un restaurante, que es quien más experiencia tiene preparándolo en ese lugar. Ahora conseguimos un poco más de 
información sobre los platos. Los dividimos en entradas, platos principales y postres:

    plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
    plato(bifeDeChorizo, principal(pure, 20)).
    plato(frutillasConCrema, postre(265)).

De las entradas sabemos qué ingredientes las componen; de los principales, qué guarnición los acompaña y cuántos minutos de cocción precisan; y de los postres, cuántas calorías aportan.

    saludable/1: un plato es saludable si tiene menos de 75 calorías.
    En las entradas, cada ingrediente suma 15 calorías.
    Los platos principales suman 5 calorías por cada minuto de cocción. Las guarniciones agregan a la cuenta total: las papasFritas 50 y el puré 20, mientras que la ensalada no aporta calorías.
    De los postres ya conocemos su cantidad de calorías.

7. criticaPositiva/2: es verdadero para un restaurante si un crítico le escribe una reseña positiva. Cada crítico maneja su propio criterio, pero todos están de acuerdo en lo

    mismo: el lugar debe tener una inspección satisfactoria.
    antonEgo espera, además, que en el lugar sean especialistas preparando ratatouille. Un restaurante es especialista en aquellos platos que todos sus chefs saben cocinar bien.
    christophe, que el restaurante tenga más de 3 chefs.
    cormillot requiere que todos los platos que saben cocinar los empleados del restaurante sean saludables y que a ninguna entrada le falte zanahoria.
    gordonRamsey no le da una crítica positiva a ningún restaurante.
*/

% RESOLUCION DE OTRO ENUNCIADO PERO SIMILAR: https://github.com/MelanyGassmann/ParcialesLogico/blob/master/parcialRatatoullie.pl

# parcialRatatoullie

rata(remy,mostaza).
rata(emile,bar).
rata(django,pizzeria).

cocina(linguini,ratatouille,8).
cocina(linguini,sopa,5).
cocina(colette,ratatouille,9).
cocina(colette,salmonAsado,8).
cocina(horst,ensaladaRusa,8).
cocina(horst,ratatouille,9).

trabajaEn(gusteaus,linguini).
trabajaEn(gusteaus,colette).
trabajaEn(gusteaus,skinner).
trabajaEn(gusteaus,horst).
trabajaEn(cafeDe2Moulins,amelie).

%-------------------- CARGA BASE DE DATOS --------------------%
plato(ensaladaRusa, entrada([papa,zanahoria,arvejas,huevo,mayonesa])).
plato(bifeDeChorizo,principal(pure,20)).
plato(frutillasConCrema,postre(265)).
guarnicion(papasFritas,50).
guarnicion(pure,20).
guarnicion(ensalada,0).

%-------------------- PUNTO UNO --------------------%
esUnRestaurante(Restaurante):-
    rata(_,Restaurante).

esUnRestaurante(Restaurante):-
    trabajaEn(Restaurante,_).

inspeccionSatisfactoria(Restaurante):-
    esUnRestaurante(Restaurante),
     not(rata(_,Restaurante)).

%-------------------- PUNTO DOS --------------------%
chef(Empleado,Restaurante):-
    trabajaEn(Restaurante,Empleado),
    cocina(Empleado,_,_).

%-------------------- PUNTO TRES --------------------%
chefcito(Rata):-
    rata(Rata,Restaurante),
    trabajaEn(Restaurante,linguini).

%-------------------- PUNTO CUATRO --------------------%
cocinaBien(remy,_).
cocinaBien(Empleado,Plato):-
    cocina(Empleado,Plato,Experiencia),
    Experiencia > 7.

%-------------------- PUNTO CINCO --------------------%
otroChef(Plato,Restaurante,Experiencia):-
    cocina(Empleado,Plato,Experiencia),
    trabajaEn(Restaurante,Empleado).

encargadoDe(Empleado,Plato,Restaurante):-
    cocina(Empleado,Plato,Experiencia),
    trabajaEn(Restaurante,Empleado),
    forall(otroChef(Plato,Restaurante,OtraExp),Experiencia>=OtraExp).

%-------------------- PUNTO SEIS --------------------%
caloriasDeEntrada(Entrada,CantCalorias):-
    plato(Entrada,entrada(Lista)),
    length(Lista, CantIngredientes),
    CantCalorias is CantIngredientes * 15.
    
caloriasDePrincipal(Principal,CantCalorias):-
    plato(Principal,principal(Guarnicion,MinCoccion)),
    guarnicion(Guarnicion,Min),
    CantCalorias is (MinCoccion + Min) * 5.

saludable(Entrada):-
    caloriasDeEntrada(Entrada,CantCalorias), 
    CantCalorias < 500.

saludable(Principal):-
    caloriasDePrincipal(Principal,CantCalorias),
    CantCalorias < 75.

saludable(Postre):-
    plato(Postre,postre(CantCalorias)),
    CantCalorias < 75.

%-------------------- PUNTO SIETE --------------------%
especialistaEn(ratatouille,Restaurante):-
    chef(Empleado,Restaurante),
    forall(chef(Empleado,Restaurante),cocinaBien(Empleado,ratatouille)).

masDeTresChef(Restaurante):-
    trabajaEn(Restaurante,_),
    findall(Empleados,trabajaEn(Restaurante,Empleados),ListEmpleados),
    length(ListEmpleados,CantEmpleados),
    CantEmpleados>3.

platosSaludables(Restaurante):-
    trabajaEn(Restaurante,Empleado),
    cocina(Empleado,Plato,_),
    forall((trabajaEn(Restaurante,Empleado),cocina(Empleado,Plato,_)),saludable(Plato)).

entradasConZanahoria(Restaurante):-
    trabajaEn(Restaurante,Empleado),
    cocina(Empleado,Plato,_),
    forall((trabajaEn(Restaurante,Empleado),cocina(Empleado,Plato,_),plato(Plato,entrada(Ingredientes))),member(zanahoria,Ingredientes)).
    
criticaPositiva(Restaurante,antonEgo):-
    inspeccionSatisfactoria(Restaurante),
    especialistaEn(ratatouille,Restaurante).

criticaPositiva(Restaurante,christophe):-
    inspeccionSatisfactoria(Restaurante),
    masDeTresChef(Restaurante).
    
cirticaPositiva(Restaurante,cormillot):-
    inspeccionSatisfactoria(Restaurante),
    platosSaludables(Restaurante),
    entradasConZanahoria(Restaurante).