(deftemplate oav-u "Hechos Univaluados"
    (slot objeto (type SYMBOL))
    (slot atributo (type SYMBOL))
    (slot valor)
)

(deftemplate oav-m "Hechos Multivaluados"
    (slot objeto (type SYMBOL))
    (slot atributo (type SYMBOL))
    (slot valor)
)

;Datos pacientes, hecho

(deffacts datos_Maria "Datos Maria"
    (oav-u (objeto Maria)(atributo sexo)(valor mujer))
    (oav-u (objeto Maria)(atributo edad)(valor 10))
    (oav-m (objeto Maria)(atributo sintomas)(valor dolor_de_cabeza))
    (oav-m (objeto Maria)(atributo sintomas)(valor fiebre))
    (oav-m (objeto Maria)(atributo evidencia)(valor rumor_diastolico))
    (oav-u (objeto Maria)(atributo presionSis)(valor 130))
    (oav-u (objeto Maria)(atributo presionDia)(valor 60))
)

(deffacts datos_Pedro "Datos Pedro"
    (oav-u (objeto Pedro)(atributo sexo)(valor hombre))
    (oav-u (objeto Pedro)(atributo edad)(valor 80))
    (oav-m (objeto Pedro)(atributo sintomas)(valor dolor_enel_pecho))
    (oav-m (objeto Pedro)(atributo evidencia)(valor rumor_sistolico))
    (oav-m (objeto Pedro)(atributo evidencia)(valor dilatacion_corazon))
    (oav-u (objeto Pedro)(atributo presionSis)(valor 150))
    (oav-u (objeto Pedro)(atributo presionDia)(valor 95))
)

(deffacts enfermedades "Datos enfermedades a que afecta"
    (oav-u (objeto aneurisma_arteria_abdominal)
           (atributo afectan )
           (valor vasos_sanguineos)
    )
    
    (oav-u (objeto estenosis_arterial)
           (atributo afectan)
           (valor vasos_sanguineos)
    )

    (oav-u (objeto arterioesclerosis)
           (atributo afectan)
           (valor vasos_sanguineos)
    )
    
    (oav-u (objeto regurgitacion_aortica)
           (atributo afectan)
           (valor corazon)
    )
)

;Semantica hechos univaluados

(defrule hechos_univaluados "Garantiza la semantica de los tripletes univaluados"
    (declare (salience 1000))
    ?f <- (oav-u (objeto ?obj) (atributo ?atr) (valor ?))
    ?g <- (oav-u (objeto ?obj) (atributo ?atr) (valor ?))
    (test (neq ?f ?g))
    =>
    (retract ?g)
)

(defrule 15.enfermedad "Detecta aneurisma en la arteria abdominal"
    (objeto ?persona)(atributo sintomas)(valor dolor_abdominal)
    (objeto ?persona)(atributo evidencia)(valor rumor_abdomminal)
    (objeto ?persona)(atributo evidencia)(valor masa_pulsante)
	=>
    (assert (oav-m(objeto ?persona)(atributo enfermedad)(valor 	aneurisma_arteria_abdominal)))
)

(defrule 16.pulso "Calcula la presion del pulso"
	(objeto ?persona)(atributo presionSis)(valor ?sistolica)
	(objeto ?persona)(atributo presionDia)(valor ?diastolica)
	=>
	(assert(objeto ?persona)(atributo presionPulso)(valor (- ?sistolica ?diastolica)))
)

(defrule 16.enfermedad "Detecta regurgitacion aortica"
	(objeto ?persona)(atributo presionSis)(valor ?sistolica & :(>=?sistolica 130 ))
    	(objeto ?persona)(atributo presionPulso)(valor ?pulso & :(>=?pulso50 ))
    	(objeto ?persona)(atributo evidencia)(valor rumor_sistolico | dilatacion_corazon)
	=>
    	(assert (oav-m(objeto ?persona)(atributo enfermedad)(valor regurgitacion_aortica)))
)

(defrule 17.enfermedad "Detecta regurgitacion aortica"
	(objeto ?persona)(atributo sintomas)(valor calambre)
	=>
    	(assert (oav-m(objeto ?persona)(atributo enfermedad)(valor estenosis_arterial)))
)

(defrule 17.riesgo "Detecta si un paciente es de riesgo"
	(or(objeto ?persona)(atributo obeso)(valor true))
	   (objeto ?persona)(atributo fumador_tiempo)(valor ?tiempo &:(>?tiempo 10))
	   (objeto ?persona)(atributo edad)(valor ?edad &:(>?edad 55)))
	=>
    	(assert (oav-u (objeto ?persona)(atributo Paciente_riesgo)(valor true)))
)

;estenosis y arteriosclerosis, e imprimir
