class Kf5Ktexteditor < Formula
  desc "Advanced embeddable text editor"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/ktexteditor-5.56.0.tar.xz"
  sha256 "4c88d0033775e0715ad115370a36680ede95d29c7c4b840c0e06f23ef64959a8"

  revision 1
  head "git://anongit.kde.org/ktexteditor.git"
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-syntax-highlighting"
  depends_on "libgit2"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/katepart5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kdevappwizard" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
  EOS
  end
end
