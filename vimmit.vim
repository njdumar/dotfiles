function! Reddit()

python << EOF

# the vim module contains everything we need to interface with vim from
# python. We need urllib2 for the web service consumer.
import vim, urllib2

# we need json for parsing the response
import json

# we define a timeout that we'll use in the API call. We don't want
# users to wait much.
TIMEOUT = 20
URL = "http://reddit.com/.json"

try:

    f = open(vim.current.buffer.name)
    lines = f.readlines()
    f.close()

    # vim.current.buffer is the current buffer. It's list-like object.
    # each line is an item in the list. We can loop through them delete
    # them, alter them etc.
    # Here we delete all lines in the current buffer
    # del vim.current.buffer[:]

    start_date = ""
    metadata = False

    # Here we append some lines above. Aesthetics.
    vim.current.buffer[0] = vim.current.buffer[0] + 10*"-" + vim.current.buffer.name

    for index, line in enumerate(lines):

        # Strip out the newline at the end
        line = line[:-1]

        if line == "---Metadata---":
            metadata = True
            continue

        if line == "---End Metadata---":
            metadata = False
            continue

        #Parse out the metadata
        if metadata:
            if "StartData=" in line:
                start = line.split('=', 2)
                start_date = start[1]

            else:
                vim.current.buffer[index] = line + " meta2"

        else:
            vim.current.buffer[index] = line + " Hello"


except Exception, e:
    print e

EOF
endfunction
