(define
    (problem problem_4)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects alice bob charlie - waiter
            table1 table2 table3 table4 - table ;table5
            ;table6 table7 - table
            t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12
            t13 t14 t15 t16 t17 t18 t19 t20 t21 t22
            t23 t24 t25 t26 t27 t28 t29 t30 - tile)
    (:init
       ;locations
        (atKitchen t3) (atTable table1 t1) 
        (atTable table2 t5) (atTable table3 t12)
        (atTable table4 t14) ;(atTable table5 t23)
        ;(atTable table6 t26) (atTable table7 t30)  
        (atWaiter alice t7) (atWaiter bob t8)
        (atWaiter charlie t9)

        ;tile space
        (accessible t1 t2) (accessible t2 t1)
        (accessible t1 t6) (accessible t6 t1)
        (accessible t2 t3) (accessible t3 t2)
        (accessible t2 t7) (accessible t7 t2)
        (accessible t3 t4) (accessible t4 t3)
        (accessible t3 t8) (accessible t8 t3)
        (accessible t4 t5) (accessible t5 t4)
        (accessible t4 t9) (accessible t9 t4)
        (accessible t5 t10) (accessible t10 t5)
            
        (accessible t6 t7) (accessible t7 t6)
        (accessible t6 t11) (accessible t11 t6)
        (accessible t7 t8) (accessible t8 t7)
        (accessible t7 t12) (accessible t12 t7)
        (accessible t8 t9) (accessible t9 t8)
        (accessible t8 t13) (accessible t13 t8)
        (accessible t9 t10) (accessible t10 t9)
        (accessible t9 t14) (accessible t14 t9)
        (accessible t10 t15) (accessible t15 t10)

        (accessible t11 t12) (accessible t12 t11)
        (accessible t11 t16) (accessible t16 t11)
        (accessible t12 t13) (accessible t13 t12)
        (accessible t12 t17) (accessible t17 t12)
        (accessible t13 t14) (accessible t14 t13)
        (accessible t13 t18) (accessible t18 t13)
        (accessible t14 t15) (accessible t15 t14)
        (accessible t14 t19) (accessible t19 t14)
        (accessible t15 t20) (accessible t20 t15)

        (accessible t16 t17) (accessible t17 t16)
        (accessible t16 t21) (accessible t21 t16)
        (accessible t17 t18) (accessible t18 t17)
        (accessible t17 t22) (accessible t22 t17)
        (accessible t18 t19) (accessible t19 t18)
        (accessible t18 t23) (accessible t23 t18)
        (accessible t19 t20) (accessible t20 t19)
        (accessible t19 t24) (accessible t24 t19)
        (accessible t20 t25) (accessible t25 t20)

        (accessible t21 t22) (accessible t22 t21)
        (accessible t21 t26) (accessible t26 t21)
        (accessible t22 t23) (accessible t23 t22)
        (accessible t22 t27) (accessible t27 t22)
        (accessible t23 t24) (accessible t24 t23)
        (accessible t23 t28) (accessible t28 t23)
        (accessible t24 t25) (accessible t25 t24)
        (accessible t24 t29) (accessible t29 t24)
        (accessible t25 t30) (accessible t30 t25)

        (accessible t26 t27) (accessible t27 t26)
        (accessible t27 t28) (accessible t28 t27)
        (accessible t28 t29) (accessible t29 t28)
        (accessible t29 t30) (accessible t30 t29)

        

        ; ;table predicate
        (not(orderTaken table1)) (not(orderTaken table2))
        (not(orderTaken table3)) (not(orderTaken table4))
        ;(not(orderTaken table5)) (not(orderTaken table6))
        ;(not(orderTaken table7))

        ; ;kitchen predicate
        (not(foodReady t1))

        ;functions
        (=(cooking t1)0) (=(tableIdcook t1)0)
        (=(tableId alice)0) (=(tableId bob)0)
        (=(tableId charlie)0)
        (=(carryingOrder alice)0) (=(carryingOrder bob)0)
        (=(carryingOrder charlie)0)
        (=(carryingFood alice)0) (=(carryingFood bob)0)
        (=(carryingFood charlie)0)
        (=(tableIdTable table1)0) (=(tableIdTable table2)0)
        (=(tableIdTable table3)0) (=(tableIdTable table4)0)
        ;(=(tableIdTable table5)0) (=(tableIdTable table6)0)
        ;(=(tableIdTable table7)0)
        (=(numFood table1)2) (=(numFood table2)3)
        (=(numFood table3)3) (=(numFood table4)3)
        ;(=(numFood table5)5) (=(numFood table6)4)
        ;(=(numFood table7)4)
        (=(total-time-taken)0)
        (=(total-food-cooked)0)
        (=(isKitchenOccupied)0)
        (=(orderId)1)
    )
    (:goal (and
            (foodDelivered table1)
            (foodDelivered table2)
            (foodDelivered table3)
            (foodDelivered table4)
            ;(foodDelivered table5)
            ;(foodDelivered table6)
            ;(foodDelivered table7)
        )
    )
    (:metric minimize (total-time-taken))
)