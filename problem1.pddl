
(define (problem warehouse_1)
    (:domain warehouse)
    (:objects 
        w1 - warehouse ; master warehouses that always have stock
        d1 d2 d3 d4 d5 - distributer ; distributor warehouses
        v1 v2 v3 v4 - vehicle ; vehicles used for transport
        i1 i2 i3 i4 i5 i6 - item ; types of items possibly in stock
    )

    (:init
        ; set up roads, they can be one way or two way
        ; in this scenario, roads are two way
        (road w1 d2)
        (road d2 w1)

        (road w1 d4)
        (road d4 w1)

        (road d2 d3)
        (road d3 d2)

        (road d2 d1)
        (road d1 d2)

        (road d3 d4)
        (road d4 d3)

        (road d4 d5)
        (road d5 d4)

        ; vehicle is placed in d2 and d3
        (at v1 d2)
        (at v2 d3)
        (empty v1)
        (empty v2)

        ; stock up main warehouse to full
        (stock i1 w1)
        (stock i2 w1)
        (stock i3 w1)
        (stock i4 w1)
        (stock i5 w1)
        (stock i6 w1)
    )

    ; Goal is to fill up those specific distributers
    (:goal
        (and
            (stock i1 d1)
            (stock i2 d1)
            (stock i1 d4)
        )
    )
)
