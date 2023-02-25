(deftemplate oav-u "Plantilla Hechos univaluados"
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)
(deftemplate oav-m "Plantilla Hechos multivaluados"
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(multislot valor)
)

(defrule garantizar-univaluados
    (declare (salience 10000))
    ?x <- (oav-u (objeto ?o1) (atributo ?a1) (valor ?v1))
    ?y <- (oav-u (objeto ?o1) (atributo ?a1) (valor ?v2))
    (test (> (fact-index ?x) (fact-index ?y)))
=>
(retract ?y)) 

(defrule imprimir_escenario "Da a elegir los posibles escenarios al usuario"
	(declare (salience 1000))
	=>
	(printout T "Eliga un escenario de los siguientes: " crlf)
	(printout T "Escenario Nº1: Revisar MÓVIL ")
	(printout T "Escenario Nº2: Revisar TABLET ")
	(printout T "Escenario Nº3: Revisar PORTATIL " crlf)
	(printout T "Marque el Nº del caso que desee: ")
	(assert	(oav-u(objeto escenario)(atributo numero)(valor = (read T))))
)

(defrule escenario_movil "El usuario ha escogido el primer escenario"
	(oav-u(objeto escenario)(atributo numero)(valor 1))
	=>
	(assert (oav-u(objeto movil)(atributo antiguedad)(valor 14)))
	(assert (oav-u(objeto movil)(atributo so)(valor actual)))
	(assert (oav-m(objeto movil)(atributo fallo)(valor apaga_insesperadamente)))
)
(defrule escenario_tablet "El usuario ha escogido el segundo escenario"
	(oav-u(objeto escenario)(atributo numero)(valor 2))
	=>
	(assert (oav-u(objeto tablet)(atributo antiguedad)(valor 20)))
	(assert (oav-u(objeto tablet)(atributo so)(valor actual)))
	(assert (oav-m(objeto tablet)(atributo fallo)(valor error_arranque)))
	(assert (oav-m(objeto tablet)(atributo fallo)(valor ficheros_corruptos)))
)
(defrule escenario_portatil "El usuario ha escogido el tercer escenario"
	(oav-u(objeto escenario)(atributo numero)(valor 3))
	=>
	(assert (oav-u(objeto portatil)(atributo antiguedad)(valor 30)))
	(assert (oav-u(objeto portatil)(atributo so)(valor no_actual)))
	(assert (oav-m(objeto portatil)(atributo fallo)(valor no_enciende)))
)
(defrule revision_so " Comprueba que el dispositivo tenga un sistema operativo actual"
	(oav-u(objeto ?dispositivo)(atributo so)(valor no_actual))
	=>
	(assert(oav-u(objeto ?dispositivo)(atributo evaluable)(valor False)))
	(printout T "El dispositivo "?dispositivo" no posee un sistema operativo actual por lo que no podrá ser revisado" crlf)
)
(defrule revision_garantia " Comprueba que el dispositivo tenga la garantia vigente"
	(oav-u(objeto ?dispositivo)(atributo antiguedad)(valor ?anos &:(> ?anos 24)))
	=>
	(assert(oav-u(objeto ?dispositivo)(atributo evaluable)(valor False)))
	(printout T "El dispositivo "?dispositivo" tiene una antiguedad mayor a 2 años, por lo que carece de garantia y por ende no podra ser revisado" crlf)
) 
(defrule problema_so "Detecta si hay un problema en el sistema operativo"
	(or(oav-m(objeto ?dispositivo)(atributo fallo)(valor error_arranque))
	   (oav-m(objeto ?dispositivo)(atributo fallo)(valor ficheros_corruptos)))
	=>
	(assert (oav-m(objeto ?dispositivo)(atributo problema)(valor problema_so)))
)
(defrule problema_s_alimentacion "Detecta si hay un problema en el sistema operativo"
	(and(oav-m(objeto ?dispositivo)(atributo fallo)(valor bateria))
	   (or(oav-m(objeto ?dispositivo)(atributo fallo)(valor apaga_inesperadamente))
	      (oav-m(objeto ?dispositivo)(atributo fallo)(valor no_enciende))))
	=>
	(assert (oav-m(objeto ?dispositivo)(atributo problema)(valor problema_s_alimentacion)))
) 
(defrule mal_uso_dispositivo "Detecta si hay un mal uso del dispositivo"
	(oav-m(objeto ?dispositivo)(atributo problema)(valor problema_s_alimentacion))
	(oav-m(objeto ?dispositivo)(atributo fallo)(valor golpes))
	=>
	(assert (oav-m(objeto ?dispositivo)(atributo problema)(valor mal_uso)))
)
(defrule diagnostico_problema "Presenta los problemas que pueda haber en el dispositivo"
	(declare (salience -1000))
	(oav-m(objeto ?dispositivo)(atributo problema)(valor ?problema))
	=>
	(printout T "El dispositivo presenta " ?problema "." crlf)
)
(defrule diagnostico_no_problema "Presenta los problemas que pueda haber en el dispositivo"
	(declare (salience -1000))
	(oav-u(objeto ?dispositivo)(atributo antiguedad))
	(not(oav-m(objeto ?dispositivo)(atributo problema)(valor ?problema)))
	(not(oav-u(objeto ?dispositivo)(atributo evaluable)(valor False)))
	
	=>
	(printout T "El dispositivo ha estado en el proceso de evaluacion pero no se ha conseguido saber su problema " crlf)
)

	
