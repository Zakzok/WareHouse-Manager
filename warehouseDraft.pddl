(define (domain warehouse)

    (:requirements :action-costs :typing :conditional-effects :negative-preconditions :equality :adl :non-deterministic)
    (:types
        warehouse vehicle item - object
        distributer - warehouse
    )

    (:functions
        (total-cost)
    )

    (:predicates
        (at ?v - vehicle ?w - warehouse) ; is vehicle v at warehouse w
        (road ?w1 ?w2 - warehouse ) ; is there a road between w1 and w2
        (stock ?i - item ?w - warehouse) ; does warehouse w have stock of item i
        (load ?i - item ?v - vehicle) ; is item i loaded into vehicle v
        (empty ?v - vehicle) ; is vehicle v empty
    )

    ; drive vehicle v from warhouse w1 to warehouse w2
    (:action drive
        :parameters (?w1 ?w2 - warehouse ?v - vehicle)
        :precondition (and 
            (at ?v ?w1) ; vehicle at w1
            (road ?w1 ?w2) ; road from w1 to w2 exists
        )
        :effect (and 
            (not(at ?v ?w1)) ; vehicle not w1
            (at ?v ?w2) ; vehicle at w2
        
            (increase (total-cost) 3) ; driving costs 3
        )
        
    )
    
    ; load item i into vehicle v from warehouse w
    (:action loader
        :parameters (?w - warehouse ?v - vehicle ?i - item)
        :precondition (and
            (stock ?i ?w) ; warehouse has stock of i
            (at ?v ?w) ; v at w
            (empty ?v) ; v is empty
         )
        :effect (and
            (not (empty ?v)) ; v no longer empty
            (load ?i ?v) ; i is loaded into v
            (increase (total-cost) 1) ; loading costs 1
        )
    )

; unload item i from vehicle v into warehouse w
    (:action unloader
        :parameters (?w - warehouse ?v - vehicle ?i - item)
        :precondition (and
            (at ?v ?w) ; v at w
            (load ?i ?v) ; v has load i
         )
        :effect (and
            (empty ?v) ; v now empty
            (not(load ?i ?v)) ; v no longer has load i
            (stock ?i ?w) ; warehouse now has stock i
            (increase (total-cost) 1) ; unloading costs 1
        )
    )

)
