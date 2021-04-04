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
            table1 table2 table3 table4 table5 table6
            order1 order2 order3 order4 order5 order6

    )

    (:init
        ;identity predicates
        (kitchen kitchen1)
        (waiter waiter1) (waiter waiter2) (waiter waiter3)
        (table table1) (table table2) (table table3) 
        (table table4) (table table5) (table table6)
        (location table1) (location table2) (location table3) 
        (location table4) (location table5) (location table6)
        (location kitchen1)
        (order order1) (order order2) (order order3) (order order4)
        (order order5) (order order6)

        ;order predicates
        (waiterFree waiter1) (waiterFree waiter2) (waiterFree waiter3)
        (orderFrom order1 table1) (orderFrom order2 table2) 
        (orderFrom order3 table3) (orderFrom order4 table4) 
        (orderFrom order5 table5) (orderFrom order6 table6)  

        ;locations
        (atWaiter waiter1 kitchen1) (atWaiter waiter2 kitchen1)
        (atWaiter waiter3 kitchen1)

        ;restaurant layout
        (=(time-to-walk kitchen1 table1)10) (=(time-to-walk table1 kitchen1)10)
        (=(time-to-walk kitchen1 table2)10) (=(time-to-walk table2 kitchen1)10)
        (=(time-to-walk kitchen1 table3)20) (=(time-to-walk table3 kitchen1)20)
        (=(time-to-walk kitchen1 table4)20) (=(time-to-walk table4 kitchen1)20)
        (=(time-to-walk kitchen1 table5)30) (=(time-to-walk table5 kitchen1)30)
        (=(time-to-walk kitchen1 table6)30) (=(time-to-walk table6 kitchen1)30)

        (=(time-to-walk table1 table2)10) (=(time-to-walk table2 table1)10)
        (=(time-to-walk table1 table3)10) (=(time-to-walk table3 table1)10)
        (=(time-to-walk table2 table4)10) (=(time-to-walk table4 table2)10)
        (=(time-to-walk table3 table4)10) (=(time-to-walk table4 table3)10)
        (=(time-to-walk table3 table5)10) (=(time-to-walk table5 table3)10)
        (=(time-to-walk table4 table6)10) (=(time-to-walk table6 table4)10)
        (=(time-to-walk table5 table6)10) (=(time-to-walk table6 table5)10)
        
        
        ;table predicate
        (orderNotTaken table1) (orderNotTaken table2)
        (orderNotTaken table3) (orderNotTaken table4)
        (orderNotTaken table5) (orderNotTaken table6)

        ;kitchen predicate
        (isKitchenFree kitchen1)

        ;functions
        (=(order-cooking-time order1)2) (=(order-cooking-time order2)3) 
        (=(order-cooking-time order3)3) (=(order-cooking-time order4)4)
        (=(order-cooking-time order5)7) (=(order-cooking-time order6)5)
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
