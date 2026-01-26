#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if grep -q "cmake_minimum_required(VERSION 2.8.12)" build/cmake/modules/cotire.cmake; then
  git apply --verbose --ignore-space-change --whitespace=fix "${script_dir}/0001-wxwidgets-cotire-cmake-min.patch"
fi

if grep -q "cmake_minimum_required(VERSION 2.8.12)" build/cmake/modules/cotire_test/CMakeLists.txt; then
  git apply --verbose --ignore-space-change --whitespace=fix "${script_dir}/0002-wxwidgets-cotire-test-cmake-min.patch"
fi
