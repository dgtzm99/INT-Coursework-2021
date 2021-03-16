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
        (tableId ?w - waiter) ;order the waiter is working on
        (tableIdcook ?ti - tile) ;order the cook is working on
        (tableIdTable ?ta - table) ;order the table is working on
        (orderId)   ;ID (updated , init: set to 0)
        (numFood ?ta - table)   ;num of food plates they want to order (table)
        (carrying ?w - waiter) ;how many order (num plates) is he delivering to cook
        (total-time-taken)  ;whats the earliest it can be done?
        (total-food-cooked)  ;whats the earliest it can be done?
        (isKitchenOccupied) ;1=occupied, 0=notoccupied
    )


    (:action move
        :parameters (?w - waiter ?from ?to - tile)
        :precondition (and
            (atWaiter ?w ?from)
            (accessible ?from ?to)
        )
        :effect (and
            (atWaiter ?w ?to) (not(atWaiter ?w ?from))
            (increase(total-time-taken)1)
        )
        ; :expansion ;deprecated
    )

    (:action takeOrder
        :parameters (?w - waiter ?ta - table ?ti - tile)
        :precondition (and
            (atWaiter ?w ?ti)
            (atTable ?ta ?ti)
            ;(not(orderTaken ?ta))
            ;(>(numFood) 0)
        )
        :effect (and
            (increase(carrying ?w) (numFood ?ta))
            (increase(tableId ?w) (orderId)) ;pass on info to waiter (set to 0 in init s)
            (increase(tableIdTable ?ta) (orderId)) ;pass on info to table (set to 0 in init s)
            (increase(orderId)1)
            (orderTaken ?ta)
        )
        ; :expansion ;deprecated
    )

    (:action deliverToCook
        :parameters (?w - waiter ?ti - tile)
        :precondition (and
            (atWaiter ?w ?ti)
            (atKitchen ?ti)
            (= (isKitchenOccupied) 0)   
        )
        :effect (and
            (increase(cooking ?ti) (carrying ?w))
            (increase(tableIdcook ?ti) (tableId ?w))
            (decrease(tableId ?w) (tableId ?w))
            (increase(isKitchenOccupied)1)
            ;(not(isKitchenFree ?ti))
        )
        ; :expansion ;deprecated
    )
    ;!!!find a way to pass id and food amount (maybe making it an obj)
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

    (:action takeFromCook
        :parameters (?w - waiter ?ti - tile)
        :precondition (and
            (atWaiter ?w ?ti)
            (atKitchen ?ti)
            (foodReady ?ti)  
        )
        :effect (and
            (increase(tableId ?w) (tableIdcook ?ti))
            (increase(carrying ?w) (cooking ?ti))
            (decrease(cooking ?ti) (cooking ?ti))
            (not(foodReady ?ti))
            ;(not(isKitchenFree ?ti))
        )
        ; :expansion ;deprecated
    )

    (:action deliverToTable
        :parameters (?w - waiter ?ta - table ?ti - tile)
        :precondition (and
            (atWaiter ?w ?ti)
            (atTable ?ta ?ti)
            (=(tableId ?w)(tableIdTable ?ta))
            (orderTaken ?ta)
            ;(not(orderTaken ?ta))
            ;(>(numFood) 0)
        )
        :effect (and
            (foodDelivered ?ta)
            (decrease(carrying ?w) (carrying ?w) )
            (decrease(tableId ?w) (tableId ?w) ) ;pass on info to waiter (set to 0 in init s)
        )
        ; :expansion ;deprecated
    )


    ;action deliverToTable


)