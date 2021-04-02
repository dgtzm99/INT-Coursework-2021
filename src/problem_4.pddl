(define
    (problem problem_4)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects 
            kitchen1
        
            waiter1 waiter2 waiter3
        
            table1 table2 table3 table4
            order1 order2 order3 order4
        
            ; t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 - tile
            ; t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 - tile
            ; t23 t24 t25 t26 t27 t28 t29 t30 - tile
        
    )
    (:init
        ;identity predicates
        (kitchen kitchen1)
        (waiter waiter1) (waiter waiter2) (waiter waiter3)
        (table table1) (table table2) (table table3) (table table4)
        (location table1) (location table2) (location table3) 
        (location table4) (location kitchen1)
        ;(tile t1) (tile t2) (tile t3) (tile t4) (tile t5)
        ;(tile t6) (tile t7) (tile t8) (tile t9) (tile t10)
        ;(tile t11) (tile t12) (tile t13) (tile t14) (tile t15)
        ;(tile t16) (tile t17) (tile t18) (tile t19)
        (order order1) (order order2) (order order3) (order order4)

        ;order predicates
        (waiterFree waiter1) (waiterFree waiter2) (waiterFree waiter3)
        (orderFrom order1 table1) (orderFrom order2 table2)
        (orderFrom order3 table3) (orderFrom order4 table4)
        
       ;locations
        ; (atCook cook1 t3) 
        ; (atTable table1 t1) (atTable table2 t5) 
        ; (atTable table3 t17) (atTable table4 t19)
        ; (atWaiter waiter1 t7) (atWaiter waiter2 t8)
        ; (atWaiter waiter3 t9)

        (atWaiter waiter1 kitchen1) (atWaiter waiter2 kitchen1) 
        (atWaiter waiter3 kitchen1)

        ;tile space
        ; (accessible t1 t2) (accessible t2 t1)
        ; (accessible t1 t6) (accessible t6 t1)
        ; (accessible t2 t3) (accessible t3 t2)
        ; (accessible t2 t7) (accessible t7 t2)
        ; (accessible t3 t4) (accessible t4 t3)
        ; (accessible t3 t8) (accessible t8 t3)
        ; (accessible t4 t5) (accessible t5 t4)
        ; (accessible t4 t9) (accessible t9 t4)
        ; (accessible t5 t10) (accessible t10 t5)
            
        ; (accessible t6 t7) (accessible t7 t6)
        ; (accessible t6 t11) (accessible t11 t6)
        ; (accessible t7 t8) (accessible t8 t7)
        ; (accessible t7 t12) (accessible t12 t7)
        ; (accessible t8 t9) (accessible t9 t8)
        ; (accessible t8 t13) (accessible t13 t8)
        ; (accessible t9 t10) (accessible t10 t9)
        ; (accessible t9 t14) (accessible t14 t9)
        ; (accessible t10 t15) (accessible t15 t10)

        ; (accessible t11 t12) (accessible t12 t11)
        ; (accessible t11 t16) (accessible t16 t11)
        ; (accessible t12 t13) (accessible t13 t12)
        ; (accessible t12 t17) (accessible t17 t12)
        ; (accessible t13 t14) (accessible t14 t13)
        ; (accessible t13 t18) (accessible t18 t13)
        ; (accessible t14 t15) (accessible t15 t14)
        ; (accessible t14 t19) (accessible t19 t14)
        ; (accessible t15 t20) (accessible t20 t15)

        ; (accessible t16 t17) (accessible t17 t16)
        ; (accessible t16 t21) (accessible t21 t16)
        ; (accessible t17 t18) (accessible t18 t17)
        ; (accessible t17 t22) (accessible t22 t17)
        ; (accessible t18 t19) (accessible t19 t18)
        ; (accessible t18 t23) (accessible t23 t18)
        ; (accessible t19 t20) (accessible t20 t19)
        ; (accessible t19 t24) (accessible t24 t19)
        ; (accessible t20 t25) (accessible t25 t20)

        ; (accessible t21 t22) (accessible t22 t21)
        ; (accessible t21 t26) (accessible t26 t21)
        ; (accessible t22 t23) (accessible t23 t22)
        ; (accessible t22 t27) (accessible t27 t22)
        ; (accessible t23 t24) (accessible t24 t23)
        ; (accessible t23 t28) (accessible t28 t23)
        ; (accessible t24 t25) (accessible t25 t24)
        ; (accessible t24 t29) (accessible t29 t24)
        ; (accessible t25 t30) (accessible t30 t25)

        ; (accessible t26 t27) (accessible t27 t26)
        ; (accessible t27 t28) (accessible t28 t27)
        ; (accessible t28 t29) (accessible t29 t28)
        ; (accessible t29 t30) (accessible t30 t29)

        (=(time-to-walk kitchen1 table1)20) (=(time-to-walk table1 kitchen1)20)
        (=(time-to-walk kitchen1 table2)20) (=(time-to-walk table2 kitchen1)20)
        (=(time-to-walk kitchen1 table3)40) (=(time-to-walk table3 kitchen1)40)
        (=(time-to-walk kitchen1 table4)40) (=(time-to-walk table4 kitchen1)40)

        (=(time-to-walk table1 table2)40) (=(time-to-walk table2 table1)40)
        (=(time-to-walk table1 table3)40) (=(time-to-walk table3 table1)40)
        (=(time-to-walk table1 table4)60) (=(time-to-walk table4 table1)60)

        (=(time-to-walk table2 table3)60) (=(time-to-walk table3 table2)60)
        (=(time-to-walk table2 table4)40) (=(time-to-walk table4 table2)40)

        (=(time-to-walk table3 table4)20) (=(time-to-walk table4 table3)20)



        ;table predicate
        (orderNotTaken table1) (orderNotTaken table2)
        (orderNotTaken table3) (orderNotTaken table4)


        ;kitchen predicate
        (isKitchenFree kitchen1)

        ;functions
        (=(orderType order1)1) (=(orderType order2)2)
        (=(orderType order3)3) (=(orderType order4)4)
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