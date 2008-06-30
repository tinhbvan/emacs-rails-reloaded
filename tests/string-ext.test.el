(require 'elunit)
(require 'string-ext)

(defsuite string-ext ext)

(deftest string-ext/cut string-ext
  (assert-equal "ing" (string-ext/cut "String" "Str" :begin))
  (assert-equal "" (string-ext/cut "String" "String" :begin))

  (assert-nil (string-ext/cut "String" "Str2" :begin))
  (assert-nil (string-ext/cut "String" "String2" :begin))

  (assert-equal "Str" (string-ext/cut "String" "ing" :end))
  (assert-equal "" (string-ext/cut "String" "String" :end))

  (assert-nil (string-ext/cut "String" "ing2" :end))
  (assert-nil (string-ext/cut "String" "String2" :end)))

(deftest string-ext/cut-safe string-ext
  (assert-equal "Str" (string-ext/cut-safe "String" "ing" :end))
  (assert-equal "ing" (string-ext/cut-safe "String" "Str" :begin))
  (assert-equal "String" (string-ext/cut-safe "String" "Str" :end))
  (assert-equal "String" (string-ext/cut-safe "String" "ing" :begin)))

(deftest string-ext/from-symbol string-ext
  (assert-equal "sym" (string-ext/from-symbol :sym))
  (assert-equal "sym" (string-ext/from-symbol 'sym)))

(deftest string-ext/start-p string-ext
  (assert (string-ext/start-p "String" "Str"))
  (assert-nil (string-ext/start-p "String" "ing")))

(deftest string-ext/end-p string-ext
  (assert (string-ext/end-p "String" "ing"))
  (assert-nil (string-ext/end-p "String" "Str")))

(deftest string-ext/string=~ string-ext
  (let ((str "One Two Three"))
    (assert-equal "Two" (string-ext/string=~ "\\(Two\\)" str $1))
    (assert-equal "Three" (string-ext/string=~ "\\(One\\) \\(Two\\) \\(\Three\\)" str $3))
    (assert-equal "One " (string-ext/string=~ "\\(Two\\)" str $b))
    (assert-equal " Three" (string-ext/string=~ "\\(Two\\)" str $a))
    (assert-equal "One" (string-ext/string=~ "\\(One\\)" str $m))
    (let ((re "\\(NoExist\\)"))
      (assert-nil (string-ext/string=~ re str $b))
      (assert-nil (string-ext/string=~ re str $m))
      (assert-nil (string-ext/string=~ re str $a))
      (assert-nil (string-ext/string=~ re str $$1)))))

(deftest string-ext/decamelize string-ext
  (assert-equal "CamelCase" (string-ext/decamelize "camel_case"))
  (assert-equal "Camelcase" (string-ext/decamelize "CamelCase"))
  (assert-equal "CamelCase::StrIng" (string-ext/decamelize "camel_case/str_ing"))
  (assert-equal "2camelCase::StrIng" (string-ext/decamelize "2camel_case/str_ing")))

(deftest string-ext/camelize string-ext
  (assert-equal "camel_case" (string-ext/camelize "CamelCase"))
  (assert-equal "camel_case/str_ing" (string-ext/camelize "CamelCase::StrIng"))
  (assert-equal "2camel_case/str_ing" (string-ext/camelize "2camelCase::StrIng")))

(deftest string-ext/camelize string-ext
  (assert-equal "camel_case" (string-ext/camelize "CamelCase"))
  (assert-equal "camel_case/str_ing" (string-ext/camelize "CamelCase::StrIng"))
  (assert-equal "2camel_case/str_ing" (string-ext/camelize "2camelCase::StrIng")))

(deftest string-ext/empty-p string-ext
  (assert (string-ext/empty-p ""))
  (assert (string-ext/empty-p "  "))
  (assert-nil (string-ext/empty-p " as ")))