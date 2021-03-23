(define
    (domain pizza_restaurant)
    (:requirements :strips :fluents :durative-actions :duration-inequalities)
    ;typing enable us to identify specific vars
    ;fluents allows us to define functions

    ;(:types
    ;    waiter table tile
    ;)

    ;(:domain-variables ) ;deprecated

    (:predicates

        ;defining objects
        ;(WAITER ?w)(TABLE ?ta) (TILE ?ta)

        ;identity predicates
        (waiter ?waiter)
        (table ?table)
        (tile ?tile)

        ;location predicates
        (atWaiter ?waiter ?tile)
        (atTable ?table ?tile)
        (atKitchen ?tile)
        (accessible ?from-tile ?to-tile)

        ;table predicates
        (orderTaken ?table)
        (foodDelivered ?table)

        ;kitchen predicates
        (foodReady ?tile)
        ;(occupiedKitchen ?ti - tile)
        ;(isKitchenFree ?ti - tile)

        ;food predicates
        ;(carryingFood ?waiter ?table)
    )

    (:functions

        (cooking ?tile) ;0=free, non-zero=busy
        (tableIdcook ?tile) ;order the cook is working on

        (tableId ?waiter) ;order the waiter is working on
        (carryingOrder ?waiter) ;how many order (num plates) is he delivering to cook
        (carryingFood ?waiter) 

        (tableIdTable ?table) ;order the table is working on
        (numFood ?table)   ;num of food plates they want to order (table)

        (total-time-taken)  ;whats the earliest it can be done?
        (total-food-cooked)  ;whats the earliest it can be done?
        (isKitchenOccupied) ;1=occupied, 0=notoccupied
        (orderId)   ;ID (updated , init: set to 1)
    )


    (:durative-action move
        :parameters (?waiter ?from-tile ?to-tile)
        :duration (= ?duration 1)
        :condition (and
            ;(WAITER ?w) (TILE ?from) (TILE ?to)
            ;identity
            (at start(waiter ?waiter))
            (at start(tile ?from-tile)) 
            (at start(tile ?to-tile))
            ;
            (at start(atWaiter ?waiter ?from-tile))
            (over all(accessible ?from-tile ?to-tile))
        )
        :effect (and
            (at end(atWaiter ?waiter ?to-tile) )
            (at start(not(atWaiter ?waiter ?from-tile)))
            (at end(increase(total-time-taken)1))
        )
        ; :expansion ;deprecated
    )

    (:action takeOrder
        :parameters (?waiter ?table ?tile)
        :precondition (and
            ;(WAITER ?w) (TABLE ?ta) (TILE ?ti)
            ;identity
            (waiter ?waiter)
            (table ?table) 
            (tile ?tile)
            ;
            (atWaiter ?waiter ?tile)
            (atTable ?table ?tile)
            (=(tableIdTable ?table)0)
            ;(not(orderTaken ?ta))
            ;(>(numFood) 0)
        )
        :effect (and
            (increase(carryingOrder ?waiter) (numFood ?table))
            (increase(tableId ?waiter) (orderId)) ;pass on info to waiter (set to 0 in init s)
            (increase(tableIdTable ?table) (orderId)) ;pass on info to table (set to 0 in init s)
            (increase(orderId)1)
            (orderTaken ?table)
        )
        ; :expansion ;deprecated
    )

    (:action deliverToCook
        :parameters (?waiter ?tile)
        :precondition (and
            ;(WAITER ?w) (TILE ?ti)
            ;identity
            (waiter ?waiter)
            (tile ?tile)
            ;
            (atWaiter ?waiter ?tile)
            (atKitchen ?tile)
            (= (isKitchenOccupied) 0)   
            (> (carryingOrder ?waiter) 0)   
        )
        :effect (and
            (increase(cooking ?tile) (carryingOrder ?waiter))
            (decrease(carryingOrder ?waiter) (carryingOrder ?waiter))
            (increase(tableIdcook ?tile) (tableId ?waiter))
            (decrease(tableId ?waiter) (tableId ?waiter))
            (increase(isKitchenOccupied)1)
            ;(not(isKitchenFree ?ti))
        )
        ; :expansion ;deprecated
    )

    (:durative-action cook
        :parameters (?tile)
        :duration (= ?duration (cooking ?tile))
        :condition (and
            ;identity
            (over all (atKitchen ?tile))
            (over all (tile ?tile))

            (at start  (= (isKitchenOccupied) 1)  ) 
        )
        :effect (and
            ;(at end(decrease(cooking ?ti) (cooking ?ti)))
            (at end(decrease (isKitchenOccupied)1))
            (at end(increase(total-food-cooked)1))
            (at end(foodReady ?tile))
            (at end(increase(total-time-taken)1))
        )
        ; :expansion ;deprecated
    )

    (:action takeFromCook
        :parameters (?waiter ?tile)
        :precondition (and
            ;identity
            (waiter ?waiter)
            (tile ?tile)

            (atWaiter ?waiter ?tile)
            (atKitchen ?tile)
            (foodReady ?tile)  
        )
        :effect (and
            (increase(tableId ?waiter) (tableIdcook ?tile))
            (decrease(tableIdcook ?tile) (tableIdcook ?tile))
            (increase(carryingFood ?waiter) (cooking ?tile))
            (decrease(cooking ?tile) (cooking ?tile))
            (not(foodReady ?tile))
            ;(not(isKitchenFree ?ti))
        )
        ; :expansion ;deprecated
    )


    (:action deliverToTable
        :parameters (?waiter ?table ?tile)
        :precondition (and
            ;identity
            (waiter ?waiter)
            (table ?table)
            (tile ?tile)

            (atWaiter ?waiter ?tile)
            (atTable ?table ?tile)
            (=(tableId ?waiter)(tableIdTable ?table))
            (>(carryingFood ?waiter)0)
            (orderTaken ?table)
            ;(not(orderTaken ?ta))
            ;(>(numFood) 0)
        )
        :effect (and
            (foodDelivered ?table)
            (decrease(carryingFood ?waiter) (carryingFood ?waiter) )
            (decrease(tableId ?waiter) (tableId ?waiter) ) ;pass on info to waiter (set to 0 in init s)
        )
        ; :expansion ;deprecated
    )



)