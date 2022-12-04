{ lib, stdenv, buildPythonPackage, fetchFromGitHub, requests
, pytestCheckHook, tzlocal, pytest-mock, pytest-freezegun, pytest-raisin
, pytest-socket, requests-mock, pebble, python-dateutil, termcolor
, beautifulsoup4, setuptools
}:

buildPythonPackage rec {
  pname = "aocd";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "wimglenn";
    repo = "advent-of-code-data";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-xns//QAAYw9+Md0THUxFUxnqCDoS1qGslX6CFbIALng=";
  };

  propagatedBuildInputs = [
    python-dateutil
    requests
    termcolor
    beautifulsoup4
    pebble
    tzlocal
    setuptools
  ];

  # Too many failing tests
  preCheck = "rm pytest.ini";

  disabledTests = [
    "test_results"
    "test_results_xmas"
    "test_run_error"
    "test_run_and_autosubmit"
    "test_run_and_no_autosubmit"
    "test_load_input_from_file"
  ];

  checkInputs = [
    pytestCheckHook
    pytest-mock
    pytest-freezegun
    pytest-raisin
    pytest-socket
    requests-mock
  ];

  pythonImportsCheck = [ "aocd" ];

  meta = with lib; {
    homepage = "https://github.com/wimglenn/advent-of-code-data";
    description = "Get your Advent of Code data with a single import statement";
    license = licenses.mit;
    maintainers = with maintainers; [ aadibajpai ];
    platforms = platforms.unix;
  };
}
