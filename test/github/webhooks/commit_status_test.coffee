Fs   = require "fs"
Path = require "path"

srcDir = Path.join(__dirname, "..", "..", "..", "src")

GitHubEvents     = require(Path.join(srcDir, "github", "webhooks"))
CommitStatus = GitHubEvents.CommitStatus

describe "GitHubEvents.CommitStatus fixtures", () ->
  deploymentStatusFor = (fixtureName) ->
    fixtureData = Path.join __dirname, "..", "..", "fixtures", "statuses", "#{fixtureName}.json"
    fixturePayload = JSON.parse(Fs.readFileSync(fixtureData))
    status = new CommitStatus "uuid", fixturePayload

  describe "pending", () ->
    it "knows the status and repo", () ->
      status = deploymentStatusFor "pending"
      assert.equal status.state, "pending"
      assert.equal status.repoName, "atmos/my-robot"
      assert.equal status.toSimpleString(), "hubot-deploy: commit status for Janky (github) on atmos/1333c01 is running. https://ci.atmos.org/1123112/output"

  describe "failure", () ->
    it "knows the status and repo", () ->
      status = deploymentStatusFor "failure"
      assert.equal status.state, "failure"
      assert.equal status.repoName, "atmos/my-robot"
      assert.equal status.toSimpleString(), "hubot-deploy: commit status for Janky (github) on my-robot/f911111 failed. https://baller.com/target_stuff"

  describe "success", () ->
    it "knows the status and repo", () ->
      status = deploymentStatusFor "success"
      assert.equal status.state, "success"
      assert.equal status.repoName, "atmos/my-robot"
      assert.equal status.toSimpleString(), "hubot-deploy: commit status for Janky (github) on github/1333c01 was successful. https://ci.atmos.org/1123112/output"
