(define
    (domain pizza_restaurant)
    (:requirements :strips :fluents :typing :durative-actions)
    ;typing enable us to identify specific vars
    ;fluents allows us to define functions

    (:types
        waiter table tile
    )

    ;(:domain-variables ) ;deprecated

    (:predicates

        ;defining objects
        ;(WAITER ?w)(TABLE ?ta) (TILE ?ta)

        ;location predicates
        (atWaiter ?w - waiter ?ti - tile)
        (atTable ?ta - table ?ti - tile)
        (atKitchen ?ti - tile)
        (accessible ?ti1 ?ti2 - tile)

        ;table predicates
        (orderTaken ?ta - table)
        (foodDelivered ?ta - table)

        ;kitchen predicates
        (foodReady ?ti - tile)
        ;(occupiedKitchen ?ti - tile)
        ;(isKitchenFree ?ti - tile)
    )

    (:functions

        (cooking ?ti - tile) ;0=free, non-zero=busy
        (tableIdcook ?ti - tile) ;order the cook is working on

        (tableId ?w - waiter) ;order the waiter is working on
        (carryingOrder ?w - waiter) ;how many order (num plates) is he delivering to cook
        (carryingFood ?w - waiter) 

        (tableIdTable ?ta - table) ;order the table is working on
        (numFood ?ta - table)   ;num of food plates they want to order (table)

        (total-time-taken)  ;whats the earliest it can be done?
        (total-food-cooked)  ;whats the earliest it can be done?
        (isKitchenOccupied) ;1=occupied, 0=notoccupied
        (orderId)   ;ID (updated , init: set to 1)
    )


    (:durative-action move
        :parameters (?w - waiter ?from ?to - tile)
        :duration (= ?duration 1)
        :condition (and
            ;(WAITER ?w) (TILE ?from) (TILE ?to)
            ;
            (at start(atWaiter ?w ?from))
            (over all(accessible ?from ?to))
        )
        :effect (and
            (at end(atWaiter ?w ?to) )
            (at end(not(atWaiter ?w ?from)))
            (at end(increase(total-time-taken)1))
        )
        ; :expansion ;deprecated
    )

    (:durative-action takeOrder
        :parameters (?w - waiter ?ta - table ?ti - tile)
        :duration (= ?duration (numFood ?ta))
        :condition (and
            ;(WAITER ?w) (TABLE ?ta) (TILE ?ti)
            ;
            (over all(atWaiter ?w ?ti))
            (over all(atTable ?ta ?ti))
            (at start(=(tableIdTable ?ta)0))
            ;(not(orderTaken ?ta))
            ;(>(numFood) 0)
        )
        :effect (and
            (at start(increase(carryingOrder ?w) (numFood ?ta)))
            (at start(increase(tableId ?w) (orderId))) ;pass on info to waiter (set to 0 in init s)
            (at start(increase(tableIdTable ?ta) (orderId))) ;pass on info to table (set to 0 in init s)
            (at end(increase(orderId)1))
            (at end(orderTaken ?ta))
        )
        ; :expansion ;deprecated
    )

    (:durative-action deliverToCook
        :parameters (?w - waiter ?ti - tile)
        :duration (= ?duration 1)
        :condition (and
            ;(WAITER ?w) (TILE ?ti)
            ;
            (over all(atWaiter ?w ?ti))
            (over all(atKitchen ?ti))
            (at start(= (isKitchenOccupied) 0)  ) 
            (at start(> (carryingOrder ?w) 0) )  
        )
        :effect (and
            (at start(increase(cooking ?ti) (carryingOrder ?w)))
            (at end(decrease(carryingOrder ?w) (carryingOrder ?w)))
            (at start(increase(tableIdcook ?ti) (tableId ?w)))
            (at end(decrease(tableId ?w) (tableId ?w)))
            (at end(increase(isKitchenOccupied)1))
            ;(not(isKitchenFree ?ti))
        )
        ; :expansion ;deprecated
    )

    (:durative-action cook
        :parameters (?ti - tile)
        :duration (= ?duration (cooking ?ti))
        :condition (and
            (at start  (= (isKitchenOccupied) 1)  ) 
        )
        :effect (and
            ;(at end(decrease(cooking ?ti) (cooking ?ti)))
            (at end(decrease (isKitchenOccupied)1))
            (at end(increase(total-food-cooked)1))
            (at end(foodReady ?ti))
        )
        ; :expansion ;deprecated
    )

    (:durative-action takeFromCook
        :parameters (?w - waiter ?ti - tile)
        :duration (= ?duration 1)
        :condition (and
            (over all(atWaiter ?w ?ti))
            (over all(atKitchen ?ti))
            (at start(foodReady ?ti))  
        )
        :effect (and
            (at start(increase(tableId ?w) (tableIdcook ?ti)))
            (at end(decrease(tableIdcook ?ti) (tableIdcook ?ti)))
            (at start(increase(carryingFood ?w) (cooking ?ti)))
            (at end(decrease(cooking ?ti) (cooking ?ti)))
            (at end(not(foodReady ?ti)))
            ;(not(isKitchenFree ?ti))
        )
        ; :expansion ;deprecated
    )

    (:durative-action deliverToTable
        :parameters (?w - waiter ?ta - table ?ti - tile)
        :duration (= ?duration 1)
        :condition (and
            (over all(atWaiter ?w ?ti))
            (over all(atTable ?ta ?ti))
            (at start(=(tableId ?w)(tableIdTable ?ta)))
            (at start(>(carryingFood ?w)0))
            (over all(orderTaken ?ta))
            ;(not(orderTaken ?ta))
            ;(>(numFood) 0)
        )
        :effect (and
            (at end(foodDelivered ?ta))
            (at end(decrease(carryingFood ?w) (carryingFood ?w) ))
            (at end(decrease(tableId ?w) (tableId ?w) )) ;pass on info to waiter (set to 0 in init s)
        )
        ; :expansion ;deprecated
    )


    ;action deliverToTable


)