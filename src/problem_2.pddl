(define
    (problem problem_2)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects
            ;kitchen
            kitchen1 kitchen2

            ;waiters 
            waiter1 waiter2 waiter3 waiter4 

            ;tables
            table1 table2 table3 table4 table5 table6

            order1 order2 order3 order4 order5 order6 

            )
    (:init

        ;identity predicates
        (kitchen kitchen1) (location kitchen1)
        (kitchen kitchen2) (location kitchen2)

        (waiter waiter1) (waiter waiter2) (waiter waiter3) (waiter waiter4)

        (table table1) (table table2) (table table3) (table table4)
        (table table5) (table table6) 

        (location table1) (location table2) (location table3) (location table4)
        (location table5) (location table6) 

        (order order1) (order order2) (order order3) (order order4)
        (order order5) (order order6) 


        ;order predicates
        (waiterFree waiter1) (waiterFree waiter2) (waiterFree waiter3) (waiterFree waiter4)
        (orderFrom order1 table1) (orderFrom order2 table2)
        (orderFrom order3 table3) (orderFrom order4 table4)
        (orderFrom order5 table5) (orderFrom order6 table6)

        ;locations
        (atWaiter waiter1 kitchen1) (atWaiter waiter2 kitchen1) (atWaiter waiter3 kitchen2)
        (atWaiter waiter4 kitchen2)

        ;tile space
            ;kitchen2table
        (=(time-to-walk kitchen1 table1)20) (=(time-to-walk table1 kitchen1)20)
        (=(time-to-walk kitchen1 table2)30) (=(time-to-walk table2 kitchen1)30)
        (=(time-to-walk kitchen1 table3)40) (=(time-to-walk table3 kitchen1)40)
        (=(time-to-walk kitchen1 table4)50) (=(time-to-walk table4 kitchen1)50)
        (=(time-to-walk kitchen1 table5)10) (=(time-to-walk table5 kitchen1)10)
        (=(time-to-walk kitchen1 table6)20) (=(time-to-walk table6 kitchen1)20)

        (=(time-to-walk kitchen2 table1)10) (=(time-to-walk table1 kitchen2)10)
        (=(time-to-walk kitchen2 table2)20) (=(time-to-walk table2 kitchen2)20)
        (=(time-to-walk kitchen2 table3)30) (=(time-to-walk table3 kitchen2)30)
        (=(time-to-walk kitchen2 table4)40) (=(time-to-walk table4 kitchen2)40)
        (=(time-to-walk kitchen2 table5)50) (=(time-to-walk table5 kitchen2)50)
        (=(time-to-walk kitchen2 table6)10) (=(time-to-walk table6 kitchen2)10)

            ;table2table
        (=(time-to-walk table1 table2)3) (=(time-to-walk table2 table1)3)
        (=(time-to-walk table1 table3)5) (=(time-to-walk table3 table1)5)
        (=(time-to-walk table1 table4)7) (=(time-to-walk table4 table1)7)
        (=(time-to-walk table1 table5)9) (=(time-to-walk table5 table1)9)
        (=(time-to-walk table1 table6)11) (=(time-to-walk table6 table1)11)

        (=(time-to-walk table2 table3)3) (=(time-to-walk table3 table2)3)
        (=(time-to-walk table2 table4)5) (=(time-to-walk table4 table2)5)
        (=(time-to-walk table2 table5)7) (=(time-to-walk table5 table2)7)
        (=(time-to-walk table2 table6)9) (=(time-to-walk table6 table2)9)

        (=(time-to-walk table3 table4)3) (=(time-to-walk table4 table3)3)
        (=(time-to-walk table3 table5)5) (=(time-to-walk table5 table3)5)
        (=(time-to-walk table3 table6)7) (=(time-to-walk table6 table3)7)

        (=(time-to-walk table4 table5)3) (=(time-to-walk table5 table4)3)
        (=(time-to-walk table4 table6)5) (=(time-to-walk table6 table4)5)

        (=(time-to-walk table5 table6)3) (=(time-to-walk table6 table6)3)


            ;kitchen2kitchen
        (=(time-to-walk kitchen1 kitchen2)5) (=(time-to-walk kitchen2 kitchen1)5)

        

        ;table predicate
        (orderNotTaken table1) (orderNotTaken table2)
        (orderNotTaken table3) (orderNotTaken table4)
        (orderNotTaken table5) (orderNotTaken table6)


        ;kitchen predicate
        (isKitchenFree kitchen1)
        (isKitchenFree kitchen2)

        ;functions
        (=(orderType order1)16) (=(orderType order2)23)
        (=(orderType order3)14) (=(orderType order4)22)
        (=(orderType order5)14) (=(orderType order6)32)
       
        (=(total-time-taken)0)


    )
    (:goal (and

            (foodDelivered table1 order1)
            (foodDelivered table2 order2)
            (foodDelivered table3 order3)
            (foodDelivered table4 order4)
            (foodDelivered table5 order5)
            (foodDelivered table6 order6)
        )
    )
    (:metric minimize (total-time-taken))
)