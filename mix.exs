defmodule PKCS7Verify.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :pkcs7_verify_api,
     description: "PKCS7 signature verification service",
     package: package(),
     version: @version,
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [coveralls: :test],
     docs: [source_ref: "v#\{@version\}", main: "readme", extras: ["README.md"]]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [extra_applications: [:logger, :confex, :runtime_tools, :cowboy, :httpoison,
                          :poison, :phoenix, :multiverse, :eview,
                          :asn1, :crypto, :public_key],
     mod: {PKCS7Verify, []}]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:distillery, "~> 1.2"},
     {:confex, "~> 1.4"},
     {:cowboy, "~> 1.1"},
     {:httpoison, "~> 0.11.1"},
     {:poison, "~> 3.1"},
     {:phoenix, "~> 1.3.0-rc"},
     {:multiverse, "~> 0.4.3"},
     {:eview, "~> 0.10.1"},
     {:benchfella, ">= 0.3.4", only: [:dev, :test]},
     {:ex_doc, ">= 0.15.0", only: [:dev, :test]},
     {:excoveralls, ">= 0.5.0", only: [:dev, :test]},
     {:dogma, ">= 0.1.12", only: [:dev, :test]},
     {:credo, ">= 0.5.1", only: [:dev, :test]}]
  end

  # Settings for publishing in Hex package manager:
  defp package do
    [contributors: ["Nebo #15"],
     maintainers: ["Nebo #15"],
     licenses: ["LISENSE.md"],
     links: %{github: "https://github.com/Nebo15/pkcs7_verify.api"},
     files: ~w(lib LICENSE.md mix.exs README.md)]
  end
end
