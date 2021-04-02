(define
    (domain pizza_restaurant)
    (:requirements :strips :numeric-fluents :durative-actions)
    ;typing enable us to identify specific vars
    ;fluents allows us to define functions

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

        ;order predicates
        (waiterFree ?waiter)
        (holdingOrder ?waiter ?order)
        (kitchenHolding ?kitchen ?order)
        (orderFrom ?order ?table); this is how we substitute IDs

        ;location predicates
        (atWaiter ?waiter ?location)
        ;(atTable ?table - table ?location - location)
        ;(atKitchen ?kitchen - kitchen ?location - location)
        ;(accessible ?from-location - location ?to-location - location)
        ;(accessible ?from-loc - location ?to-loc - location)

        ;table predicates
        (orderTaken ?table)
        (orderNotTaken ?table)
        (foodDelivered ?table ?order)

        ;kitchen predicates
        (foodReady ?order)
        (foodNotReady ?order)
        (isKitchenFree ?kitchen)
        (isKitchenBusy ?kitchen)

        ;carrying restrictions

    )

    (:functions

        (orderType ?order)
        (time-to-walk ?from-loc ?to-loc)
        (total-time-taken)  ;whats the earliest it can be done?

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
            ;(over all(accessible ?from-loc ?to-loc))
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
            ;(location ?location)
            (order ?order)
            ;(< (ordersCarrying ?waiter)1) ;can take 1 ord at a time
            (orderFrom ?order ?table)
            (atWaiter ?waiter ?table)
            ;(atTable ?table ?location)
            (orderNotTaken ?table)
            (waiterFree ?waiter)
        )
        :effect (and
            (not(orderNotTaken ?table))
            (orderTaken ?table)
            (holdingOrder ?waiter ?order)
            ;(increase (ordersCarrying ?waiter)1)
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
            ;(location ?location)
            (order ?order)
            ;(=(ordersCarrying ?waiter)1)
            (holdingOrder ?waiter ?order)
            (atWaiter ?waiter ?kitchen)
            ;(atKitchen ?kitchen ?location)
            (isKitchenFree ?kitchen)
            (foodNotReady ?order)
        )
        :effect (and
            ;(decrease (ordersCarrying ?waiter)1)
            (kitchenHolding ?kitchen ?order)
            (not(holdingOrder ?waiter ?order))
            (not(isKitchenFree ?kitchen))
            (isKitchenBusy ?kitchen)
            (waiterFree ?waiter)
        )
    )

    (:durative-action cook
        :parameters (?kitchen ?order); deleted loc
        :duration (= ?duration (orderType ?order))
        :condition (and
            ;identity
            ;(at start (location ?location))
            (at start (kitchen ?kitchen))
            (at start(order ?order))

            ;(over all (atKitchen ?kitchen ?location))
            (over all (kitchenHolding ?kitchen ?order))
            (at start (isKitchenBusy ?kitchen)) 
        )
        :effect (and
            (at end (isKitchenFree ?kitchen))
            (at start (not (isKitchenBusy ?kitchen)))
            (at end(foodReady ?order))
            (at start(not (foodNotReady ?order)))
            (at end(increase(total-time-taken)(orderType ?order)))
        )
    )

    (:action takeFromCook
        :parameters (?waiter ?kitchen ?order)
        :precondition (and
            ;identity
            (kitchen ?kitchen)
            (waiter ?waiter)
            ;(location ?location)
            (order ?order)
            ;(< (foodCarrying ?waiter)1) 
            (atWaiter ?waiter ?kitchen)
            ;(atKitchen ?kitchen ?location)
            (foodReady ?order) 
            (waiterFree ?waiter)
            (kitchenHolding ?kitchen ?order)
        )
        :effect (and
            ;(increase (foodCarrying ?waiter)1) 
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
            ;(location ?location)
            (order ?order)
            ;(= (foodCarrying ?waiter)1) 
            (foodReady ?order) 
            (atWaiter ?waiter ?table)
            ;(atTable ?table ?location)
            (holdingOrder ?waiter ?order)
            (orderFrom ?order ?table)
            (orderTaken ?table)
        )
        :effect (and
            ;(decrease (foodCarrying ?waiter)1) 
            (foodDelivered ?table ?order)
            (not (holdingOrder ?waiter ?order))
            (waiterFree ?waiter)
        )
        ; :expansion ;deprecated
    )



)