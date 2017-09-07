defmodule Fw.Mixfile do
  use Mix.Project

  default_target = fn -> case Mix.env do
                           :prod -> "rpi0"
                           _ -> "host"
                         end
  end

  @target System.get_env("MIX_TARGET") || default_target.()

  Mix.shell.info([:green, """
  Mix environment
    MIX_TARGET:   #{@target}
    MIX_ENV:      #{Mix.env}
  """, :reset])

  def project do
    [app: :fw,
     version: "0.1.0",
     elixir: "~> 1.4",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.6"],
     deps_path: "../../deps/#{@target}",
     build_path: "../../_build/#{@target}",
     config_path: "../../config/config.exs",
     lockfile: "../../mix.lock.#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(@target),
     deps: deps()]
  end

  def application, do: application(@target)

  def application("host") do
    [extra_applications: [:logger]]
  end
  def application(_target) do
    [mod: {Fw.Application, []},
     extra_applications: [:logger]]
  end

  def deps do
    [
      {:nerves, "~> 0.7", runtime: false},
    ] ++
    deps(@target)
  end

  # Specify target specific dependencies
  def deps("host"), do: []
  def deps(target) do
    [ system(target),
      {:bootloader, "~> 0.1"},
      {:nerves_runtime, "~> 0.4"}
    ]
  end

  def system("rpi0"), do: {:nerves_system_rpi0, ">= 0.0.0", runtime: false}

  # We do not invoke the Nerves Env when running on the Host
  def aliases("host"), do: []
  def aliases(_target) do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end
end
