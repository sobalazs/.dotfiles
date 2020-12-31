#!/bin/bash
amixer -sq <<-EOF
  set Master toggle
  set Headphone toggle
EOF
