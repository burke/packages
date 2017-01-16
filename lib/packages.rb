require "packages/version"

module Packages
  IVAR_NAME = "@__package_name__"

  def self.verify_access(from, constant_value)
    # TODO: should we store these on the classes or in a central store?
    return unless fp = from.instance_variable_get(IVAR_NAME)
    return unless tp = constant_value.instance_variable_get(IVAR_NAME)
    return if fp == tp
    return if Packages.imports?(fp, tp)
    raise ::VisibilityError, "can't access #{constant_value} from #{from}"
  end

  @@by_file = {}
  @@imports = {}

  def self.set_for_file(file, name)
    if n = @@by_file[file]
      raise "package for #{File.basename(file)} already set to `#{n}`" unless name == n
    end
    @@by_file[file] = name
  end

  def self.for_file(file)
    @@by_file[file]
  end

  def self.add_import(from, to)
    @@imports[from] ||= []
    @@imports[from] << to
  end

  def self.imports?(from, to)
    a = @@imports[from]
    a && a.include?(to)
  end

  module Prelude
    VisibilityError = Class.new(TypeError)

    def package(name)
      md = caller[0].match(/(.*):\d+:in/)
      raise unless md # TODO: eval context, etc.
      file = md[1]
      raise unless file
      Packages.set_for_file(file, name)
    end

    def import(pkg)
      md = caller[0].match(/(.*):\d+:in/)
      raise unless md # TODO: eval context, etc.
      file = md[1]
      raise unless file
      from = Packages.for_file(file)
      raise "`import` may only be called in a `package` context" unless from
      Packages.add_import(from, pkg)
    end
  end

  CONSTANT_ACCESS_TRACEPOINT = TracePoint.new(:constant_access) do |tp|
    Packages.verify_access(tp.self, tp.constant_value)
  end

  CLASS_TRACEPOINT = TracePoint.new(:class) do |tp|
    if pkg = Packages.for_file(tp.path)
      tp.self.instance_variable_set(IVAR_NAME, pkg)
    end
  end
end

include Packages::Prelude
Packages::CONSTANT_ACCESS_TRACEPOINT.enable
Packages::CLASS_TRACEPOINT.enable
