(require 'cl)
(require 'package)
(require 'ido)

;; активируем пакет ido
(ido-mode t)

;; Список пакетов для установки, на самом деле у меня их под 50 штук, но смысл
;; публиковать их здесь?

(defvar cfg-var:packages '(
                           ;;auto-complete
                           elpy
                           ;;autopair
                           ;;flycheck
                           ;;jedi
    ))

(defun cfg:install-packages ()
    (let ((pkgs (remove-if #'package-installed-p cfg-var:packages)))
        (when pkgs
            (message "%s" "Emacs refresh packages database...")
            (package-refresh-contents)
            (message "%s" " done.")
            (dolist (p cfg-var:packages)
                (package-install p)))))

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(cfg:install-packages)

