# fish всем хорош кроме багов и синтаксиса, который не имеет обратной
# совместимости с Bash

# Пути и переменные окружения
export GOPATH="${GOPATH:-$HOME/go}"

typeset -U path fpath

path=(
  "$HOME/.local/bin"
  "$GOPATH/bin"
  "$HOME/.cargo/bin"
  #"$PYENV_ROOT/bin"
  $path
)

fpath+=(
  "$ZDOTDIR/functions"
  "$ZDOTDIR/completions"
)

# Настройки плагинов через zstyle должны быть до их подключения
#zstyle ':antidote:compatibility-mode' 'antibody' 'on'

# Отображение иконок в ls
zstyle ':omz:plugins:eza' 'icons' yes

# Не помню что это
zstyle :prompt:pure:git:fetch only_upstream yes

# Не отображаем встроенное меню автодополнения, так как используем fzf-tab
zstyle ':completion:*' menu no

# git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
# Обновление всех плагинов:
# antidote update

source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

# Настройки самого zsh
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history       # Запись timestamp и длительности команд
setopt hist_expire_dups_first # Удаление дубликатов при переполнении
setopt hist_ignore_dups       # Игнорирование повторяющихся команд
setopt hist_ignore_space      # Пропуск команд, начинающихся с пробела
setopt share_history          # Общая история между сессиями

# Поиск по истории с Up/Down Arrows
# Работает так: печатаем часть команды, а потом, нажимая стрелки выбираем варианты, начинающиеся с подстроки

# Этот вариант не работат
# bindkey "^[[A" history-substring-search-up
# bindkey "^[[B" history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Автозагрузка конфигов
# mkdir -p "$ZDOTDIR/zshrc.d"
# конфигам лучше добавлять числовые префиксы, чтобы управлять порядком их загрузки
# touch $ZDOTDIR/zshrc.d/00-core.zsh
# echo "alias zshrc='$EDITOR $ZDOTDIR/.zshrc'" >> "$ZDOTDIR/zshrc.d/editor.sh"
# echo 'alias vimrc="vim $MYVIMRC"' >> "$ZDOTDIR/zshrc.d/aliases.sh"
if [[ -d $ZDOTDIR/zshrc.d ]]; then
  # игнорируем дот-файлы
  for config ($ZDOTDIR/zshrc.d/[^.]*(N)); do
    #echo $config
    . "$config"
  done
fi

# ZELLIJ_AUTO_ATTACH=true
# ZELLIJ_AUTO_EXIT=true
# # [[ $XDG_SESSION_TYPE == "tty" ]]
# if [ $(command -v zellij) ] && [ "$TERM" == *alacritty* ]; then
#   eval "$(zellij setup --generate-auto-start zsh)"
# fi
