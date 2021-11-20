#!/usr/bin/env scheme-script
;; -*- mode: scheme; coding: utf-8 -*- !#
;; Copyright (c) 2021 Liam Packer
;; SPDX-License-Identifier: MIT
#!r6rs

(import (rnrs (6)) (srfi :64 testing) (chez-autodiff))

(define a (make-dual 3 4))
(define b (make-dual -2 1))

(test-begin "dual add")
(test-equal "dual add val" 1 (dual-val (dual-add a b)))
(test-equal "dual add partials" 5 (dual-partials (dual-add a b)))
(test-equal "dual mul val" -6 (dual-val (dual-mul a b)))
(test-equal "dual mul partials" (+ 3 (- 8)) (dual-partials (dual-mul a b)))
(test-end)


;; (exit (if (zero? (test-runner-fail-count (test-runner-get))) 0 1))
