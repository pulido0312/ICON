(deftemplate   oav-u
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)

(defrule hechos_univaluados "Hechos univaluados"
	(declare (salience 10000))
	?x <- (oav-u (objeto ?obj) (atributo ?atr) (valor ?))
	?y <- (oav-u (objeto ?obj) (atributo ?atr) (valor ?))
	(test (neq ?x ?y)
	=>
	(retract ?y)	
)
