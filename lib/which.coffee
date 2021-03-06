{BufferedProcess} = require 'atom'

module.exports = svn =
  cmd: (args, options={ env: process.env }) ->
    new Promise (resolve, reject) ->
      output = ''
      try
        new BufferedProcess
          command: 'which'
          args: args
          options: options
          stdout: (data) -> output += data.toString()
          stderr: (data) ->
            output += data.toString()
          exit: (code) ->
            if code is 0
              resolve output
            else
              reject output
      catch
        notifier.addError 'Atom Svn is unable to locate the which command. Please ensure process.env.PATH can access which.'
        reject "Couldn't find which"
