;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Koch) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #t)))
(define black (make-color 0 0 0))

(define-struct image-posn (img x y))
;; An ImageXY is a (make-image-posn Image Nat Nat)

(define black-pen (make-pen "black" 0 "solid" "round" "round"))


;; (overlay-list images) produces a single image with every image overlayed
;;                       and offset by it's corresponding x and y coordinates
;; overlay-list: (listof Image-posn) -> Image

(define (overlay-list images)
  (cond [(empty? images) empty-image]
        [else (overlay/align/offset "left" "bottom"
                                    (overlay-list (rest images))
                                    (image-posn-x (first images)) (image-posn-y (first images))
                                    (image-posn-img (first images)))]))


;; (koch n l) produces nth iteration of koch curve with line segments of length l
;; koch: Nat Nat -> Image

(define (koch n l)
  (cond [(= n 0) (line l 0 black-pen)]
        [else (local [(define prevIteration (koch (- n 1) l))]
                (overlay-list (list
                               (make-image-posn prevIteration
                                                0          0)
                               (make-image-posn prevIteration
                                                (* 2 l (expt 3 (- n 1)))    0)
                               (make-image-posn (rotate 60 prevIteration)
                                                (* (expt 3 (- n 1)) l) 0)
                               (make-image-posn (rotate -60 prevIteration)
                                                (* l 1.5 (expt 3 (- n 1)))  0))))]))


;; (koch-snowflake n l) produces nth iteration of koch snowflake
;;                      with line segments of length l
;; koch-snowflake: Nat Nat -> Image

(define (koch-snowflake n l)
  (overlay/align/offset "left" "bottom"
                        (overlay/offset (rotate 60 (koch n l))
                                        (* (expt 3 n) 1/2 l) 0
                                        (rotate -60 (koch n l)))
                        0 (* (sin (/ pi 3)) l (expt 3 (- n 1)))
                        (rotate 180 (koch n l))))








