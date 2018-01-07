;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-4_ex51_traffic-light) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Exercise 51. Design a big-bang program that simulates
; a traffic light for a given duration. The program renders
; the state of a traffic light as a solid circle of the
; appropriate color, and it changes state on every clock tick.
; What is the most appropriate initial state?

; !!!!! NOT DONE: big-bang duration

; WorldState is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation: possible states that a traffic light may assume

; ********** physical constants
(define WORLD-WIDTH 100) ; x
(define WORLD-HEIGHT 100) ; y
; (define DURATION 30) ; 30 seconds

; ********** graphiccal constants

(define BACKGROUND (empty-scene WORLD-WIDTH WORLD-HEIGHT "white"))

; ********** FUNCTIONS

; WorldState -> WorldState
; switch traffic light
(check-expect (switch-light "red") "green")
(check-expect (switch-light "green") "yellow")
(check-expect (switch-light "yellow") "red")

(define (switch-light ws)
  (cond
    [(string=? "red" ws) "green"]
    [(string=? "green" ws) "yellow"]
    [(string=? "yellow" ws) "red"]))

; WorldState -> Image
; renders current traffic light as a circle
(check-expect (render-traffic-light "green")
              (place-image (circle 30 "solid" "green")
                           50 50
                           BACKGROUND))

(define (render-traffic-light ws)
  (place-image (circle 30 "solid" ws) 50 50 BACKGROUND))

; WorldState -> WorldState
; main
(define (main s)
  (big-bang s
            (to-draw render-traffic-light)
            (on-tick switch-light 0.5))) ; ticks twice a second
