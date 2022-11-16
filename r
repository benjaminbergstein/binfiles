#!/usr/bin/env node

const { AutoComplete } = require('enquirer')

const flagMap = {
  "Basic": "",
  "Interactive": "-i",
  "Continue": "--continue",
  "Skip": "--skip",
  "Abort": "--abort",
}

const args = Array.prototype.slice.apply(process.argv)
args.shift()
args.shift()

const prompt = new AutoComplete({
  name: 'What do you want to do?',
  message: '',
  limit: 10,
  choices: [
    "Basic",
    "Interactive",
    "Continue",
    "Skip",
    "Abort",
  ]
});

const { spawn } = require('child_process')

const exec = async (cmd, args) => {
  return new Promise((res, rej) => {
    const shell = spawn(cmd, args, { stdio: 'inherit' })
    shell.on('close', res)
  })
}

const sh = async (cmd, args) => {
  return new Promise((res, rej) => {
    let result = ""
    const shell = spawn(cmd, args)
    shell.stdout.on('data', function(data) {
      result += data.toString();
    });
    shell.on('close', (code) => res([result, code]))
  })
}

async function getCurrentBranch () {
  const answer = await sh('current-branch')
  const currentBranch = answer[0].split("\n")[0]
  return currentBranch
}

async function main () {
  const gitFetch = exec("git", ["fetch"])
  const argsMap = {
    "^": "remotes/origin/main",
    ".": `remotes/origin/${await getCurrentBranch()}`,
  }

  try {
    const answer = await prompt.run()
    const flag = flagMap[answer]

    if (argsMap[args[0]]) args[0] = argsMap[args[0]]
    if (flag === '-i') args.unshift('--autosquash')
    if (flag != "") args.unshift(flag)
    await gitFetch
    await exec("git", ["rebase", ...args])
  } catch (e) {
    console.error(e)
  }
}

main()
