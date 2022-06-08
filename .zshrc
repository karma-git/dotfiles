# Shell
## settings zsh; oh-my-zsh

export ZSH="${HOME}/.oh-my-zsh"
ZSH_DISABLE_COMPFIX=true
ZSH_ALIAS_FINDER_AUTOMATIC=true

plugins=(
  alias-finder
  docker
  docker-compose
  git
  kubectl
  vagrant
  zsh-autosuggestions
  zsh-syntax-highlighting
  )

source $ZSH/oh-my-zsh.sh

# ref:https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="aussiegeek"

eval "$(starship init zsh)"

# kubernetes settings
autoload -Uz compinit
compinit
export KUBECONFIG=${HOME}/.kube/config:$(find ~/.kube -name 'kubeconfig_*' | paste -s -d ':' -)

# Aliases

alias cat=bat

alias 4g="sudo sysctl -w net.inet.ip.ttl=65"  # Change ttl for don't run router mode on ph
alias wifipwsh='f() {security find-generic-password -wa $1}; f' # sh wifi (SSID) pw -> you have to insert SSID name

alias gpw='python -c "import uuid; print(uuid.uuid4().hex)" # an example, how to generate key via python'  # generating password

alias vc='current_dir=`printf '%q\n' "${PWD##*/}"`; python3 -m venv $current_dir' # creates venv with a name of current dir
alias va='f() {current_dir=`printf '%q\n' "${PWD##*/}"`; source $current_dir/bin/activate};f' # activate venv in current dir
alias vd='deactivate' # deactivate venv

alias ss='f();{kubeseal --context $(kubectl config current-context) --controller-name sealed-secrets -o yaml "${1}.secret.yml" > "${1}.sealedsecret.yml" };f'

complete -F __start_kubectl k

alias docker-clean=' \
  docker container prune -f ; \
  docker image prune -f ; \
  docker network prune -f ; \
  docker volume prune -f '
