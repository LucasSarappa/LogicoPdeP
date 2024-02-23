/*

Enunciado: https://docs.google.com/document/d/1wCPnqFduItd7T30ur2HFMAoBnWliqjhlXNU0IwvVr-s/edit
Resolucion: https://github.com/FacuTadic/parcialDakarPublico/blob/master/dakar.pl
Otra resolucion (esta ok creo): https://github.com/Agustoledo10/Prolog/blob/cfb9d12a9c9f8f1caeab8eb8f2c13f3c3cd5f10e/dakar.pl

Rally Dakar
 
Para la última edición del Rally Dakar en argentina los organizadores nos contratan porque quieren entregar unos premios honoríficos.

Para ponernos en tema, nos explican que existen varias carreras en simultáneo (por ahora son autos, camiones, motos y cuatriciclos, pero podría haber más a futuro), por lo que hay varios ganadores por año.

Nos entregan la siguiente base de conocimiento para poder trabajar, con los siguientes functores:

auto(modelo)
moto(anioDeFabricacion, suspensionesExtras)
camion(items)
cuatri(marca)


ganador(1997,peterhansel,moto(1995, 1)).
ganador(1998,peterhansel,moto(1998, 1)).
ganador(2010,sainz,auto(touareg)).
ganador(2010,depress,moto(2009, 2)).
ganador(2010,karibov,camion([vodka, mate])).
ganador(2010,patronelli,cuatri(yamaha)).
ganador(2011,principeCatar,auto(touareg)).
ganador(2011,coma,moto(2011, 2)).
ganador(2011,chagin,camion([repuestos, mate])).
ganador(2011,patronelli,cuatri(yamaha)).
ganador(2012,peterhansel,auto(countryman)).
ganador(2012,depress,moto(2011, 2)).
ganador(2012,deRooy,camion([vodka, bebidas])).
ganador(2012,patronelli,cuatri(yamaha)).
ganador(2013,peterhansel,auto(countryman)).
ganador(2013,depress,moto(2011, 2)).
ganador(2013,nikolaev,camion([vodka, bebidas])).
ganador(2013,patronelli,cuatri(yamaha)).
ganador(2014,coma,auto(countryman)).
ganador(2014,coma,moto(2013, 3)).
ganador(2014,karibov,camion([tanqueExtra])).
ganador(2014,casale,cuatri(yamaha)).
ganador(2015,principeCatar,auto(countryman)).
ganador(2015,coma,moto(2013, 2)).
ganador(2015,mardeev,camion([])).
ganador(2015,sonic,cuatri(yamaha)).
ganador(2016,peterhansel,auto(2008)).
ganador(2016,prince,moto(2016, 2)).
ganador(2016,deRooy,camion([vodka, mascota])).
ganador(2016,patronelli,cuatri(yamaha)).
ganador(2017,peterhansel,auto(3008)).
ganador(2017,sunderland,moto(2016, 4)).
ganador(2017,nikolaev,camion([ruedaExtra])).
ganador(2017,karyakin,cuatri(yamaha)).
ganador(2018,sainz,auto(3008)).
ganador(2018,walkner,moto(2018, 3)).
ganador(2018,nicolaev,camion([vodka, cama])).
ganador(2018,casale,cuatri(yamaha)).
ganador(2019,principeCatar,auto(hilux)).
ganador(2019,prince,moto(2018, 2)).
ganador(2019,nikolaev,camion([cama, mascota])).
ganador(2019,cavigliasso,cuatri(yamaha)).
pais(peterhansel,francia).
pais(sainz,espania).
pais(depress,francia).
pais(karibov,rusia).
pais(patronelli,argentina).
pais(principeCatar,catar).
pais(coma,espania).
pais(chagin,rusia).
pais(deRooy,holanda).
pais(nikolaev,rusia).
pais(casale,chile).
pais(mardeev,rusia).
pais(sonic,polonia).
pais(prince,australia).
pais(sunderland,reinoUnido).
pais(karyakin,rusia).
pais(walkner,austria).
pais(cavigliasso,argentina).

Resolver utilizando Prolog los siguientes requerimientos. Los predicados principales de cada punto deben ser inversibles.
Agregar la siguiente información a la base de conocimientos:
La marca peugeot tiene los modelos 2008 y 3008 de autos. El countryman es modelo de auto marca mini, touareg es marca volkswagen, y hilux es de marca toyota.
Teórico: ¿Qué debo agregar si quiero decir que el modelo buggy es marca mini pero el modelo dkr no lo es? Justificar conceptualmente.
Codificar los siguientes predicados:
ganadorReincidente/1. Se cumple para aquel competidor que ganó en más de un año.
inspiraA/2. Un conductor resulta inspirador para otro cuando ganó y el otro no, y también resulta inspirador cuando ganó algún año anterior al otro. En cualquier caso, el inspirador debe ser del mismo país que el inspirado.
marcaDeLaFortuna/2. Relaciona un conductor con una marca si sólo ganó con vehículos de esa marca. Si un conductor nunca ganó, no debe tener marca de la fortuna.
La marca de un auto se obtiene a partir del modelo del auto. 
La marca de las motos dependen del año de fabricación: las fabricadas a partir del 2000 inclusive son ktm, las anteriores yamaha.
La marca de los camiones es kamaz si lleva vodka, sino la marca es iveco.
La marca del cuatri se indica en cada uno.
heroePopular/1. Decimos que un corredor es un héroe popular cuando sirvió de inspiración a alguien, y además el año que salió ganador fue el único de los conductores ganadores que no usó un vehículo caro.
Un vehículo es caro cuando es de una marca cara (por ahora las caras son mini, toyota e iveco), o tiene al menos tres suspensiones extras. 
La cantidad de suspensiones extras que trae una moto se indica en cada una, los cuatri llevan siempre 4, y los otros vehículos ninguna.
Para terminar (En este punto no hace falta que todos los predicados sean inversibles, forma parte del análisis el determinar cuáles deberían serlo y para qué parámetros, de forma de poder solucionar el problema planteado)
Los corredores se enteraron del sistema que estamos desarrollando y quieren que los ayudemos a planificar su recorrido. Para armar sus estrategias, nos pidieron un programa les permita separar el recorrido en tramos para decidir en qué ciudades frenar a hacer mantenimiento. Para eso:
Necesitamos un predicado que permita saber cuántos kilómetros existen entre dos locaciones distintas. ¡Atención! Debe poder calcularse también entre locaciones que no pertenezcan a la misma etapa. 
Por ejemplo, entre sanRafael y copiapo hay 208+326+177+274 = 985 km
Saber si un vehículo puede recorrer cierta distancia sin parar. Por ahora (posiblemente cambie) diremos que un vehículo caro puede recorrer 2000 km, mientras que el resto solamente 1800 km. Además, los camiones pueden también recorrer una distancia máxima igual a la cantidad de cosas que lleva * 1000.
Por ejemplo, una moto(1999,1) como no es cara, puede recorrer 1800 km pero no 1900 km.
Los corredores quieren saber, dado un vehículo y un origen, cuál es el destino más lejano al que pueden llegar sin parar.
Para la moto del punto anterior el destino más lejano desde marDelPlata es copiapo. Ya suman 1335 km, pero el con el próximo destino (antofagasta) se va a 1812 km, que es una distancia que no puede recorrer.
Para realizar este punto se cuenta con la siguiente información:
etapa(marDelPlata,santaRosa,60).
etapa(santaRosa,sanRafael,290).
etapa(sanRafael,sanJuan,208).
etapa(sanJuan,chilecito,326).
etapa(chilecito,fiambala,177).
etapa(fiambala,copiapo,274).
etapa(copiapo,antofagasta,477).
etapa(antofagasta,iquique,557).
etapa(iquique,arica,377).
etapa(arica,arequipa,478).
etapa(arequipa,nazca,246).
etapa(nazca,pisco,276).
etapa(pisco,lima,29).


 
Temas a evaluar
Modelado
Cuantificación
Inversiblidad
Aritmética
Polimorfismo
Recursividad 

*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Realizar el parcial integramente en este archivo. Escribir nombre y apellido.
% Nombre y apellido: Facundo Tadic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ganador(1997,peterhansel,moto(1995, 1)).
ganador(1998,peterhansel,moto(1998, 1)).
ganador(2010,sainz,auto(touareg)).
ganador(2010,depress,moto(2009, 2)).
ganador(2010,karibov,camion([vodka, mate])).
ganador(2010,patronelli,cuatri(yamaha)).
ganador(2011,principeCatar,auto(touareg)).
ganador(2011,coma,moto(2011, 2)).
ganador(2011,chagin,camion([repuestos, mate])).
ganador(2011,patronelli,cuatri(yamaha)).
ganador(2012,peterhansel,auto(countryman)).
ganador(2012,depress,moto(2011, 2)).
ganador(2012,deRooy,camion([vodka, bebidas])).
ganador(2012,patronelli,cuatri(yamaha)).
ganador(2013,peterhansel,auto(countryman)).
ganador(2013,depress,moto(2011, 2)).
ganador(2013,nikolaev,camion([vodka, bebidas])).
ganador(2013,patronelli,cuatri(yamaha)).
ganador(2014,coma,auto(countryman)).
ganador(2014,coma,moto(2013, 3)).
ganador(2014,karibov,camion([tanqueExtra])).
ganador(2014,casale,cuatri(yamaha)).
ganador(2015,principeCatar,auto(countryman)).
ganador(2015,coma,moto(2013, 2)).
ganador(2015,mardeev,camion([])).
ganador(2015,sonic,cuatri(yamaha)).
ganador(2016,peterhansel,auto(2008)).
ganador(2016,prince,moto(2016, 2)).
ganador(2016,deRooy,camion([vodka, mascota])).
ganador(2016,patronelli,cuatri(yamaha)).
ganador(2017,peterhansel,auto(3008)).
ganador(2017,sunderland,moto(2016, 4)).
ganador(2017,nikolaev,camion([ruedaExtra])).
ganador(2017,karyakin,cuatri(yamaha)).
ganador(2018,sainz,auto(3008)).
ganador(2018,walkner,moto(2018, 3)).
ganador(2018,nicolaev,camion([vodka, cama])).
ganador(2018,casale,cuatri(yamaha)).
ganador(2019,principeCatar,auto(hilux)).
ganador(2019,prince,moto(2018, 2)).
ganador(2019,nikolaev,camion([cama, mascota])).
ganador(2019,cavigliasso,cuatri(yamaha)).

pais(peterhansel,francia).
pais(sainz,espania).
pais(depress,francia).
pais(karibov,rusia).
pais(patronelli,argentina).
pais(principeCatar,catar).
pais(coma,espania).
pais(chagin,rusia).
pais(deRooy,holanda).
pais(nikolaev,rusia).
pais(casale,chile).
pais(mardeev,rusia).
pais(sonic,polonia).
pais(prince,australia).
pais(sunderland,reinoUnido).
pais(karyakin,rusia).
pais(walkner,austria).
pais(cavigliasso,argentina).

etapa(marDelPlata,santaRosa,60).
etapa(santaRosa,sanRafael,290).
etapa(sanRafael,sanJuan,208).
etapa(sanJuan,chilecito,326).
etapa(chilecito,fiambala,177).
etapa(fiambala,copiapo,274).
etapa(copiapo,antofagasta,477).
etapa(antofagasta,iquique,557).
etapa(iquique,arica,377).
etapa(arica,arequipa,478).
etapa(arequipa,nazca,246).
etapa(nazca,pisco,276).
etapa(pisco,lima,29).

%%%%%%%% Resolver a partir de aca:
%%%%%%%% Punto 1

marca(peugeot,modeloAuto(2008)).
marca(peugeot,modeloAuto(3008)).
marca(mini,modeloAuto(countryman)).
marca(volkswagen,modeloAuto(touareg)).
marca(toyota,modeloAuto(hilux)).

%Para agregar un modelo mas a la marca mini simplemente bastaria con agregar:
%marca(mini,modeloAuto(buggy)).
%y no hace falta agregar el que no lo es ya que por el principio de Universo Cerrado se agrega solamente lo que es verdadero
%, lo que no esta/existe es falso.

%%%%%%%% Punto 2

ganadorReincidente(Competidor):-
    ganador(Anio,Competidor,_),
    ganador(OtroAnio,Competidor,_),
    Anio\=OtroAnio.


%%%%%%%% Punto 3

ganoAlgunaCompeticion(Competidor):-
    ganador(_,Competidor,_).

ganoUnoDeLosDos(Competidor,OtroCompetidor):-
    ganoAlgunaCompeticion(Competidor),
    not(ganoAlgunaCompeticion(OtroCompetidor)).


inspiraA(CompetidorInsipirado,CompetidorInspirador):-
    sonDelMismoPais(CompetidorInsipirado,CompetidorInspirador),
    ganoUnoDeLosDos(CompetidorInspirador,CompetidorInsipirado).

inspiraA(CompetidorInsipirado,CompetidorInspirador):-
    sonDelMismoPais(CompetidorInsipirado,CompetidorInspirador),
    ganoAntes(CompetidorInspirador,CompetidorInsipirado).
    

sonDelMismoPais(Competidor,OtroCompetidor):-
    pais(Competidor,Pais),
    pais(OtroCompetidor,Pais).

ganoAntes(Competidor,OtroCompetidor):-
    ganador(Anio,Competidor,_),
    ganador(OtroAnio,OtroCompetidor,_),
    Anio<OtroAnio,
    Competidor\=OtroCompetidor.

%%%%%%%% Punto 4

esVehiculo(Vehiculo):-
    ganador(_,_,Vehiculo).

marcaVehiculo(auto(Modelo),Marca):-
    marca(Marca,modeloAuto(Modelo)).

marcaVehiculo(moto(Anio,_),Marca):-
    marcaMoto(Anio,Marca).

marcaVehiculo(cuatri(Marca),Marca).

marcaVehiculo(camion(Items),Marca):-
    marcaCamion(Items,Marca).



marcaMoto(Anio,ktm):-
    Anio>=2000.

marcaMoto(Anio,yamaha):-
    Anio<2000.

marcaCamion(Items,kamaz):-
    member(vodka,Items).

marcaCamion(Items,iveco):-
    not(member(vodka,Items)).



marcaDeLaFortuna(Competidor,MarcaFavorita):-
    ganoAlgunaCompeticion(Competidor),
    ganoCon(_,MarcaFavorita),
    forall(ganador(_,Competidor,Vehiculo),ganoCon(Vehiculo,MarcaFavorita)).


ganoCon(Vehiculo,MarcaFavorita):-
    esVehiculo(Vehiculo),
    marcaVehiculo(Vehiculo,MarcaFavorita).


%%%%%%%% Punto 5


marcaCara(mini).
marcaCara(iveco).
marcaCara(toyota).

cantSuspeciones(moto(_,CantSuspenciones),CantSuspenciones).
cantSuspeciones(cuatri(_),4).

vehiculoCaro(Vehiculo):-
    marcaVehiculo(Vehiculo,Marca),
    marcaCara(Marca).

vehiculoCaro(Vehiculo):-
    cantSuspeciones(Vehiculo,CantSuspenciones),
    CantSuspenciones>=3.

noEsCorredorCheto(Competidor):-
    ganador(Anio,Competidor,Vehiculo),
    not(vehiculoCaro(Vehiculo)),
    forall((ganador(Anio,Competidores,Vehiculos),Competidor\=Competidores),vehiculoCaro(Vehiculos)).

heroePopular(Competidor):-
    inspiraA(_,Competidor),
    noEsCorredorCheto(Competidor).

%%%%%%%% Punto 6

%A)

distanciaEntreCiudades(CiudadDeInicio,CiudadDeFin,Distancia):-
    etapa(CiudadDeInicio,CiudadDeFin,Distancia).

distanciaEntreCiudades(CiudadDeInicio,CiudadDeFin,Distancia):-
    etapa(CiudadDeInicio,CiudadIntermedia,Tramo),
    distanciaEntreCiudades(CiudadIntermedia,CiudadDeFin,OtroTramo),
    Distancia is OtroTramo + Tramo.

%B)
recorridoSegunVehiculo(Vehiculo,2000):-
    vehiculoCaro(Vehiculo).

recorridoSegunVehiculo(Vehiculo,1800):-
    marcaVehiculo(Vehiculo,_),
    not(vehiculoCaro(Vehiculo)).

recorridoSegunVehiculo(camion(Items),Distancia):-
    length(Items,CantItems),
    Distancia is CantItems*1000.
    

puedeRecorrer(Vehiculo,Distancia):-
    recorridoSegunVehiculo(Vehiculo,DistanciaTotalPosible),
    DistanciaTotalPosible>=Distancia.

%%%%%%%% Punto 7 Tomo el 6c como PUNTO 7
/*
destinoMasLejano(Vehiculo,CiudadDeInicio,CiudadDeFin):-
    puedeRecorrer(Vehiculo,Distancia),
    findall(CiudadTransitada,(distanciaEntreCiudades(CiudadDeInicio,CiudadTransitada,OtraDistancia),Distancia>OtraDistancia),Ciudades),
    last(Ciudades,CiudadDeFin).
*/

destinoMasLejano(Vehiculo,CiudadDeInicio,CiudadDeFin):-
    puedeRecorrer(Vehiculo,Distancia),
    ciudadPorDistancia(CiudadDeInicio,Distancia,CiudadDeFin).
  
ciudadPorDistancia(CiudadDeInicio,Distancia,CiudadDeFin):-  
    findall(CiudadTransitada,(distanciaEntreCiudades(CiudadDeInicio,CiudadTransitada,OtraDistancia),Distancia>OtraDistancia),Ciudades),
    last(Ciudades,CiudadDeFin).