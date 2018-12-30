class GooglePhotosBackup < Formula
    desc "Backup your Google Photos"
    homepage "https://github.com/rupert/google-photos-backup"
    url "https://github.com/rupert/google-photos-backup/archive/0.1.0.tar.gz"
    sha256 "b97830b7f3072a7aa021c81f384c61db2a87ea8c7eef02ae008e7be0487f3ba8"

    depends_on "dep" => :build
    depends_on "go" => :build

    def install
      ENV["GOPATH"] = buildpath
      dir = buildpath / "src/github.com/rupert/google-photos-backup"
      dir.install Dir["*"]

      cd dir do
        system "dep", "ensure", "-vendor-only"
        system "go", "build", "-o", bin / "google-photos-backup"
      end
    end

    test do
      system "#{bin}/google-photos-backup", "--help"
    end
  end
