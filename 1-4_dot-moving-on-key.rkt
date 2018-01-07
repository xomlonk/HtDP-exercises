;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-4_dot-moving-on-key) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; 4.3 Enumerations

; Sample Problem Design a key-event handler that moves a red dot
; left or right on a horizontal line in response to pressing
; the left and right arrow keys.


(define BACKGROUND (empty-scene 400 100 "white"))
; the red dot
(define DOT (circle 15 "solid" "red"))
; horizontal line
(define LINE (rectangle 400 2 "solid" "black"))
; dot and line y position
(define Y-DOT-LINE 50)

; String WorldState -> WorldState
; change x coord of a dot (ws) on left arrow key: -1
; on right arrow key: +1
(define (keh ws k)
  (cond
    [(string=? "left" k) (- ws 1)]
    [(string=? "right" k) (+ ws 1)]
    [else ws]))


; draw the scene
(define (render-scene ws)
  (place-image DOT
               ws Y-DOT-LINE
               (place-image LINE 200 Y-DOT-LINE BACKGROUND)))

; do nothing
(define (do-nothing ws) ws)

; WorldState is dot position
; main
(define (main p)
              (big-bang p
                        (on-tick do-nothing)
                        (to-draw render-scene)
                        (on-key keh)))