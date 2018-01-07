;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1-3_designing-functions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; I. Fixed-Size Data

; Exercise 34. Design the function string-first,
; which extracts the first character from a non-empty string.
; Don’t worry about empty strings.

; extract the first character from a non-empty string
; String -> String
; given: "banana", expect: "b"
; given: "", expect: "the string is empty"
(define (string-first str)
  (cond
    [(= (string-length str) 0) "the string is empty"]
    [(> (string-length str) 0)(string-ith str 0)]))


; Exercise 35. Design the function string-last,
; which extracts the last character from a non-empty string.

; extract the last character from a non-empty string
; String -> String
; given: "banana", expect: "a"
; given: "", expect: "the string is empty"
(define (string-last str)
  (if (= (string-length str) 0)
      "the string is empty"
      (string-ith str (- (string-length str) 1))))


; Exercise 36. Design the function image-area, which counts
; the number of pixels in a given image.

; count the area of an image
; Image -> Number
; given: (rectangle 40 20 "outline" "black"), expect: 800
(define (image-area img)
  (* (image-width img) (image-height img)))


; Exercise 37. Design the function string-rest,
; which produces a string like the given one with
; the first character removed.

; remove the forst char of a string and return the rest
; String -> String
; given: "applepie", expect: "pplepie"
(define (string-rest str)
  (substring str 1))


; Exercise 38. Design the function string-remove-last,
; which produces a string like the given one with
; the last character removed.

; remove the last char of a string and return the rest
; String -> String
; given: "cherry", expect: "cherr"
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))
