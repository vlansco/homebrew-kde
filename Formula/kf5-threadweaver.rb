class Kf5Threadweaver < Formula
  desc "High-level multithreading framework"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/threadweaver-5.56.0.tar.xz"
  sha256 "bd300ce0dc7d8b796fdcc257b9d27eb3f35cdcdef18611a146d3c11f3690dbbf"

  revision 1
  head "git://anongit.kde.org/threadweaver.git"
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "qt"

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
end
