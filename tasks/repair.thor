# encoding: utf-8

# TODO: run it as git hook before commit
class Repair < Thor
  desc "all", "Repair encoding, shebang and whitespace"
  def all
    self.encoding
    self.shebang
    self.whitespace
    self.eof
  end

  desc "encoding", "Add missing coding declaration"
  def encoding
    ruby_files do |file, lines, original|
      unless lines[0].match(/^# coding: utf-8\s*$/)
        puts "Added missing coding declaration to #{file}"
        lines.insert(0, "# coding: utf-8\n\n")
        self.save(file, lines)
      end
    end
  end

  desc "shebang", "Add missing shebang and do it executable if it isn't"
  def shebang
    root = File.join(File.dirname(__FILE__), "..")
    Dir["#{root}/bin/*"].each do |file|
      lines = File.readlines(file)
      # is executable but hasn't shebang
      if File.executable?(file) && ! lines[0].match(/^#!/)
        # TODO
      # isn't executable and has shebang
      elsif ! File.executable?(file)
        system("chmod +x '#{file}'")
      end
    end
  end

  desc "whitespace", "Remove extra whitespace"
  def whitespace
    ruby_files do |file, lines, original|
      lines = original.map { |line| line.chomp(" ") }
      if original != lines
        puts "Removed extra whitespace from #{file}"
        self.save(file, lines)
      end
    end
  end

  desc "eof", "Add missing \\n to the end of files"
  def eof
    ruby_files do |file, lines, original|
      unless original.last.match(/\n$/)
        puts "Added missing \\n to the end of #{file}"
        self.save(file, lines)
      end
    end
  end

  protected
  def save(file, lines)
    File.open(file, "w") do |file|
      file.puts(lines)
    end
  end

  def ruby_files(&block)
    root = File.dirname(__FILE__)
    Dir["#{root}/**/*.{rb,ru,thor}"].each do |file|
      original = File.readlines(file)
      lines = original.each { |line| line.chomp }
      block.call(file, lines, original)
    end
  end
end