# encoding: utf-8

class Hooks < Thor
  # TODO: force option
  desc "all", "Install all git hooks"
  def all
    if Dir.exist?(".git/hooks")
      abort "You must remove .git/hooks first"
    else
      # do not symlink them, otherwise git will add samples
      # FIXME: permissions
      FileUtils.cp_r("support/hooks", ".git/hooks")
    end
  end

  desc "install [*hooks]", "Install given git hook"
  def install(*names)
    names.each do |name|
      if File.file?(".git/hooks/#{name}")
        abort "File .git/hooks/#{name} already exists. Please remove it first."
      else
        FileUtils.cp("support/hooks/#{name}", ".git/hooks/#{name}")
      end
    end
  end
end
