#!/bin/sh
bundle install
exec bundle exec github_changelog_generator "$@"