{
  pkgs,
  ...
}:
{
  packages = [
    pkgs.air
    pkgs.delve
    pkgs.go-mockery
    pkgs.gofumpt
    pkgs.goimports-reviser
    pkgs.golangci-lint
    pkgs.gotestsum
    pkgs.oapi-codegen
    pkgs.protoc-gen-go
    pkgs.sqlc
  ];

  languages.go = {
    enable = true;
    enableHardeningWorkaround = true;
  };

  scripts.mocks.exec = "mockery";
  scripts.sqlc.exec = "sqlc generate";
  scripts.test.exec = "gotestsum --junitfile unit-tests.xml";

  enterShell = ''
    air -v
    go version
    gofumpt --version
    goimports-reviser -version-only
    golangci-lint --version
    gotestsum --version
    mockery version
    oapi-codegen --version
    protoc --version
    sqlc version
  '';
}
