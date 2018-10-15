# frozen_string_literal: true

class FramesController < ApplicationController
  def home; end

  def main_index
    render layout: false
  end

  def sidebar
    # links = [{url: 'http://www.google.ch', title: 'Google', group: "A"},
    #           {url: 'http://e-request.ch', title: 'e-Request', group: "A"}]
    links = []
    @folders = Dir.glob(Rails.root.join('public', 'docs', '*'))
    @folders.each do |folder|
      dir = Pathname(folder).split.last.to_s
      # Pathname.new("/my/to/somewhere/id").split.first.to_s
      # puts dir
      links << { url: "/docs/#{dir}/", title: dir.camelcase, group: 'A' }
    end

    @grouped_links = links.group_by { |i| i[:group] }
  end
end
