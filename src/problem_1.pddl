(define
    (problem problem_1)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects
            ;kitchen
            kitchen1
            counter1

            ;waiters 
            waiter1 waiter2 waiter3 

            ;tables
            table1 table2 
            order1 order2 

            )
    (:init

        ;identity predicates
        (kitchen kitchen1) 

        (counter counter1) (location counter1) 

        (waiter waiter1) (waiter waiter2) (waiter waiter3)

        (table table1) (table table2)

        (location table1) (location table2)

        (order order1) (order order2)

        ;order predicates
        (waiterFree waiter1) (waiterFree waiter2) (waiterFree waiter3)
        (orderFrom order1 table1) (orderFrom order2 table2)

        ;locations
        (atWaiter waiter1 counter1) (atWaiter waiter2 counter1) (atWaiter waiter3 counter1)

        ;distances
            ;counter2table
        (=(time-to-walk counter1 table1)20) (=(time-to-walk table1 counter1)20)
        (=(time-to-walk counter1 table2)30) (=(time-to-walk table2 counter1)30)

            ;table2table
        (=(time-to-walk table1 table2)10) (=(time-to-walk table2 table1)10)


        ;table predicate
        (orderNotTaken table1) (orderNotTaken table2)

        ;kitchen predicate
        (isKitchenFree kitchen1)

        ;functions
            ;num_people * 600s (10 min)
        (=(order-cooking-time order1)2400) (=(order-cooking-time order2)1200)

        (= (people table1)4) (= (people table2)2)

            ;in case metric was enabled
        (=(total-time-taken)0)

    )
    (:goal (and

            (foodDelivered table1 order1)
            (foodDelivered table2 order2)

        )
    )
    
    ;(:metric minimize (total-time-taken))
)