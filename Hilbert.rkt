;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Hilbert) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #t)))
(define black (make-color 0 0 0))

(define-struct image-posn (img x y))
;; An ImageXY is a (make-image-posn Image Nat Nat)


;; (curve-size n l) produces size of nth iteration of hilbert
;;                  curve with line segments of length l
;; curve-size: Nat Nat -> Nat

(define (curve-size n l)
  (* l (- (expt 2 n) 1)))

;; (overlay-list images) produces a single image with every image overlayed
;;                       and offset by it's corresponding x and y coordinates
;; overlay-list: (listof Image-posn) -> Image

(define (overlay-list images)
  (cond [(empty? images) empty-image]
        [else (overlay/align/offset "left" "top"
                                    (overlay-list (rest images))
                                    (image-posn-x (first images)) (image-posn-y (first images))
                                    (image-posn-img (first images)))]))

;; (connectors n l) produces the lines connecting the
;;                  four (n-1)th iterations of the curve
;; connectors: Nat Nat -> Image

(define (connectors n l)
  (add-line (add-line (add-line empty-image
                                0 (curve-size (- n 1) l)
                                0 (+ (curve-size (- n 1) l) l)
                                black)
                      (curve-size (- n 1) l)       (curve-size (- n 1) l)
                      (+ (curve-size (- n 1) l) l) (curve-size (- n 1) l)
                      black)
            (curve-size n l) (curve-size (- n 1) l)
            (curve-size n l) (+ (curve-size (- n 1) l) l)
            black))

;; (hilbert n l) produces iteration n of hilbert curve
;;               with line segments of length l
;; hilbert: Nat Nat -> Image

(define (hilbert n l)
  (cond [(= n 0) empty-image]
        [else (overlay-list (list
                             (make-image-posn (connectors n l)
                                              0 0)
                             (make-image-posn (hilbert (- n 1) l)
                                              0 0)
                             (make-image-posn (hilbert (- n 1) l)
                                              (+ (curve-size (- n 1) l) l) 0)
                             (make-image-posn (rotate 270 (hilbert (- n 1) l))
                                              0 (+ (curve-size (- n 1) l) l))
                             (make-image-posn (rotate 90 (hilbert (- n 1) l))
                                              (+ (curve-size (- n 1) l) l) (+ (curve-size (- n 1) l) l))))]))