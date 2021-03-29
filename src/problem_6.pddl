(define
    (problem problem_1)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects
            ;cook
            cook1 - cook

            ;waiters 
            waiter1 waiter2 - waiter

            ;tables
            tb1 tb2 tb3 tb4- table
            ord1 ord2 ord3 ord4 - order

            ;tiles
            t1 t2 t3 t4 t5 t6 t7 - tile
            t8 t9 t10 t11 t12 t13 t14 - tile
            t15 t16 t17 t18 t19 t20 t21 - tile)

    (:init


        ;order predicates
        (waiterFree waiter1) (waiterFree waiter2)
        (orderFrom ord1 tb1) (orderFrom ord2 tb2) (orderFrom ord3 tb3) (orderFrom ord4 tb4) 

        ;locations
        (atCook cook1 t11)
        (atTable tb1 t1) (atTable tb2 t5) (atTable tb3 t17) (atTable tb4 t21)
        (atWaiter waiter1 t10) (atWaiter waiter2 t12)

;tiles grid
       (accessible t1 t2) (accessible t1 t6)
       (accessible t2 t1) (accessible t2 t3)
       (accessible t3 t2) (accessible t3 t7) (accessible t3 t4)
       (accessible t4 t3) (accessible t4 t5)
       (accessible t5 t4) (accessible t5 t8)
       (accessible t6 t1) (accessible t6 t9)
       (accessible t7 t3) (accessible t7 t11)
       (accessible t8 t5) (accessible t8 t3)
       (accessible t9 t6) (accessible t9 t14) (accessible t9 t10)
       (accessible t10 t9) (accessible t10 t11)
       (accessible t11 t7) (accessible t11 t10) (accessible t11 t15) (accessible t11 t12)
       (accessible t12 t11)(accessible t12 t13)
       (accessible t13 t12) (accessible t13 t8) (accessible t13 t16)
       (accessible t14 t9) (accessible t14 t17)
       (accessible t15 t11) (accessible t15 t19)
       (accessible t16 t13) (accessible t16 t20)
       (accessible t17 t14) (accessible t17 t14)
       (accessible t18 t17) (accessible t18 t19)
       (accessible t19 t18) (accessible t19 t15) (accessible t19 t20)
       (accessible t20 t19) (accessible t20 t21) 
       (accessible t21 t20) (accessible t21 t16)

        ;table predicate
        (orderNotTaken tb1) (orderNotTaken tb2)

        ;kitchen predicate
        (isCookFree cook1)

        ;functions
        (=(orderType ord1)1) (=(orderType ord2)2) (=(orderType ord3)3) (=(orderType ord4)4)
        (=(total-time-taken)0)

    )
    (:goal (and

            (foodDelivered tb1 ord1)
            (foodDelivered tb2 ord2)
            (foodDelivered tb3 ord3)
            (foodDelivered tb4 ord4)

        )
    )
    (:metric minimize (total-time-taken))
)
