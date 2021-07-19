;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


;; Personal Identifiacation
(setq user-full-name "Anurup Dey"
      user-mail-address "anu.rup.dey98@gmail.com")

;; email settings
(set-email-account! "gmail-personal"
                    '((mu4e-sent-folder       . "/gmail-personal/sent")
                      (mu4e-drafts-folder     . "/gmail-personal/drafts")
                      (mu4e-trash-folder      . "/gmail-personal/trash")
                      (mu4e-refile-folder     . "/gmail-personal/archive")
                      (smtpmail-smtp-user     . "anu.rup.dey98@gmail.com")
                      (mu4e-compose-signature . "---\nAnurup Dey"))
                    t)

(setq mu4e-sent-messages-behavior 'delete)
(setq mu4e-get-mail-command "mbsync -a")

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; Theming and Styling

(setq fancy-splash-image "~/.config/doom/black-hole.png")

(setq doom-font (font-spec :family "monospace" :size 13)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq-default line-spacing 0.01)
(setq doom-theme 'doom-tomorrow-night)

(after! treemacs doom-theme
  (setq doom-themes-treemacs-theme "Default")
  (doom-themes-treemacs-config)
  (treemacs-resize-icons 13))

(use-package! treemacs-icons-dired
  :after treemacs dired
  :config (treemacs-icons-dired-mode))

(use-package! all-the-icons
  :config (setq all-the-icons-scale-factor 1.0))

(setq display-line-numbers-type nil)

;; plugin configuration
(use-package! org
  :init (setq org-directory "~/org/"
              org-hide-emphasis-markers t))

(use-package! dap-cpptools
  :commands dap-debug
  :hook (c-mode c++-mode objc-mode cuda-mode)
  :config
  (add-hook! 'dap-stopped-hook
    (lambda (_) (call-interactively #'dap-hydra)))
  (setq dap-auto-configure-features '(sessions locals tooltip))
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        treemacs-space-between-root-nodes nil)
  (map! :leader
        :desc "Toggle Breakpoint"
        "c b" #'dap-breakpoint-toggle))

;; (use-package! dap-gdb-lldb
;;   :hook (rustic-mode)
;;   :config
;;   (dap-register-debug-template "Rust::GDB Run Configuration"
;;         (list :type "gdb"
;;               :request "launch"
;;               :name "GDB::Run"
;;               :gdbpath "rust-gdb"
;;               :target nil
;;               :cwd nil)))

(after! company
  (setq company-minimum-prefix-length 4))

;; colors each point (cursor) visible as a different color
;; usefull when colaboratively editing
(load! "colorful-points.el")

;; Editor configuration

;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-up (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-down (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-left (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-right (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)



;; 1. What am I?
;; 2. What is this in front of me?
;; 3. What is the relation between me and what is in front of me?
