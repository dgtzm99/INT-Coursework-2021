(define
    (domain pizza_restaurant)
    (:requirements :strips :numeric-fluents :durative-actions :typing)
    ;typing enable us to identify specific vars
    ;fluents allows us to define functions

    (:types
        waiter table tile cook order
    )

    ;(:domain-variables ) ;deprecated

    (:predicates

        ;identity predicates
        ;(waiter ?waiter)
        ;(cook ?cook)
        ;(table ?table)
        ;(tile ?tile)
        ;(order ?order)

        ;order predicates
        (waiterFree ?waiter - waiter)
        (holdingOrder ?waiter - waiter ?order - order)
        (cookHolding ?cook - cook ?order - order)
        (orderFrom ?order - order ?table - table); this is how we substitute IDs

        ;location predicates
        (atWaiter ?waiter - waiter ?tile - tile)
        (atTable ?table - table ?tile - tile)
        (atCook ?cook - cook ?tile - tile)
        (accessible ?from-tile - tile ?to-tile - tile)

        ;table predicates
        (orderTaken ?table - table)
        (orderNotTaken ?table - table)
        (foodDelivered ?table - table ?order - order)

        ;kitchen predicates
        (foodReady ?order - order)
        (foodNotReady ?order - order)
        (isCookFree ?cook - cook)
        (isCookBusy ?cook - cook)

    )

    (:functions

        (orderType ?order - order)
        (total-time-taken)  ;whats the earliest it can be done?

    )


    (:durative-action move
        :parameters (?waiter - waiter ?from-tile - tile ?to-tile - tile)
        :duration (= ?duration 1)
        :condition (and
            ;identity
            ;(at start (waiter ?waiter))
            ;(at start (tile ?from-tile))
            ;(at start (tile ?to-tile))
            
            (at start(atWaiter ?waiter ?from-tile))
            (over all(accessible ?from-tile ?to-tile))
        )
        :effect (and
            (at start(not(atWaiter ?waiter ?from-tile)))
            (at end(atWaiter ?waiter ?to-tile) )
            (at end(increase(total-time-taken)1))
        )
    )

    (:action takeOrder
        :parameters (?waiter - waiter ?table - table ?tile - tile ?order - order)
        :precondition (and
            ;identity
            ;(waiter ?waiter)
            ;(table ?table) 
            ;(tile ?tile)
            ;(order ?order)

            (orderFrom ?order ?table)
            (atWaiter ?waiter ?tile)
            (atTable ?table ?tile)
            (orderNotTaken ?table)
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
        :parameters (?waiter - waiter ?cook - cook ?tile - tile ?order - order)
        :precondition (and
            ;identity
            ;(cook ?cook)
            ;(waiter ?waiter)
            ;(tile ?tile)
            ;(order ?order)
            
            (holdingOrder ?waiter ?order)
            (atWaiter ?waiter ?tile)
            (atCook ?cook ?tile)
            (isCookFree ?cook)
            (foodNotReady ?order)
        )
        :effect (and
            (cookHolding ?cook ?order)
            (not(holdingOrder ?waiter ?order))
            (not(isCookFree ?cook))
            (isCookBusy ?cook)
            (waiterFree ?waiter)
        )
    )

    (:durative-action cook
        :parameters (?cook - cook ?order - order ?tile - tile)
        :duration (= ?duration (orderType ?order))
        :condition (and
            ;identity
            ;(at start (tile ?tile))
            ;(at start (cook ?cook))
            ;(at start(order ?order))

            (over all (atCook ?cook ?tile))
            (over all (cookHolding ?cook ?order))
            (at start (isCookBusy ?cook)) 
        )
        :effect (and
            (at end (isCookFree ?cook))
            (at start (not (isCookBusy ?cook)))
            (at end(foodReady ?order))
            (at start(not (foodNotReady ?order)))
            (at end(increase(total-time-taken)1))
        )
    )

    (:action takeFromCook
        :parameters (?waiter - waiter ?cook - cook ?order - order ?tile - tile)
        :precondition (and
            ;identity
            ;(cook ?cook)
            ;(waiter ?waiter)
            ;(tile ?tile)
            ;(order ?order)

            (atWaiter ?waiter ?tile)
            (atCook ?cook ?tile)
            (foodReady ?order) 
            (waiterFree ?waiter)
            (cookHolding ?cook ?order)
        )
        :effect (and
            (not (waiterFree ?waiter))
            (holdingOrder ?waiter ?order)
            (not (cookHolding ?cook ?order))
        )
    )


    (:action deliverToTable
        :parameters (?waiter - waiter ?table - table ?order - order ?tile - tile)
        :precondition (and
            ;identity
            ;(waiter ?waiter)
            ;(table ?table)
            ;(tile ?tile)
            ;(order ?order)

            (foodReady ?order) 
            (atWaiter ?waiter ?tile)
            (atTable ?table ?tile)
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