#
# Author:: Joe Williams (<joe@joetify.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_plugin "languages"
output = nil

status = popen4("erl +V") do |pid, stdin, stdout, stderr|
  stdin.close
  output = stderr.gets.split
end

if status == 0
  languages[:erlang] = Mash.new

  options = output[1]
  options.gsub!(/(\(|\))/, '')

  languages[:erlang][:version] = output[5]
  languages[:erlang][:options] = options.split(',')
  languages[:erlang][:emulator] = output[2].gsub!(/(\(|\))/, '')
end

