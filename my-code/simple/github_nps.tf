provider "github" {
  organization = "nullpointersolutions"
}

resource "github_repository" "example" {
  name        = "example"
  description = "My awesome codebase"

  private = true

}
