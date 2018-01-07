;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-3_47_happiness-gauge) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; 3.7 Virtual Pet Worlds
; ======================

; Exercise 47. Design a world program that maintains and displays
; a “happiness gauge.”
; The gauge display starts with the maximum score, and with each
; clock tick, happiness decreases by -0.1; it never falls below 0,
; the minimum happiness score. Every time the down arrow key is
; pressed, happiness increases by 1/5; every time the up arrow is
; pressed, happiness jumps by 1/3.
; To show the level of happiness, we use a scene with a solid,
; red rectangle with a black frame.

; **********************************
; physical constants

(define WIDTH-OF-WORLD 220) ; x
(define HEIGHT-OF-WORLD 150) ; y
; max height of the bar = 60px
(define GAUGE-MAX-HEIGHT 60)
(define GAUGE-WIDTH 10)
; **********************************
; graphical constants

(define BACKGROUND
  (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD "white"))
; the black frame for the happyness gauge
; positioning: top- 10px, right- 10px
(define FRAME (rectangle 20 60 "outline" "black"))
(define FRAME-X (- WIDTH-OF-WORLD
                   (+ (/ (image-width FRAME) 2) 10)))
(define FRAME-Y (+ (/ (image-height FRAME) 2) 10))


; the bar
; (rectangle GAUGE-WIDTH (* ws GAUGE-MAX-HEIGHT) "solid" "red")
; positioning: left- 10px, bottom- 10px

; **********************************
; FUNCTIONS

; WorldState is a positive number, between 0 and 1.
; interpretation: level of happiness


; WorldState -> Number
; decrease happiness level on tick by 0.1 points
(define (decrease-happiness ws)
  (cond
    [(<= ws 0) 0]
    [else (- ws 0.1)]))

; WorldState -> Image
; draw a happiness bar in a frame
(define (render-gauge ws)
  (cond
    [(= ws 0) (place-image (overlay/align "middle" "bottom"
                (rectangle GAUGE-WIDTH 1
                 "solid" "red")
                FRAME)
               FRAME-X FRAME-Y
               BACKGROUND)]
    [else (place-image (overlay/align "middle" "bottom"
                (rectangle GAUGE-WIDTH (* ws GAUGE-MAX-HEIGHT)
                 "solid" "red")
                FRAME)
               FRAME-X FRAME-Y
               BACKGROUND)]))

; WorldState String -> WorldState
; key-event dispatcher: check which key is pressed
; if down arrow key is pressed, happiness increases by 1/5;
; if the up arrow is pressed, happiness jumps by 1/3.
; if other key is pressed do nothing (return ws)
(define (check-ke ws ke)
     (cond
       [(key=? ke "down")
        (if (> ws 0.8) 1 (+ ws 0.2))]
       [(key=? ke "up")
        (if (> ws 0.7) 1 (+ ws 0.3))]
       [else ws])
    )

; WorldState -> WorldState
; main func
(define (main s)
  (big-bang s
            (on-tick decrease-happiness 0.25) ; thicks 4 times a sec
            (to-draw render-gauge)
            (on-key check-ke)))

