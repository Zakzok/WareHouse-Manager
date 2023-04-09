 (define (problem warehouseManager_1)
    (:domain warehouseManager)
    (:objects
        w1 w2 - warehouse ; 2 total warehouses
        s - supplier ;one supplier only
        v1 v2 - vehicle ; 2 vehicles
        i1 i2 i3 i4 - item ; 4 types of items sold
    )

    (:init
        ;set up connections 
        (con w1 w2)
        (= (transTime w1 w2) 1)
        (con w2 w1)
        (= (transTime w2 w1) 1)

        (con w1 s)
        (= (transTime w1 s) 2)
        (con s w1)
        (= (transTime s w1) 2)

        (con w2 s)
        (= (transTime w2 s) 10)
        (con s w2)
        (= (transTime s w2) 10)

        ;set up vehicles
        (at v1 w1)
        (= (cur_transTime v1) 0) ;all vehicles are sedentary at first
        (= (maxItem v1) 10) ;total capacity
        (= (curItem v1) 0)  ;vehicle initially empty
        (= (stock v1 i1) 0) ;has no stock of i1
        (= (stock v1 i2) 0) ;has no stock of i2

        (at v2 s)
        (= (cur_transTime v2) 0)
        (= (maxItem v2) 10) 
        (= (curItem v2) 0)
        (= (stock v2 i1) 0)
        (= (stock v2 i2) 0)

        ;set up warehouse stocks
        ;warehouse w1;
        (= (maxItem w1) 10) ;total amount of space in warehouse
        (= (curItem w1) 0)  ;current amount of space in warehouse
        (= (stock w1 i1) 0) ;stock of item i1 in warehouse
        (= (stock w1 i2) 0) ;stock of item i2 in warehouse
        (= (stock w1 i3) 0) 
        (= (stock w1 i4) 0)
        (= (demand i1 w1) 2) ;demand of i1 in warehouse
        (= (demand i2 w1) 2) ;demand of i2 in warehouse
        (= (demand i3 w1) 2)
        (= (demand i4 w1) 1)
        (= (sold i1 w1) 0)  ;total amount of i1 sold initially (always 0)
        (= (sold i2 w1) 0)  ;total amount of i2 sold initially (always 0)
        (= (sold i3 w1) 0)
        (= (sold i4 w1) 0)


        ;warehouse w2;
        (= (maxItem w2) 10)
        (= (curItem w2) 0)
        (= (stock w2 i1) 0)
        (= (stock w2 i2) 0)
        (= (stock w2 i3) 0) 
        (= (stock w2 i4) 0)
        (= (demand i1 w2) 2)
        (= (demand i2 w2) 0)
        (= (demand i3 w2) 0)
        (= (demand i4 w2) 2)
        (= (sold i1 w2) 0)
        (= (sold i2 w2) 0)
        (= (sold i3 w2) 0)
        (= (sold i4 w2) 0)

        ;set up buy/sell prices of items
        (=(buyPrice i1) 0)
        (=(sellPrice i1) 1)
        (=(buyPrice i2) 0)
        (=(sellPrice i2) 1)
        (=(buyPrice i3) 0)
        (=(sellPrice i3) 1)
        (=(buyPrice i4) 0)
        (=(sellPrice i4) 2)
        
        ;--------------------------------------------------------
        ;the following settings are not to be touched by the user
        ;--------------------------------------------------------

        ;initialize net profit
        (= (netProfit) 0)

        ;initialize tick-tock
        (= (hour) 0)
        (= (maxHour) 24)

        ;intitalize days
        (= (day) 0)


    )

    (:goal 
        (and
            (>= (netProfit) 5)

            (<= (day) 3)
        )
    )

)
