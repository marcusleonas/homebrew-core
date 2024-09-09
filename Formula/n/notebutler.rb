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
    system "go build -o bin/notebutler"
    bin.install "bin/notebutler"
    generate_completions_from_executable(bin/"notebutler", "completion")
  end

  test do
    assert_match "notebutler version #{version}", shell_output("#{bin}/notebutler --version")
  end
end
