;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname HilbertV2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #t)))
(define black (make-color   0   0   0))
(define clear (make-color   0   0   0   0))

(define-struct image-posn (img x y))
;; An Image-Posn is a (make-image-posn Image Nat Nat)

(define black-pen (make-pen "black" 0 "solid" "round" "round"))

;; (overlay-list images) produces a single image with every image overlayed
;;                       and offset by it's corresponding x and y coordinates
;; overlay-list: (listof Image-Posn) -> Image

(define (overlay-list images)
  (cond [(empty? images) empty-image]
        [else (overlay/align/offset "left" "top"
                                    (overlay-list (rest images))
                                    (image-posn-x (first images)) (image-posn-y (first images))
                                    (image-posn-img (first images)))]))

;; (separators n l) produces the lines separating the
;;                  four (n-1)th iterations of the curve
;; separators Nat Nat -> Image

(define (separators n l)
  (add-line (add-line (add-line (square (* (expt 2 n) l) 'solid clear)
                                l                            (* (expt 2 (- n 1)) l)
                                (* (- (expt 2 n) 1) l) (* (expt 2 (- n 1)) l)
                                black-pen)
                      (* (expt 2 (- n 1)) l) 0
                      (* (expt 2 (- n 1)) l) (* (- (expt 2 (- n 1)) 1) l) 
                      black-pen)
            (* (expt 2 (- n 1)) l) (* (expt 2 (- n 1)) l)
            (* (expt 2 (- n 1)) l) (* (expt 2 n) l)
            black-pen))

;; (hilbert n l) produces iteration n of hilbert curve
;;               with line segments of length l
;; hilbert: Nat Nat -> Image

(define (hilbert n l)
  (cond [(= n 0) empty-image]
        [else (overlay-list (list
                             (make-image-posn (separators n l)
                                              0 0)
                             (make-image-posn (hilbert (- n 1) l)
                                              0 0)
                             (make-image-posn (hilbert (- n 1) l)
                                              (* (expt 2 (- n 1)) l) 0)
                             (make-image-posn (rotate 270 (hilbert (- n 1) l))
                                              0 (* (expt 2 (- n 1)) l))
                             (make-image-posn (rotate 90 (hilbert (- n 1) l))
                                              (* (expt 2 (- n 1)) l) (* (expt 2 (- n 1)) l))))]))

;; (hilbert-wrapper n l) produces nth iteration of hilbert curve
;;                       with line segments of length l
;; hilbert-wrapper: Nat Nat -> Image

(define (hilbert-wrapper n l)
  (frame (hilbert n l)))



