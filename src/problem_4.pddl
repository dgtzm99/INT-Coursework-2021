(define
    (problem problem_4)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects 
            ;kitchen
            kitchen1
            counter1
        
            ;waiters
            waiter1 waiter2 waiter3
        
            ;tables
            table1 table2 table3 table4
            order1 order2 order3 order4
        
    )
    (:init
        ;identity predicates
        (kitchen kitchen1) 
        (counter counter1) (location counter1)
        (waiter waiter1) (waiter waiter2) (waiter waiter3)
        (table table1) (table table2) (table table3) (table table4)
        (location table1) (location table2) (location table3) 
        (location table4)
        (order order1) (order order2) (order order3) (order order4)

        ;order predicates
        (waiterFree waiter1) (waiterFree waiter2) (waiterFree waiter3)
        (orderFrom order1 table1) (orderFrom order2 table2)
        (orderFrom order3 table3) (orderFrom order4 table4)
        
        ;locations
        (atWaiter waiter1 counter1) (atWaiter waiter2 counter1) 
        (atWaiter waiter3 counter1)

        ;distances
            ;counter2table
        (=(time-to-walk counter1 table1)20) (=(time-to-walk table1 counter1)20)
        (=(time-to-walk counter1 table2)20) (=(time-to-walk table2 counter1)20)
        (=(time-to-walk counter1 table3)40) (=(time-to-walk table3 counter1)40)
        (=(time-to-walk counter1 table4)40) (=(time-to-walk table4 counter1)40)

            ;table2table
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
            ;num_people * 600s (10 min)
        (=(order-cooking-time order1)1200) (=(order-cooking-time order2)600)
        (=(order-cooking-time order3)1800) (=(order-cooking-time order4)1200)

        (= (people table1)2) (= (people table2)1)
        (= (people table3)3) (= (people table4)2)

            ;in case metric was enabled
        (=(total-time-taken)0)
    )
    (:goal (and
            (foodDelivered table1 order1)
            (foodDelivered table2 order2)
            (foodDelivered table3 order3)
            (foodDelivered table4 order4)
        )
    )
    ;(:metric minimize (total-time-taken))
)