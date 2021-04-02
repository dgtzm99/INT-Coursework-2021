(define
    (problem problem_1)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects
            ;kitchen
            kitchen1

            ;waiters 
            waiter1 waiter2 waiter3 

            ;tables
            table1 table2 
            order1 order2 

            ;tiles
            ;t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 - tile
            ;t13 t14 t15 t16 t17 t18 t19 - tile
            )
    (:init

        ;identity predicates
        (kitchen kitchen1)
        (waiter waiter1) (waiter waiter2) (waiter waiter3)
        (table table1) (table table2)
        (location table1) (location table2) (location kitchen1)
        ;(tile t1) (tile t2) (tile t3) (tile t4) (tile t5)
        ;(tile t6) (tile t7) (tile t8) (tile t9) (tile t10)
        ;(tile t11) (tile t12) (tile t13) (tile t14) (tile t15)
        ;(tile t16) (tile t17) (tile t18) (tile t19)
        (order order1) (order order2)

        ;order predicates
        (waiterFree waiter1) (waiterFree waiter2) (waiterFree waiter3)
        (orderFrom order1 table1) (orderFrom order2 table2)

        ;locations
        ;(atKitchen kitchen1 t1)
        ;(atTable table1 t15) (atTable table2 t10) ;(atTable table3 t14)
        (atWaiter waiter1 kitchen1) (atWaiter waiter2 kitchen1) (atWaiter waiter3 kitchen1)

        ;tile space
        (=(time-to-walk kitchen1 table1)20) (=(time-to-walk table1 kitchen1)20)
        (=(time-to-walk kitchen1 table2)30) (=(time-to-walk table2 kitchen1)30)
        ;(=(time-to-walk kitchen1 table3)40) (=(time-to-walk table3 kitchen1)40)

        (=(time-to-walk table1 table2)10) (=(time-to-walk table2 table1)10)
        ;(=(time-to-walk table1 table3)15) (=(time-to-walk table3 table1)15)
        ;(=(time-to-walk table2 table3)16) (=(time-to-walk table3 table2)16)

        

        ;table predicate
        (orderNotTaken table1) (orderNotTaken table2)

        ;kitchen predicate
        (isKitchenFree kitchen1)

        ;functions
        (=(orderType order1)1) (=(orderType order2)2)
        (=(total-time-taken)0)
        ;(=(ordersCarrying waiter1)0) (=(foodCarrying waiter1)0)
        ;(=(ordersCarrying waiter2)0) (=(foodCarrying waiter2)0)
        ;(=(ordersCarrying waiter3)0) (=(foodCarrying waiter3)0)

    )
    (:goal (and
            ;(orderTaken table1)
            ;(orderTaken table2)
            ;(orderTaken table3)
            (foodDelivered table1 order1)
            (foodDelivered table2 order2)
            ;(foodDelivered table3)
        )
    )
    (:metric minimize (total-time-taken))
)