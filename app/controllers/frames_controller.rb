# frozen_string_literal: true

class FramesController < ApplicationController
  def home; end

  def main_index
    render layout: false
  end

  def sidebar
    links = []

    top_level_dirs = Dir.glob(doc_root.join('*/'))
    top_level_dirs.each do |level_1|
      level_1_dir = Pathname(level_1)
      level_2_dirs = Dir.glob(level_1_dir.join('*/'))

      had_index = false
      # list all files in this subfolder directly
      Dir.glob(level_1_dir.join('*.*')).each do |file|
        filename = File.basename(file, ".*")
        had_index = true if filename == 'index'
        links << { url: public_path(file), title: filename.camelcase, group: level_1_dir.split.last.to_s }
      end

      unless had_index
        # check if we have an index.html - if so, show this and skip subfolders
        level_2_dirs.each do |level_2|
          level_2_dir = Pathname(level_2)
          dir = level_2_dir.split.last.to_s
          links << { url: public_path(level_2_dir), title: dir.camelcase, group: level_1_dir.split.last.to_s }
        end
      end

    end

    @grouped_links = links.sort_by { |a| a[:group] }.group_by { |i| i[:group] }
  end


  private

  def public_path(folder_path)
    folder = folder_path.to_s.gsub(doc_root.to_s, '')
    "/docs/#{folder}"
  end

  def doc_root
    Rails.root.join('public', 'docs')
  end

end
