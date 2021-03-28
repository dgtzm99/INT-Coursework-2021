(define
    (problem problem_1)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects
            ;cook
            david - cook

            ;waiters 
            bob emily michael - waiter

            ;tables
            table1 table2 - table
            order1 order2 - order

            ;tiles
            t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 - tile
            t13 t14 t15 t16 t17 t18 t19 - tile)

    (:init

        ;identity predicates
        ;(cook david)
        ;(waiter bob) (waiter emily) (waiter michael)
        ;(table table1) (table table2)
        ;(tile t1) (tile t2) (tile t3) (tile t4) (tile t5)
        ;(tile t6) (tile t7) (tile t8) (tile t9) (tile t10)
        ;(tile t11) (tile t12) (tile t13) (tile t14) (tile t15)
        ;(tile t16) (tile t17) (tile t18) (tile t19)
        ;(order order1) (order order2)

        ;order predicates
        (waiterFree bob) (waiterFree emily) (waiterFree michael)
        (orderFrom order1 table1) (orderFrom order2 table2)

        ;locations
        (atCook david t1)
        (atTable table1 t15) (atTable table2 t10) ;(atTable table3 t14)
        (atWaiter bob t2) (atWaiter emily t3) (atWaiter michael t4)

        ;tile space
        (accessible t1 t2) (accessible t2 t1)
        (accessible t2 t3) (accessible t3 t2)
        (accessible t3 t4) (accessible t4 t3)
        (accessible t4 t5) (accessible t5 t4)
        (accessible t5 t8) (accessible t8 t5)
        (accessible t8 t11) (accessible t11 t8)
        (accessible t11 t14) (accessible t14 t11)
        (accessible t14 t19) (accessible t19 t14)
        (accessible t19 t18) (accessible t18 t19)
        (accessible t18 t17) (accessible t17 t18)
        (accessible t17 t16) (accessible t16 t17)
        (accessible t16 t15) (accessible t15 t16)
        (accessible t15 t12) (accessible t12 t15)
        (accessible t12 t9) (accessible t9 t12)
        (accessible t9 t6) (accessible t6 t9)
        (accessible t6 t1) (accessible t1 t6)
        (accessible t3 t7) (accessible t7 t3)
        (accessible t7 t10) (accessible t10 t7)
        (accessible t10 t13) (accessible t13 t10)
        (accessible t13 t17) (accessible t17 t13)

        ;table predicate
        (orderNotTaken table1) (orderNotTaken table2)

        ;kitchen predicate
        (isCookFree david)

        ;functions
        (=(orderType order1)1) (=(orderType order2)2)
        (=(total-time-taken)0)

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