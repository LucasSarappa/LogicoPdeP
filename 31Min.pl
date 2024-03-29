https://github.com/Agustoledo10/Prolog/blob/cfb9d12a9c9f8f1caeab8eb8f2c13f3c3cd5f10e/parcial31Min.pl

UTN.BA Pdep Jueves Mañana - Parcial Paradigma Lógico - Jueves 13 de Julio de 2023
________________




31 Minutos: Prolog Chileno
  

En las lejanas y míticas tierras de Santiago de Chile se localiza el noticiero llamado 31 Minutos. El noticiero es reconocido por su amplia variedad de tópicos que reporta, de los cuales incluye noticias de la industria musical. Esta semana 31 Minutos recibió una base de conocimientos con información referida a las canciones más populares del momento y, mediante Prolog Chileno, quieren sacar algunas conclusiones para reportar en sección de noticias de música de la semana que viene.


Canciones
De las canciones se conocen sus compositores y su cantidad de reproducciones.


% Cancion, Compositores,  Reproducciones
cancion(bailanSinCesar, [pabloIlabaca, rodrigoSalinas], 10600177).
cancion(yoOpino, [alvaroDiaz, carlosEspinoza, rodrigoSalinas], 5209110).
cancion(equilibrioEspiritual, [danielCastro, alvaroDiaz, pabloIlabaca, pedroPeirano, rodrigoSalinas], 12052254).
cancion(tangananicaTanganana, [danielCastro, pabloIlabaca, pedroPeirano], 5516191).
cancion(dienteBlanco, [danielCastro, pabloIlabaca, pedroPeirano], 5872927). 


cancion(lala, [pabloIlabaca, pedroPeirano], 5100530).
%Revisa el archivo del repo, que este hecho estaba con un argumento de más.


cancion(meCortaronMalElPelo, [danielCastro, alvaroDiaz, pabloIlabaca, rodrigoSalinas], 3428854).
	También se conoce el ranking de top 3 canciones más valoradas por los críticos de música durante los últimos 5 meses. Los críticos cambian mucho de opinión por lo que es común que una canción tenga diferente posición en el ranking a lo largo de los meses.


% Mes, Puesto, Cancion
rankingTop3(febrero, 1, lala).
rankingTop3(febrero, 2, tangananicaTanganana).
rankingTop3(febrero, 3, meCortaronMalElPelo).
rankingTop3(marzo, 1, meCortaronMalElPelo).
rankingTop3(marzo, 2, tangananicaTanganana).
rankingTop3(marzo, 3, lala).
rankingTop3(abril, 1, tangananicaTanganana).
rankingTop3(abril, 2, dienteBlanco).
rankingTop3(abril, 3, equilibrioEspiritual).
rankingTop3(mayo, 1, meCortaronMalElPelo).
rankingTop3(mayo, 2, dienteBlanco).
rankingTop3(mayo, 3, equilibrioEspiritual).
rankingTop3(junio, 1, dienteBlanco).
rankingTop3(junio, 2, tangananicaTanganana).
rankingTop3(junio, 3, lala).
	1. Saber si una canción es un hit, lo cual ocurre si aparece en el ranking top 3 de todos los meses.
Ejemplo: No hay ningún hit actualmente. Por ejemplo, a Tangananica Tanganana le falta estar en mayo y a Lala le falta abril y mayo.


2. Saber si una canción no es reconocida por los críticos, lo cual ocurre si tiene muchas reproducciones y nunca estuvo en el ranking. Una canción tiene muchas reproducciones si tiene más de 7000000 reproducciones.


3. Saber si dos compositores son colaboradores, lo cual ocurre si compusieron alguna canción juntos.


  



Trabajos


En el noticiero 31 Minutos cada trabajador puede tener múltiples trabajos. Algunos de los tipos de trabajos que existen son:
* Los conductores, de los cuales nos interesa sus años de experiencia.
* Los periodistas, de los cuales nos interesa sus años de experiencia y su título, el cual puede ser licenciatura o posgrado. 
* Los reporteros, de los cuales nos interesa sus años de experiencia y la cantidad de notas que hicieron a lo largo de su carrera.




4. Modelar en la solución a los siguientes trabajadores:
   1. Tulio, conductor con 5 años de experiencia.
   2. Bodoque, periodista con 2 años de experiencia con un título de licenciatura, y también reportero con 5 años de experiencia y 300 notas realizadas.
   3. Mario Hugo, periodista con 10 años de experiencia con un posgrado.
   4. Juanin, que es un conductor que recién empieza así que no tiene años de experiencia.


5. Conocer el sueldo total de una persona, el cual está dado por la suma de los sueldos de cada uno de sus trabajos. El sueldo de cada trabajo se calcula de la siguiente forma:
   1. El sueldo de un conductor es de 10000 por cada año de experiencia
   2. El sueldo de un reportero también es 10000 por cada año de experiencia más  100 por cada nota que haya hecho en su carrera.
   3. Los periodistas, por cada año de experiencia reciben 5000, pero se les aplica un porcentaje de incremento del 20% cuando tienen una licenciatura o del 35% si tienen un posgrado.


6. Agregar un nuevo trabajador que tenga otro tipo de trabajo nuevo distinto a los anteriores. Agregar una forma de calcular el sueldo para el nuevo trabajo agregado ¿Qué concepto de la materia se puede relacionar a esto?


          
/