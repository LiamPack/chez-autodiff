;; -*- mode: scheme; coding: utf-8 -*-
;; Copyright (c) 2021 Liam Packer
;; SPDX-License-Identifier: MIT
#!r6rs

(library (chez-autodiff)
  (export make-dual dual? dual-val dual-partials
          dual-add dual-mul dual-negate)
  (import (rnrs (6)))

  (define-record-type dual
    (fields val partials))

  (define (dual-add . bs)
    (make-dual (fold-left + 0 (map (lambda (x) (dual-val x)) bs))
               (fold-left + 0 (map (lambda (x) (dual-partials x)) bs))))

  (define (dual-mul a b)
    (cond
     [(and (dual? a) (number? b)
           (make-dual (* (dual-val a) b)
                      (* (dual-partials a) b)))]
     [(and (number? a) (dual? b))
      (make-dual (* (dual-val b) a)
                 (* (dual-partials b) a))]
     [(and (dual? a) (dual? b))
      (make-dual (* (dual-val a) (dual-val b))
                 (+ (* (dual-val a) (dual-partials b)) (* (dual-val b) (dual-partials a))))]))

  (define (dual-negate a)
    (make-dual (* -1 (dual-val a))
               (* -1 (dual-partials a)))))
