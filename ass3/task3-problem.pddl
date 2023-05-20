(define (problem waiting-22) ;; Replace XX with task number
    (:domain waiting)
    (:objects
        P1 - package
        P2 - package
        P3 - package
        A - location
        B - location
        C - location
        D - location
        E - location
        F - location
        G - location
        H - location
        I - location
    )
    
    (:init
    ;; robot init
        (at Robo A)
        (empty Robo)
    
    ;; packages init    
        (at P1 F)
        (at P2 E)
        (at P3 G)
    
    ;; connections init
        (connected A B)(connected B A)
        (connected D B)(connected B D)
        (connected A D)(connected D A)
        (connected B C)(connected C B)
        (connected C E)(connected E C)
        (connected D E)(connected E D)
        (connected D F)(connected F D)
        (connected F H)(connected H F)
        (connected G H)(connected H G)
        (connected H I)(connected I H)
        
    ;; locations init
        (not (empty_loc F))
        (not (empty_loc E))
        (not (empty_loc G))
        (empty_loc A)
        (empty_loc B)
        (empty_loc C)
        (empty_loc D)
        (empty_loc H)
        (empty_loc I)
        
    )
    
    (:goal (and 
        (at P2 G)
        (at P1 F)
        (at P3 E)
    ))
)