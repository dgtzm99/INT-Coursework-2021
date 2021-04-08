(define
    (problem problem_1)
    (:domain pizza_restaurant)
    ;(:situation <situation_name>) ;deprecated
    (:objects
            ;cook
            cook1
            counter1

            ;waiters 
            waiter1 waiter2

            ;tables
            table1 table2 table3 table4
            order1 order2 order3 order4

    )

    (:init
        ;identity predicates
        (cook cook1)
        (counter counter1) (location counter1)
        (waiter waiter1) (waiter waiter2)
        (table table1) (table table2) (table table3) (table table4)
        (location table1) (location table2) 
        (location table3) (location table4) 
        (order order1) (order order2) (order order3) (order order4)

        ;order predicates
        (waiterFree waiter1) (waiterFree waiter2)
        (orderFrom order1 table1) (orderFrom order2 table2) 
        (orderFrom order3 table3) (orderFrom order4 table4) 

        ;locations
        (atWaiter waiter1 counter1) (atWaiter waiter2 counter1)

        ;distances
            ;counter2table
        (=(time-to-walk counter1 table1)10) (=(time-to-walk table1 counter1)10)
        (=(time-to-walk counter1 table2)20) (=(time-to-walk table2 counter1)20)
        (=(time-to-walk counter1 table3)15) (=(time-to-walk table3 counter1)15)
        (=(time-to-walk counter1 table4)35) (=(time-to-walk table4 counter1)35)

            ;table2table
        (=(time-to-walk table1 table2)30) (=(time-to-walk table2 table1)30)
        (=(time-to-walk table1 table3)25) (=(time-to-walk table3 table1)25)
        (=(time-to-walk table1 table4)45) (=(time-to-walk table4 table1)45)

        (=(time-to-walk table2 table3)10) (=(time-to-walk table3 table2)10)
        (=(time-to-walk table2 table4)15) (=(time-to-walk table4 table2)15)

        (=(time-to-walk table3 table4)20) (=(time-to-walk table4 table3)20)

        
        ;table predicate
        (orderNotTaken table1) (orderNotTaken table2)
        (orderNotTaken table3) (orderNotTaken table4)

        ;cook predicate
        (iscookFree cook1)

        ;functions
            ;num_people * 600s (10 min)
        (=(order-cooking-time order1)2400) (=(order-cooking-time order2)1200) 
        (=(order-cooking-time order3)1800) (=(order-cooking-time order4)600)

        (= (people table1)4) (= (people table2)2)
        (= (people table3)3) (= (people table4)1)

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
