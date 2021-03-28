(define
    (problem problem_3)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects 
            david - cook
            bob emily michael - waiter
            table1 table2 table3 table4 table5 - table
            order1 order2 order3 order4 order5 - order
            t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 - tile
            t13 t14 t15 t16 t17 t18 t19 t20 t21 - tile)
    (:init
        ;identity predicates
        ;(cook david)
        ;(waiter bob) (waiter emily) (waiter michael)
        ;(table table1) (table table2) (table table3) (table table4) (table table5)
        ;(order order1) (order order2) (order order3) (order order4) (order order5)
        ;(tile t1) (tile t2) (tile t3) (tile t4) (tile t5)
        ;(tile t6) (tile t7) (tile t8) (tile t9) (tile t10)
        ;(tile t11) (tile t12) (tile t13) (tile t14) (tile t15)
        ;(tile t16) (tile t17) (tile t18) (tile t19) (tile t20) 
        ;(tile t21) 

        ;order predicates
        (waiterFree bob) (waiterFree emily) (waiterFree michael)
        (orderFrom order1 table1) (orderFrom order2 table2) (orderFrom order3 table3)
        (orderFrom order4 table4) (orderFrom order5 table5) 

        ;locations
        (atCook david t1)
        (atTable table1 t5) (atTable table2 t3) (atTable table3 t18) (atTable table4 t16) (atTable table5 t9)
        (atWaiter bob t21) (atWaiter emily t13) (atWaiter michael t8)

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
        (accessible t20 t9) (accessible t9 t20)
        (accessible t20 t10) (accessible t10 t20)
        (accessible t21 t10) (accessible t10 t21)
        (accessible t21 t11) (accessible t11 t21)

        ;table predicate
        (orderNotTaken table1) (orderNotTaken table2) (orderNotTaken table3)
        (orderNotTaken table4) (orderNotTaken table5)

        ;kitchen predicate
        (isCookFree david)

        ;functions
        (=(orderType order1)1) (=(orderType order2)2) (=(orderType order3)3)
        (=(orderType order4)4) (=(orderType order5)5)
        (=(total-time-taken)0)

    )
    (:goal (and
            ;(orderTaken table1)
            ;(orderTaken table2)
            ;(orderTaken table3)
            ;(orderTaken table4)
            ;(orderTaken table5)
            (foodDelivered table1 order1)
            (foodDelivered table2 order2)
            (foodDelivered table3 order3)
            (foodDelivered table4 order4)
            (foodDelivered table5 order5)
        )
    )
    (:metric minimize (total-time-taken))
)