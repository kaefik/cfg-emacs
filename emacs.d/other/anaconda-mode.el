;;; Package --- Summary
;;; Commentary:
;;; Settings for Python

;;; Code:

;;; Импорт необходимых модулей
(require 'py-autopep8)
(require 'py-isort)
(require 'pip-requirements-mode)

;;; Псевдоним для команды pyvenv-workon, пользователи virtualenv оценят удобство
(defalias 'workon 'pyvenv-workon)

;;; Автоматически загружать модуль python-mode, писать в статус баре "Python-mode"
(autoload 'python-mode "python-mode" "Python mode." t)

;;; Применять python-mode для файлов с расширением .py
;;; Использовать интерпретатор python для python-mode
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-to-list 'auto-mode-alist '("\\REQUIREMENTS" . pip-requirements-mode))
(add-to-list 'auto-mode-alist '("\\REQUIREMENTS.txt" . pip-requirements-mode))
(add-to-list 'auto-mode-alist '("\\requirements" . pip-requirements-mode))
(add-to-list 'auto-mode-alist '("\\requirements.txt" . pip-requirements-mode))

;;; Подсвечивать строки, которые обычно используются при отладке
(defun annotate-pdb()
  (interactive)
  (highlight-lines-matching-regexp "import ipdb")
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "set_trace()")
  (highlight-phrase "TODO")
  (highlight-regexp "FIXME")
  (highlight-regexp "BUG")
  )

;;; В Python-mode автоматически включать anaconda-mode, pdb и
;;; автоматически применять autopep8 при сохранении файла
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'annotate-pdb)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;;; Перед сохранением так же отсортировать импортированные модули.
;;; Правило сортировки: одна строка - один модуль
(add-hook 'before-save-hook 'py-isort-before-save)
(setq py-isort-options '("-sl"))

;;; python.el ends here
