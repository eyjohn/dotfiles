function get_wsl_version
{
  if [ -z "$WSL_DISTRO_NAME" ]; then
    return
  fi
  wsl.exe -l -v |  sed $'s/[^[:print:]]//g;s/^\* /  /' | tail -n +2 | while read name state version
  do
    if [[ "$WSL_DISTRO_NAME" == "$name" ]]; then
      echo $version
      break
    fi
  done
}
