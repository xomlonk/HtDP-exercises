;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-4_descending-ufo) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; a program that simulates the descent of a UFO.
; ==========================

; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO

(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define X-MIDLLE (/ WIDTH 2))
(define CLOSE (/ HEIGHT 3)) ; closing in
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay/align "middle" "middle"
                           (circle 10 "solid" "black")
                           (ellipse 40 10 "solid" "black")))
(define UFO-MID-HEIGHT (/ (image-height UFO) 2))


; WorldState -> WorldStatefrom a func­tion
(define (main y0)
  (big-bang y0
            [on-tick nxt]
            [to-draw render]
            [stop-when is-landed?]))

; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)

(define (nxt y)
  (+ y 3))

; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11)
              (place-image UFO X-MIDLLE 11
                           (overlay/align "left" "top"
                                          (text (status-line 11) 20 "indigo")
                                          MTSCN)))

(define (render y)
  (place-image UFO X-MIDLLE y
               (overlay/align "left" "top"
                              (text (status-line y) 20 "indigo")
                              MTSCN)))

; WorldState -> String
; a status line. It says "descending" when the UFO's height is above
; 1/3 of canvas height; "closing in" - when below that; "landed" -
; when reached the bottom.
; intervals:
; – between 0 and CLOSE
; – between CLOSE and HEIGHT
; – below HEIGHT
(check-expect (status-line 10) "descending")
(check-expect (status-line (- HEIGHT (/ HEIGHT 4))) "closing in")
(check-expect (status-line HEIGHT) "landed")

(define (status-line y)
  (cond
    [(<= 0 y CLOSE) "descending"]
    [(and (> y CLOSE) (< y (- HEIGHT UFO-MID-HEIGHT))) "closing in"]
    [(>= y (- HEIGHT UFO-MID-HEIGHT)) "landed"]
    ))

; WorldState -> Boolean
; check id UFO has landed
(check-expect (is-landed? 99) #true)
(check-expect (is-landed? 10) #false)

(define (is-landed? ws)
  (if (>= ws (- HEIGHT UFO-MID-HEIGHT)) #true #false))