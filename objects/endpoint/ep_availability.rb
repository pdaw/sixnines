# encoding: utf-8
#
# Copyright (c) 2017 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#
# Availability of endpoint
#
class EpAvailability
  def initialize(endpoint)
    @endpoint = endpoint
  end

  def to_f
    h = @endpoint.to_h
    if h[:pings].zero?
      0
    else
      [
        (100 * (1 - h[:failures] / h[:pings])).round(
          Math.log10(h[:pings]).to_i
        ),
        99.0
      ].min
    end
  end

  def to_s
    format('%.04f', to_f)
  end

  def short
    to_s + '%'
  end

  def full
    h = @endpoint.to_h
    "#{short} (#{h[:failures]}/#{h[:pings]})"
  end
end