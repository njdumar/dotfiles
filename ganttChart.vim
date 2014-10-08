function! GenerateGanttChart()

python << EOF

import vim, urllib2, re

try:

    f = open(vim.current.buffer.name)
    lines = f.readlines()
    f.close()

    # vim.current.buffer is the current buffer. It's list-like object.
    # each line is an item in the list. We can loop through them delete
    # them, alter them etc.
    # Here we delete all lines in the current buffer
    # del vim.current.buffer[:]

    # TODO: Error handling for invalid user data in the fields
    # TODO: Don't use tabs??????

    start_date = ""
    metadata = False
    notes = False
    totalTime = 0

    # Find the metadata at the end of the file
    for index, line in enumerate(lines):

        # SKip the first line
        if index == 0:
            continue

        # Strip out the newline at the end
        line = line[:-1]

        if line == "---Metadata---":
            metadata = True
            continue

        if line == "---EndMetadata---":
            metadata = False
            continue

        if line == "---Notes---":
            notes = True
            continue

        if line == "---EndNotes---":
            notes = False
            continue

        if line == "":
            continue

        #Parse out the metadata
        if metadata:
            if "StartData=" in line:
                start = line.split('=', 2)
                start_date = start[1]

            else:
                vim.current.buffer[index] = line + " meta2"

        elif notes == False:
            # Gather the usefull data in the line. Name, time esitmate, time spent, etc
            data = line.split('|', 2)
            elements = re.split(r'\t+', data[0])
            name = elements[0]
            timeEst = int(elements[1].strip())
            timeSpent = int(elements[2].strip())
            complete = elements[3].strip()

            lineGraph = " " * totalTime

            # Create the bar graph line
            if timeSpent == timeEst:
                lineGraph += "+" * timeSpent

            elif timeSpent < timeEst:
                lineGraph += "+" * timeSpent + "=" * (timeEst - timeSpent)

            else:
                lineGraph += "+" * timeEst + "-" * (timeSpent - timeEst)

            # If the task is complete, the next task starts after the total time spend, even if the estimate is larger. This
            # is so track the original estimate as well as keep everything in line with time
            if complete == "Y":
                totalTime += timeSpent

            else:
                totalTime += max(timeEst, timeSpent)

            # rewrite the line in the vim buffer
            vim.current.buffer[index] = data[0] + "|" + lineGraph


except Exception, e:
    print e

EOF
endfunction
