(define
    (domain pizza_restaurant)
    (:requirements :strips :numeric-fluents :durative-actions)

    ;(:domain-variables ) ;deprecated

    (:predicates

        ;identity predicates
        (waiter ?waiter)
        (cook ?cook)
        (table ?table)
        (location ?location)
        (order ?order)
        (counter ?counter)

        ;waiter predicates
        (waiterFree ?waiter)
        (holdingOrder ?waiter ?order)

        ;location predicates
        (atWaiter ?waiter ?location)

        ;table predicates
        (orderFrom ?order ?table)
        (orderTaken ?table)
        (orderNotTaken ?table)
        (foodDelivered ?table ?order)

        ;cook predicates
        (foodReady ?order)
        (foodNotReady ?order)
        (iscookFree ?cook)

        ;food waiting line
        (counter-contains ?counter ?order)

    )

    (:functions

        (order-cooking-time ?order) ;total cooking time
        (time-to-walk ?from-loc ?to-loc)
        (total-time-taken)  ;cost for our durative actions
        (people ?table)

    )


    (:durative-action move
        :parameters (?waiter ?from-loc ?to-loc)
        :duration (= ?duration (time-to-walk ?from-loc ?to-loc))
        :condition (and
            ;identity
            (at start (waiter ?waiter))
            (at start (location ?from-loc))
            (at start (location ?to-loc))
            
            (at start(atWaiter ?waiter ?from-loc))
        )
        :effect (and
            (at start(not(atWaiter ?waiter ?from-loc)))
            (at end(atWaiter ?waiter ?to-loc) )
            (at start(increase(total-time-taken)(time-to-walk ?from-loc ?to-loc)))
        )
    )


    (:durative-action takeOrder
        :parameters (?waiter ?table ?order)
        :duration (= ?duration (*(people ?table)15))
        :condition (and
            ;identity
            (at start (waiter ?waiter))
            (at start (table ?table))
            (at start (order ?order))

            (over all (orderFrom ?order ?table))
            (over all (atWaiter ?waiter ?table))
            (at start (orderNotTaken ?table))
            (at start (waiterFree ?waiter))
        )
        :effect (and
            (at start (not(orderNotTaken ?table)))
            (at end (orderTaken ?table))
            (at end (holdingOrder ?waiter ?order))
            (at end (not(waiterFree ?waiter)))
            (at end (foodNotReady ?order))
            (at start (increase(total-time-taken) (*(people ?table)15)))
        )
    )


    (:action deliverToCounter
        :parameters (?counter ?waiter ?order)
        :precondition (and
            ;identity
            (waiter ?waiter)
            (order ?order)
            (counter ?counter)

            (holdingOrder ?waiter ?order)
            (atWaiter ?waiter ?counter)
            (foodNotReady ?order)
        )
        :effect (and
            (not(holdingOrder ?waiter ?order))
            (counter-contains ?counter ?order)
            (waiterFree ?waiter)
        )
    )

    (:durative-action cooking
        :parameters (?cook ?order ?counter)
        :duration (= ?duration (order-cooking-time ?order))
        :condition (and
            ;identity
            (at start (cook ?cook))
            (at start (order ?order))
            (at start (counter ?counter))

            (at start (iscookFree ?cook))
            (at start (counter-contains ?counter ?order))
            (at start (foodNotReady ?order))
        )
        :effect (and
            (at end (iscookFree ?cook))
            (at start (not (iscookFree ?cook)))
            (at end (counter-contains ?counter ?order))
            (at start (not (counter-contains ?counter ?order)))
            (at end(foodReady ?order))
            (at start(not (foodNotReady ?order)))
            (at start(increase(total-time-taken)(order-cooking-time ?order)))
        )
    )


    (:action takeFromCounter
        :parameters (?counter ?waiter ?order)
        :precondition (and
            ;identity
            (waiter ?waiter)
            (order ?order)
            (counter ?counter)

            (counter-contains ?counter ?order)
            (atWaiter ?waiter ?counter)
            (foodReady ?order) 
            (waiterFree ?waiter)
        )
        :effect (and
            (not (waiterFree ?waiter))
            (holdingOrder ?waiter ?order)
            (not (counter-contains ?counter ?order))
        )
    )


    (:action deliverToTable
        :parameters (?waiter ?table ?order)
        :precondition (and
            ;identity
            (waiter ?waiter)
            (table ?table)
            (order ?order)

            (foodReady ?order) 
            (atWaiter ?waiter ?table)
            (holdingOrder ?waiter ?order)
            (orderFrom ?order ?table)
            (orderTaken ?table)
        )
        :effect (and
            (foodDelivered ?table ?order)
            (not (holdingOrder ?waiter ?order))
            (waiterFree ?waiter)
        )
        ; :expansion ;deprecated
    )

)