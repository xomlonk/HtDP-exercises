;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname prologue) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; function to animate:
; a circle falling down inside a canvas
(define (picture-of-circle height)
  (place-image (circle 7 "solid" "red") 50 height (empty-scene 100 60)))

; example function to demonstrate conditions
; inputs a number
; outputs its sign
(define (sign x)
  (cond
    [(> x 0) 1]
    [(= x 0) 0]
    [(< x 0) -1]))

; using conditions so that the circle stops at the bottom of canvas
(define (picture-of-circle.v2 height)
  (cond
    [(<= height (- 60 7))
     (place-image (circle 7 "solid" "blue") 50 height
                  (empty-scene 100 60))]
    [(> height (- 60 7))
     (place-image (circle 7 "solid" "blue") 50 (- 60 7)
                  (empty-scene 100 60))]))

; ***************

; properties of the "world" and the descending circle
(define WIDTH 100) ; canvas width
(define HEIGHT 80) ; canvas height = the ground line coordinate (y)
(define V 1) ; the velocity constant
(define X-POS 50) ; the x position of circle and rock

; graphical constants
(define CLEAR-SCENE (empty-scene WIDTH HEIGHT "beige" )) ; clear the canvas
(define CIRCLE (circle 11 "solid" "black")) ; image of a circle
(define ROCK (rectangle 40 4 "solid" "brown")) ; image of a rock
(define ROCK-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCK) 2))) ; distance from top to the rock
; distance from top to the circle when it lays on the rock
(define CIRCLE-CENTER-TO-TOP
  (- HEIGHT (+ (/ (image-height CIRCLE) 2) (image-height ROCK))))
; draw the rock
(define DRAW-ROCK
  (place-image ROCK X-POS ROCK-CENTER-TO-TOP CLEAR-SCENE))


;functions
(define (distance t)
  (* V t)) ; computes distance travelled at a constant velocity

(define (picture-of-circle.v3 t)
  (cond
    ; if the circle is placed above the ground line, leave it here
    [(<= (distance t) CIRCLE-CENTER-TO-TOP)
     (place-image CIRCLE X-POS (distance t) DRAW-ROCK)]
    ; if the circle is under the ground, place on the gr.line
    [(> (distance t) CIRCLE-CENTER-TO-TOP)
     (place-image CIRCLE X-POS CIRCLE-CENTER-TO-TOP
                  DRAW-ROCK)]))


