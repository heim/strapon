#!/usr/bin/env bash
set -e

echo 'Ensure xcode is installed'
if [[ $(/usr/bin/gcc 2>&1) =~ "no developer tools were found" ]] || [[ ! -x /usr/bin/gcc ]]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
fi

echo 'Ansible install via pip'

if [[ ! -x `which pip` ]]; then
    sudo easy_install pip
fi

if [[ -x `which pip` && ! -x `which ansible` ]]; then
    sudo CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments pip install ansible
fi


if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Info   | Install   | homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo 'Running ansible playbook'

if [[ -x `which ansible` ]]; then
    #echo "Hello Word"
    ansible-playbook -i hosts main.yml --ask-sudo-pass
fi
