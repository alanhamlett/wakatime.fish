###
# wakatime.fish
#
#　hook script to send wakatime a tick (unofficial)
# see: https://github.com/ik11235/wakatime.fish
###

function register_wakatime_fish_before_exec -e fish_preexec
  set -l PLUGIN_NAME "ik11235/wakatime.fish"
  set -l PLUGIN_VERSION "0.0.1"

  set -l project
  set -l wakatime_path

  if type -p wakatime 2>&1 > /dev/null
    set wakatime_path (type -p wakatime)
  else if type -p ~/.wakatime/wakatime-cli 2>&1 > /dev/null
    set wakatime_path (type -p ~/.wakatime/wakatime-cli)
  else
    echo "wakatime command not found. Please read \"https://wakatime.com/terminal\" and install wakatime."
    return 1
  end

  if git rev-parse --is-inside-work-tree 2>&1 > /dev/null
    set project (basename (git rev-parse --show-toplevel))
  else
    set project "Terminal"
  end

  $wakatime_path --write --plugin "$PLUGIN_NAME/$PLUGIN_VERSION" --entity-type app --project "$project" --entity (echo $history[1] | cut -d ' ' -f1) 2>&1 > /dev/null&
end
