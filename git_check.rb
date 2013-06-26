#!/usr/bin/env ruby

check_cmd = "git log --oneline --branches --not --remotes"

submodules = %x[git submodule]
# $ git submodule
# 546061b752baca81544a3f99b6239c2fa7034433 llp-common (heads/master-5-g546061b)

details = %x[#{check_cmd}]
unpushed = details.lines.count

puts "Checking main repo for unpushed commits..."

# exit with an error code, since you have unpushed changes in a submodule
# and would break the build for others if you pushed it.
if unpushed > 0
    puts "**********************************************************"
    puts " You have #{unpushed} unpushed commits in your main repo"
    details.lines.each { |l| puts "     #{l}" }
    puts "**********************************************************"
end

exit 0 if submodules.empty?

proj_home = Dir.pwd

submodules.each_line do |submodule_line|
  submodule = submodule_line.split
  sub_hash = submodule[0]
  sub_name = submodule[1]
  sub_ref = submodule[2]

  puts "Checking [#{sub_name}] submodule for unpushed commits..."

  Dir.chdir sub_name
  details = %x[#{check_cmd}]
  unpushed = details.lines.count

  # exit with an error code, since you have unpushed changes in a submodule
  # and would break the build for others if you pushed it.
  if unpushed > 0
    puts "**********************************************************"
    puts " You have #{unpushed} unpushed commits within #{sub_name}:"
    details.lines.each { |l| puts "     #{l}" }
    puts "**********************************************************"

    puts "Aborting push."
    exit unpushed
  end

  Dir.chdir proj_home
end

puts "Seems all submodule commits you refer to are reachable"
