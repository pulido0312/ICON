         CLIPS (6.30 3/17/15)
CLIPS> (assert (persona "Luis Prieto" hombre 53))
<Fact-1>
CLIPS> (facts
)
f-0     (initial-fact)
f-1     (persona "Luis Prieto" hombre 53)
For a total of 2 facts.
CLIPS> (deffacts amigos "algunos amigos"
(persona "Luis Prieto" 53 1.83)
(persona "Ana Perez" 56 1.70)
)
CLIPS> (reset)
CLIPS> (defrule nombre-amigos "Encontrar el nombre de los amigos"
(declare (salience 0))
(persona ?x ? ?)
=>
 (assert(encontrado?x))
)
CLIPS> 
