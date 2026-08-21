######################## Auto enabled in omz ######################
# directory nav
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_MINUS

# history
setopt EXTENDED_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

# completion
setopt COMPLETE_IN_WORD ALWAYS_TO_END

# misc
setopt EXTENDED_GLOB INTERACTIVE_COMMENTS
autoload -Uz compinit
compinit

########################### Settings ########################
export EDITOR='nvim'
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

eval "$(zsh-patina activate)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

########################### Auto Completions #################
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh)
source <(kubectl completion zsh)
source ~/.config/zsh/git.plugin.zsh
source ~/.config/zsh/kubectl.plugin.zsh

############################ Aliases #############################
alias -- -='cd -'
alias l="ls -lah"
alias v="nvim"
alias b="bazelisk"
alias k="kubectl"
alias kg="kubectl get"
alias kx="kubectx"
#alias k9sdev="k9s --context saas-dev-0-tailscale-operator.taila064d.ts.net"
alias k9sdev="k9s --context arn:aws:eks:us-east-2:939990436136:cluster/us-east-2-saas-dev-0"
alias k9sd="k9s --context data-3-tailscale-operator.taila064d.ts.net"
alias claude="claude --setting-sources=user"

############################ Functions ###########################
function assume_role() {
   local role_arn="$1"
   local session_name="${2:-temp-session}"

   if [[ -z "$role_arn" ]]; then
       echo "Usage: assume_role <role_arn> [session_name]"
       return 1
   fi

   local creds=$(aws sts assume-role \
       --role-arn "$role_arn" \
       --role-session-name "$session_name" \
       --output json)

   export AWS_ACCESS_KEY_ID=$(echo $creds | jq -r .Credentials.AccessKeyId)
   export AWS_SECRET_ACCESS_KEY=$(echo $creds | jq -r .Credentials.SecretAccessKey)
   export AWS_SESSION_TOKEN=$(echo $creds | jq -r .Credentials.SessionToken)
}

function ssm() {
    kubectl get no $1 -ojson | jq '.spec.providerID' -r | awk -F'/' '{print $NF}' | AWS_REGION=us-east-2 xargs -o -I{} aws ssm start-session --target {}
}

function gitprune() {
  git fetch -p && \
  git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
}

function gwn() {
  if [[ -z "$1" ]]; then
    echo "usage: gwn <name>" >&2
    return 1
  fi
  local name="$1"
  local repo_root
  repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    echo "gwn: not inside a git repository" >&2
    return 1
  }
  local branch="junze/${name}"
  local target="${repo_root%/*}/${name}"
  if git show-ref --verify --quiet "refs/heads/${branch}"; then
    git worktree add "$target" "$branch" || return $?
  else
    git fetch origin main --quiet || return $?
    git worktree add -b "$branch" "$target" origin/main || return $?
  fi
  cmux new-workspace --name "$name" --cwd "$target" --focus true
}

function gwd() {
  local repo_root
  repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    echo "gwd: not inside a git repository" >&2
    return 1
  }
  local main_root
  main_root="$(git worktree list --porcelain | awk '/^worktree /{print $2; exit}')"
  if [[ "$repo_root" == "$main_root" ]]; then
    echo "gwd: refusing to remove the main worktree ($repo_root)" >&2
    return 1
  fi

  local ws_ref
  ws_ref="$(cmux identify 2>/dev/null | awk -F'"' '/"workspace_ref"/{print $4; exit}')"

  cd "${main_root:-${repo_root%/*}}"
  git worktree remove "$repo_root" || return $?

  if [[ -n "$ws_ref" ]]; then
    cmux close-workspace --workspace "$ws_ref"
  fi
}

function pr() {
  gh pr view --web
}
