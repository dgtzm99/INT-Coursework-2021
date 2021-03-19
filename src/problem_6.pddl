(define
    (problem problem_6)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects bob emily - waiter
            table1 table2 - table ;table3
            t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12
            t13 t14 t15 t16 t17 t18 t19 - tile)
    (:init
        ;locations
        (atKitchen t1)
        (atTable table1 t15) (atTable table2 t10) ;(atTable table3 t14)
        (atWaiter bob t2) (atWaiter emily t3)

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
        (not(orderTaken table1)) (not(orderTaken table2)) ;(not(orderTaken table3))

        ;kitchen predicate
        (not(foodReady t1)) 

        ;functions
        (=(cooking t1)0) (=(tableIdcook t1)0)
        (=(tableId bob)0) (=(tableId emily)0)
        (=(carryingOrder bob)0) (=(carryingOrder emily)0)
        (=(carryingFood bob)0) (=(carryingFood emily)0)
        (=(tableIdTable table1)0) (=(tableIdTable table2)0) ;(=(tableIdTable table3)0)
        (=(numFood table1)2) (=(numFood table2)3); (=(numFood table3)4)
        (=(total-time-taken)0)
        (=(total-food-cooked)0)
        (=(isKitchenOccupied)0)
        (=(orderId)1)

    )
    (:goal (and
            ;(orderTaken table1)
            ;(orderTaken table2)
            ;(orderTaken table3)
            (foodDelivered table1)
            (foodDelivered table2)
            ;(foodDelivered table3)
        )
    )
    (:metric minimize (total-time-taken))
)