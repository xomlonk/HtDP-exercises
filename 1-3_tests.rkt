;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-3_tests) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; converts Fahrenheit temperatures to Celsius
; Number -> Number

(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)
(check-expect (f2c -40) -40)

(define (f2c f)
  (* 5/9 (- f 32)))


; draws a car at a given horizontal position
; Number -> Image

(check-expect (render 50)
              (place-image CAR 50 Y-CAR BACKGROUND))

(define CAR (overlay/xy
             (overlay/xy (rectangle 40 20 "solid" "red")
                        10 15
                        (circle 8 "solid" "black"))
             30 15
             (circle 8 "solid" "black")))
(define Y-CAR 50)
(define BACKGROUND (empty-scene 300 80 "tan"))

(define (render x-pos)
  (place-image CAR x-pos Y-CAR BACKGROUND))