;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-3_mice-and-keys_keys) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Exercise 1. Look through the functions in the 2htdp/image
; library and find a way to create framed, left-aligned text.
; Then change the program in figure 4 so that it uses this
; combination of image primitives to render its state. 

; ?????????????????????????????
; the world state SHOULD BE AN IMAGE???


; distances in terms of pixels 
(define WIDTH 100)
(define HEIGHT 30)
 
; graphical constant:
(define MT (empty-scene WIDTH HEIGHT))
 
; An AllKeys is a String.
; interpretation: the keys pressed since big-bang created the canvas
 
; String -> AllKeys
(define (main s)
  (big-bang s
    [on-key remember]
    [to-draw show]))
 
 
; AllKeys String -> AllKeys
; adds pressed-key to all-keys, the state of the world
 
(define (remember all-keys pressed-key)
  (string-append all-keys pressed-key))
 
; AllKeys -> Image
; renders the string as a text and places it into MT
 
(define (show all-keys)
  (overlay/align
   "left" "middle"
   (text all-keys 11 "red") MT))