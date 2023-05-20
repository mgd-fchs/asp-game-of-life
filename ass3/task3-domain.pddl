(define (domain waiting)
    (:requirements :adl )
    
    (:types
        robot - object
        location
        package - object
    )
    
    (:constants 
        Robo - robot
        BUFF - location
    )
    
    (:predicates
        (connected ?x - location ?y - location)
        (at ?x - object ?y - location)
        (holding ?a - robot ?p - package)
        (empty ?a - robot)
        (empty_loc ?a - location)
    )
    
    (:action Move
        :parameters (?x - location ?y - location)
        :precondition (and
            (at Robo ?x)
            (connected ?x ?y)
            (not (at Robo ?y))
            (empty Robo)
            
        )
        :effect (and
            (at Robo ?y)
            (not (at Robo ?x))
            (forall (?p - package) ;; only one package at a time so technically unnecessary?
                (when (and (holding Robo ?p)) ;; Take package on move
                      (and (at ?p ?y) (not (at ?p ?x)))
                )
            )
        )
    )
    
    (:action MoveWithPackage
        :parameters (?x - location ?y - location ?p - package)
        :precondition (and
            (at Robo ?x)
            (connected ?x ?y)
            (not (at Robo ?y))
            (not (empty Robo))
            (holding Robo ?p)
            (empty_loc ?y) ;; there cannot be another package if we want to move there
        )
        :effect (and
            (at Robo ?y)
            (not (at Robo ?x))
            (forall (?p - package) ;; only one package at a time so technically unnecessary?
                (when (and (holding Robo ?p)) ;; Take package on move
                      (and (at ?p ?y) (not (at ?p ?x)))
                )
            )
        )
    )
    
    (:action TakePackage
        :parameters (?a - robot ?p - package ?x - location)
        :precondition (and 
            (at Robo ?x)
            (at ?p ?x)
            (not (holding Robo ?p))
            (empty Robo)
            (not (empty_loc ?x)) ;; There is a package at this location
        )
        :effect (and
            (holding Robo ?p)
            (not (empty Robo))
            (empty_loc ?x)  ;; Location is now empty
        )
    )
    
    (:action LeavePackage
        :parameters (?p - package ?x - location)
        :precondition (and
            (at Robo ?x)
            (holding Robo ?p)
            (not (empty Robo))
            (empty_loc ?x) ;; location must be empty to leave a package
        )
        :effect (and
            (empty Robo)
            (not (holding Robo ?p))
            (at ?p ?x)
            (not (empty_loc ?x))
        )
    )
)