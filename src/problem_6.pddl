(define
    (problem problem_1)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects
            ;kitchen
            kitchen1

            ;waiters 
            waiter1 waiter2

            ;tables
            table1 table2 table3 table4
            order1 order2 order3 order4

            ;tiles
            ; t1 t2 t3 t4 t5 t6 t7 - tile
            ; t8 t9 t10 t11 t12 t13 t14 - tile
            ; t15 t16 t17 t18 t19 t20 t21 - tile)
    )

    (:init
        ;identity predicates
        (kitchen kitchen1)
        (waiter waiter1) (waiter waiter2)
        (table table1) (table table2) (table table3) (table table4)
        (location table1) (location table2) (location table3) 
        (location table4) (location kitchen1)
        (order order1) (order order2) (order order3) (order order4)

        ;order predicates
        (waiterFree waiter1) (waiterFree waiter2)
        (orderFrom order1 table1) (orderFrom order2 table2) (orderFrom order3 table3) (orderFrom order4 table4) 

        ;locations
        ; (atCook cook1 t11)
        ; (atTable table1 t1) (atTable table2 t5) (atTable table3 t17) (atTable table4 t21)
        ; (atWaiter waiter1 t10) (atWaiter waiter2 t12)

        (atWaiter waiter1 kitchen1) (atWaiter waiter2 kitchen1)

;tiles grid
    ;    (accessible t1 t2) (accessible t2 t1) 
    ;    (accessible t1 t6) (accessible t6 t1)
    ;    (accessible t2 t3) (accessible t3 t2)
    ;    (accessible t3 t7) (accessible t7 t3) 
    ;    (accessible t3 t4) (accessible t4 t3) 
    ;    (accessible t4 t5) (accessible t5 t4) 
    ;    (accessible t5 t8) (accessible t8 t5)
    ;    (accessible t6 t9) (accessible t9 t6)
    ;    (accessible t7 t11) (accessible t11 t7) 
    ;    (accessible t8 t3) (accessible t3 t8)
    ;    (accessible t9 t14) (accessible t14 t9)
    ;    (accessible t9 t10) (accessible t10 t9) 
    ;    (accessible t10 t11) (accessible t11 t10)
    ;    (accessible t11 t15) (accessible t15 t11)
    ;    (accessible t11 t12) (accessible t12 t11)
    ;    (accessible t12 t13) (accessible t13 t12)
    ;    (accessible t13 t8) (accessible t8 t13) 
    ;    (accessible t13 t16) (accessible t16 t13)
    ;    (accessible t15 t19) (accessible t19 t15)
    ;    (accessible t16 t20) (accessible t20 t16)
    ;    (accessible t17 t14) (accessible t14 t17)
    ;    (accessible t18 t17) (accessible t17 t18)
    ;    (accessible t18 t19) (accessible t19 t18)
    ;    (accessible t19 t20) (accessible t20 t19)
    ;    (accessible t20 t21) (accessible t21 t20)
    ;    (accessible t21 t16) (accessible t16 t21)

        (=(time-to-walk kitchen1 table1)10) (=(time-to-walk table1 kitchen1)10)
        (=(time-to-walk kitchen1 table2)20) (=(time-to-walk table2 kitchen1)20)
        (=(time-to-walk kitchen1 table3)15) (=(time-to-walk table3 kitchen1)15)
        (=(time-to-walk kitchen1 table4)35) (=(time-to-walk table4 kitchen1)35)

        (=(time-to-walk table1 table2)30) (=(time-to-walk table2 table1)30)
        (=(time-to-walk table1 table3)25) (=(time-to-walk table3 table1)25)
        (=(time-to-walk table1 table4)45) (=(time-to-walk table4 table1)45)

        (=(time-to-walk table2 table3)10) (=(time-to-walk table3 table2)10)
        (=(time-to-walk table2 table4)15) (=(time-to-walk table4 table2)15)

        (=(time-to-walk table3 table4)20) (=(time-to-walk table4 table3)20)
        
        ;table predicate
        (orderNotTaken table1) (orderNotTaken table2)
        (orderNotTaken table3) (orderNotTaken table4)

        ;kitchen predicate
        (isKitchenFree kitchen1)

        ;functions
        (=(order-cooking-time order1)1) (=(order-cooking-time order2)2) 
        (=(order-cooking-time order3)3) (=(order-cooking-time order4)4)
        (=(total-time-taken)0)

    )
    (:goal (and
            (foodDelivered table1 order1)
            (foodDelivered table2 order2)
            (foodDelivered table3 order3)
            (foodDelivered table4 order4)
        )
    )
    (:metric minimize (total-time-taken))
)
