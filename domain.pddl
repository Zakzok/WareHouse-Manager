(define (domain warehouseManager)
    (:requirements :equality :negative-preconditions :typing :adl :fluents)
    (:types
        item container - object ;two main item types, items and containers
        place vehicle - container ;containers are either places or vehicles
        warehouse supplier - place ;places are either warehouses or suppliers
    )
    (:predicates
        (con ?p1 ?p2 - place);are places p1 and p2 connected
        (at ?v - vehicle ?p - place) ;is vehicle v at place p?
        (driving ?p1 ?p2 - place ?v - vehicle) ;currently driving from p1 to p2
    )


    (:functions
        (transTime ?p1 ?p2 - place) ;time required for transport between place p1 and p2
        (cur_transTime ?v - vehicle) ;current time vehicle has traveled for
        
        (maxItem ?c - container);maximum amount of item container can hold
        (curItem ?c - container);current amount of item container holds
        (stock ?c - container ?i - item) ;amount of item i at warehouse w
        
        (buyPrice ?i - item) ;price of buying 1 of item i
        (sellPrice ?i - item) ;amount gained by selling 1 of item i
        (demand ?i - item ?w - warehouse) ;demand of item i at warehouse w (per day)
        (sold ?i - item ?w - warehouse) ;amount of item i sold at warehouse w (per day)
        (netProfit) ;total amount of profit

        (hour) ;which hour of the day we're in
        (maxHour)  ;which day we are in
        (day) ;current number of days
        
        
    )

    ;load one ton of item onto vehicle from warehouse
    (:action load_Item
        :parameters (?w - warehouse ?v - vehicle ?i - item)
        :precondition (and
            (at ?v ?w) ;vehicle at warehouse
            (> (stock ?w ?i) 0) ;warehouse has stock of item i
            (> (maxItem ?v) (curItem ?v)) ;vehicle has space for item
        )
        :effect (and 
            (increase (curItem ?v) 1) ;vehicle has 1 less space
            (increase (stock ?v ?i) 1) ;vehicle has 1 more of item

            (decrease (curItem ?w) 1) ;warehouse has 1 more space
            (decrease (stock ?w ?i) 1) ;warehouse has 1 less of item
        )
    )
    
    ;unload one ton of item from vehicle into warehouse
    (:action unload_Item
        :parameters (?w - warehouse ?v - vehicle ?i - item)
        :precondition (and
            (at ?v ?w) ;vehicle at warehouse
            (> (stock ?v ?i) 0) ;vehicle has stock of item i
            (> (maxItem ?w) (curItem ?w)) ;warehouse has space for item
        )
        :effect (and 
            (decrease (curItem ?v) 1) ;vehicle has 1 less space
            (decrease (stock ?v ?i) 1) ;vehicle has 1 more of item

            (increase (curItem ?w) 1) ;warehouse has 1 more space
            (increase (stock ?w ?i) 1) ;warehouse has 1 less of item
        )
    )

    ;begin driving vehicle v from place p1 to p2
    (:action begin_Drive
        :parameters (?p1 ?p2 - place ?v - vehicle)
        :precondition (and
            (at ?v ?p1) ;vehicle is at p1
            (con ?p1 ?p2) ;p1 and p2 are connected
         )
        :effect (and 
            (not(at ?v ?p1)) ;vehicle is at p1
            (driving ?p1 ?p2 ?v) ;vehicle is now being driven
        )
    )

    ;vehicle v is being driven from p1 to p2
    (:process ongoing_Drive
        :parameters (?p1 ?p2 - place ?v - vehicle)
        :precondition (and
            (driving ?p1 ?p2 ?v) ;car is being driven from p1 to p2
            (< (cur_transTime ?v )(transTime ?p1 ?p2))
            ;time spent driving is < total time it takes to go from p1 to p2
        )
        :effect (and
            (increase (cur_transTime ?v) (* #t 1.0)) ;increase transTime by 1
            (decrease (netProfit) (* #t 0.05)) ;pay minimizal cost for transport
        )
    )
    
    ;vehicle v arrives at p2 from p1
    (:action end_Drive
        :parameters (?p1 ?p2 - place ?v - vehicle)
        :precondition (and
            (driving ?p1 ?p2 ?v) ;car is being driven from p1 to p2
            (>= (cur_transTime ?v)(transTime ?p1 ?p2))
            ;time spent driving is >= total time it takes to go from p1 to p2
         )
        :effect (and 
            (at ?v ?p2) ;vehicle is at p2
            (not(driving ?p1 ?p2 ?v)) ;vehicle no longer being driven
            (decrease (cur_transTime ?v) (transTime ?p1 ?p2)) ;reset drive time to 0
        )
    )

    ;buy 1 of item i from supplier s and load it into vehicle v
    (:action buy_Item
        :parameters (?s - supplier ?v - vehicle ?i - item)
        :precondition (and
            (at ?v ?s) ;vehicle at supplier
            (> (maxItem ?v) (curItem ?v)) ;vehicle has space
        )
        :effect (and
            (increase (curItem ?v) 1) ;decrease space in v by 1
            (increase (stock ?v ?i) 1) ;increase stock by 1
            (decrease (netProfit) (buyPrice ?i)) ;pay the cost of buying
        )
    )

    (:action sell_Item
        :parameters (?w - warehouse ?i - item)
        :precondition (and
            (> (demand ?i ?w) (sold ?i ?w))
            (> (stock ?w ?i) 0)
        )
        :effect (and 
            (increase (sold ?i ?w) 1)
            (decrease (stock ?w ?i) 1) ;decrease stock
            (decrease (curItem ?w) 1) ;increase available space
            (increase (netProfit) (sellPrice ?i)) ;increase netprofit
        )
    )
    


    ;-------------------------------------------------
    ;from this point on, we have simulation functions
    ;-------------------------------------------------
    
    ;move hours of the day along
    (:process tick_tock
        :parameters ()
        :precondition (and
            (> (maxHour) (hour)) ;have not yet reached maximum hours (24)
        )
        :effect (and
            (increase (hour) (* #t 1.0)) ;increase time by 1
        )
    )

    ;reset demand
    (:event reset_Demand
        :parameters (?w - warehouse ?i - item)
        :precondition (and
            (>= (hour) 24) ;number of hours in a day finished
            (> (sold ?i ?w) 0) ;sold more than 1 item 
                               ;(this is to safeguard from infinite events)
        )
        :effect (and
            (assign (sold ?i ?w) 0) ;amount sold is back to 0
        )
    )

    ;move forward one day
    (:event wrap_Day
        :parameters ()
        :precondition (and
            (>= (hour) (maxHour)) ;number of hours in a day finished
        )
        :effect (and
            (decrease (hour) (maxHour)) ;reset hours
            (increase (day) 1) ;increase day count
        )
    )

)
