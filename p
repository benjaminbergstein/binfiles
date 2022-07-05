#!/usr/bin/env node

const { AutoComplete } = require('enquirer')

const stageChoice = "Stage changes"
const commitChoice = "Make a new commit (default: amend previous)."
const pushChoice = "Push code"
const createPrChoice = "Create PR"
const updatePrChoice = "Update PR"

const prompt = new AutoComplete({
  name: 'What do you want to do?',
  message: '',
  limit: 10,
  initial: [0, 2],
  multiple: true,
  choices: [
    stageChoice,
    commitChoice,
    pushChoice,
    createPrChoice,
    updatePrChoice,
  ]
});

const { spawn } = require('child_process')

const exec = async (cmd, args) => {
  return new Promise((res, rej) => {
    const shell = spawn(cmd, args, { stdio: 'inherit' })
    shell.on('close',res)
  })
}

async function main () {
  try {
    answer = await prompt.run()
    const doStage = answer.includes(stageChoice)
    const doCommit = answer.includes(commitChoice)
    const doPush = answer.includes(pushChoice)
    const doCreatePr = answer.includes(createPrChoice)
    const doUpdatePr = answer.includes(updatePrChoice)

    if (doStage) {
      console.log("git add -p")
      await exec("git", ["add", "-p"])
    }

    if (doCommit) {
      await exec("git", ["commit"])
    } else {
      await exec("git", ["commit", "--amend", "--no-edit"])
    }

    if (doPush) {
      await exec("git", ["push", "--force-with-lease"])
    }

    if (doCreatePr) {
      await exec("gh", ["pr", "create", "--draft"])
    }

    if (doUpdatePr) {
      await exec("gh", ["pr", "edit"])
    }
  } catch (e) {
    console.error(e)
  }
}

main()
