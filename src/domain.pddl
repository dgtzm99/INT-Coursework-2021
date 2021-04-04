(define
    (domain pizza_restaurant)
    (:requirements :strips :numeric-fluents :durative-actions)

    ;(:types
    ;    ;waiter table location cook order
    ;    kitchen table - location
    ;    waiter - waiter
    ;    order - order
    ;)

    ;(:domain-variables ) ;deprecated

    (:predicates

        ;identity predicates
        (waiter ?waiter)
        (kitchen ?kitchen)
        (table ?table)
        (location ?location)
        (order ?order)

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

        ;kitchen predicates
        (kitchenHolding ?kitchen ?order)
        (foodReady ?order)
        (foodNotReady ?order)
        (isKitchenFree ?kitchen)
        (isKitchenBusy ?kitchen)

        ;ideas
        ;ordercapacity = 2
        ;food waiting line

    )

    (:functions

        (order-cooking-time ?order)
        (time-to-walk ?from-loc ?to-loc)
        (total-time-taken)  ;cost for our durative actions

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
            (at end(increase(total-time-taken)(time-to-walk ?from-loc ?to-loc)))
        )
    )

    (:action takeOrder
        :parameters (?waiter ?table ?order)
        :precondition (and
            ;identity
            (waiter ?waiter)
            (table ?table) 
            (order ?order)

            (orderFrom ?order ?table)
            (atWaiter ?waiter ?table)
            (orderNotTaken ?table)
            (waiterFree ?waiter)
        )
        :effect (and
            (not(orderNotTaken ?table))
            (orderTaken ?table)
            (holdingOrder ?waiter ?order)
            (not(waiterFree ?waiter))
            (foodNotReady ?order)
        )
    )

    (:action deliverToCook
        :parameters (?waiter ?kitchen ?order)
        :precondition (and
            ;identity
            (kitchen ?kitchen)
            (waiter ?waiter)
            (order ?order)

            (holdingOrder ?waiter ?order)
            (atWaiter ?waiter ?kitchen)
            (isKitchenFree ?kitchen)
            (foodNotReady ?order)
        )
        :effect (and
            (kitchenHolding ?kitchen ?order)
            (not(holdingOrder ?waiter ?order))
            (not(isKitchenFree ?kitchen))
            (isKitchenBusy ?kitchen)
            (waiterFree ?waiter)
        )
    )

    (:durative-action cook
        :parameters (?kitchen ?order)
        :duration (= ?duration (order-cooking-time ?order))
        :condition (and
            ;identity
            (at start (kitchen ?kitchen))
            (at start(order ?order))

            (over all (kitchenHolding ?kitchen ?order))
            (at start (isKitchenBusy ?kitchen)) 
        )
        :effect (and
            (at end (isKitchenFree ?kitchen))
            (at start (not (isKitchenBusy ?kitchen)))
            (at end(foodReady ?order))
            (at start(not (foodNotReady ?order)))
            (at end(increase(total-time-taken)(order-cooking-time ?order)))
        )
    )

    (:action takeFromCook
        :parameters (?waiter ?kitchen ?order)
        :precondition (and
            ;identity
            (kitchen ?kitchen)
            (waiter ?waiter)
            (order ?order)

            (atWaiter ?waiter ?kitchen)
            (foodReady ?order) 
            (waiterFree ?waiter)
            (kitchenHolding ?kitchen ?order)
        )
        :effect (and
            (not (waiterFree ?waiter))
            (holdingOrder ?waiter ?order)
            (not (kitchenHolding ?kitchen ?order))
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