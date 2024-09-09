# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Notebutler < Formula
  desc "A little cli for managing your notes."
  homepage "https://nb.flvffy.xyz/"
  url "https://github.com/marcusleonas/notebutler/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "52b5fd3a48f7b2f30ddf9147c94d567cdeb252d22b90f5730ed90e7e0e3d4699"
  license "MIT"
  head "https://github.com/marcusleonas/notebutler.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    # Remove unrecognized options if they cause configure to fail
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", "--disable-silent-rules", *std_configure_args
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args

    system "go build -o bin/notebutler"
    bin.install "bin/notebutler"
    generate_completions_from_executable(bin/"notebutler", "completion")
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test notebutler`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    # system "false"
    assert_match "notebutler version #{version}", shell_output("#{bin}/notebutler --version")
  end
end
