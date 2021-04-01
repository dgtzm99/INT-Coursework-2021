(define
    (problem problem_2)
    (:domain domain_resturant)
    ;(:situation <situation_name>) ;deprecated
    (:objects 
        ;cook
        cook1 - cook
        
        ;waiters 
        waiter1 waiter2 - waiter

        ;tables 
        table1 table2 table3 - table
        order1 order2 order3 - order

        ;tiles
        t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 - tile
        t13 t14 t15 t16 t17 t18 t19 t20 - tile)

    (:init
       ;order predicates
       (waiterFree waiter1) (waiterFree waiter2)
       (orderFrom order1 table1) (orderFrom order2 table2) (orderFrom order3 table3)
       (atCook cook1 t5)
       (atTable table1 t16) (atTable table2 t18) (atTable table3 t20)
       (atWaiter waiter1 t1) (atWaiter waiter2 t2)
       
       ;tiles grid
       (accessible t1 t2) (accessible t1 t6)
       (accessible t2 t1) (accessible t2 t7) (accessible t2 t3)
       (accessible t3 t2) (accessible t3 t8) (accessible t3 t4)
       (accessible t4 t3) (accessible t4 t9) (accessible t4 t5)
       (accessible t5 t4) (accessible t5 t10)
       (accessible t6 t1) (accessible t6 t7) (accessible t6 t11)
       (accessible t7 t6) (accessible t7 t2) (accessible t7 t12) (accessible t7 t8) 
       (accessible t8 t7) (accessible t8 t3) (accessible t8 t13) (accessible t8 t9)
       (accessible t9 t8) (accessible t9 t4) (accessible t9 t14) (accessible t9 t10)
       (accessible t10 t5) (accessible t10 t9) (accessible t10 t15)
       (accessible t11 t6) (accessible t11 t12) (accessible t11 t16)
       (accessible t12 t11) (accessible t12 t7) (accessible t12 t17) (accessible t12 t13)
       (accessible t13 t12) (accessible t13 t8) (accessible t13 t14) (accessible t13 t18)
       (accessible t14 t13) (accessible t14 t9) (accessible t14 t15) (accessible t14 t19)
       (accessible t15 t14) (accessible t15 t10) (accessible t15 t20)
       (accessible t16 t11) (accessible t16 t17)
       (accessible t17 t16) (accessible t17 t12) (accessible t17 t18)
       (accessible t18 t17) (accessible t18 t13) (accessible t18 t19)
       (accessible t19 t18) (accessible t19 t14) (accessible t19 t20)
       (accessible t20 t19) (accessible t20 t15)
        
        ;ordering predicate 
        (orderNotTaken table1) (orderNotTaken table2) (orderNotTaken table3)

        ;cooking predicate
        (isCookFree cook1)

        ;functions 
        (=(orderType order1)1) (=(orderType order2)2) (=(orderType order3)3)
        (=(total-time-taken)0)
        ;new (carrying restrictions)
        ;(=(ordersCarrying waiter1)0) (=(foodCarrying waiter1)0)
        ;(=(ordersCarrying waiter2)0) (=(foodCarrying waiter2)0)



    )
    (:goal (and
            (foodDelivered table1 order1)
            (foodDelivered table2 order2)
            (foodDelivered table3 order3)
        )
    )
    (:metric minimize (total-time-taken))
)
