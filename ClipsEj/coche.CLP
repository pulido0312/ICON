(defrule fusible "estado fusible"
	(fusibleIns estado roto)
	(potencia estado desconectada)
	=> (assert(fusible estado fundido))
	   (printout t crlf "Fallo: fusible fundido" crlf)
)
(defrule bateria "estado bateria"
	(potencia estado desconectada)
	(indicador bateria cero)
	=>(assert(bateria estado baja))
	   (printout t crlf "Fallo: bateria baja" crlf)
)
(defrule deposito "estado deposito"
	(indicadorC estado cero)
	(combustible estado FALSE)
	=>(assert(deposito estado vacio))
	   (printout t crlf "Fallo: deposito combustible vacio" crlf)
)



(defrule potencia "estado potencia"
	(motor arranca FALSE)
	=>(assert(potencia estado desconectada))
)

(defrule combustible1 "estado combustible1"
	(motor arranca FALSE)
	=>(assert(combustible estado FALSE))
)


(defrule combustible2 "estado combustible2"
	(motor para TRUE)
	=>(assert(combustible estado FALSE))
)